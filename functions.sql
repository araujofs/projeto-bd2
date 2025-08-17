-- 1 função que use SUM, MAX, MIN, AVG ou COUNT
-- Função para contar as encomendas pendentes para um apartamento
create
or replace function conta_encomenda_ap (apartamento_id integer) returns table (
  apartamento_ext text,
  destino_nome text,
  encomenda_count bigint
) as $$
begin
  return query 
  select 
    (ap.numero::text || ap.bloco)::text as apartamento_ext,
    m.nome as destino_nome, 
    (select count(*) from encomenda where morador_id_destino = m.id)::integer as encomenda_count
  from apartamento ap
  join morador m on ap.id = m.apartamento_id
  where ap.id = $1;
end;
$$ language plpgsql;

-- Outras 2 funções com justificativa semântica, conforme os requisitos da aplicação
-- Função para verificar se um morador está autorizado por outro morador a pegar suas encomendas
create
or replace function verifica_autorizacao_morador (
  morador_autorizador_id INTEGER,
  morador_verifica_id INTEGER
) returns boolean as $$
begin
  if not exists (select id from morador where id = morador_autorizador_id) THEN
    raise exception 'Morador autorizador não existe!';
  end if;

  if morador_autorizador_id = morador_verifica_id then 
    return true;
  end if;

  return exists (
    select morador_autorizado.id from morador morador_autorizado
    join morador_autoriza_morador mam on morador_autorizado.id = mam.morador_autorizado_id
    join morador morador_autorizador on mam.morador_autoriza_id = morador_autorizador.id
    where morador_autorizador.id = morador_autorizador_id AND
    morador_autorizado.id = morador_verifica_id
  );

  exception
    when others then 
      raise notice 'Erro: %', sqlerrm;
      return false;
end;
$$ language plpgsql;

-- Função para verificar se um hóspede está autorizado por um morador a pegar suas encomendas
create
or replace function verifica_autorizacao_hospede (
  morador_autorizador_id INTEGER,
  hospede_verifica_id INTEGER
) returns boolean as $$
begin
  if not exists (select id from morador where id = morador_autorizador_id) THEN
    raise exception 'Morador autorizador não existe!';
  end if;

  return exists (
    select h.id from hospede h
    join morador_autoriza_hospede mah on h.id = mah.hospede_id
    join morador m on mah.morador_id = m.id
    where m.id = morador_autorizador_id AND
    h.id = hospede_verifica_id
  );

  exception
    when others then 
      raise notice 'Erro: %', sqlerrm;
      return false;
end;
$$ language plpgsql;

-- 1 procedure com justificativa semântica, conforme os requisitos da aplicação
-- Procedure para registrar retirada de uma encomenda
create
or replace procedure registra_retirada_encomenda (
  encomenda_id_prm INTEGER,
  hospede_id_prm INTEGER DEFAULT NULL,
  morador_id_prm INTEGER DEFAULT NULL
) as $$
declare
  encomenda_atual encomenda%rowtype default null;
begin
  select * into encomenda_atual from encomenda where id = encomenda_id_prm;

  if encomenda_atual is null then
    raise exception 'Não existe encomenda com esse id!';
  end if;

  if encomenda_atual.hospede_id is not null or encomenda_atual.morador_id_pega is not null then
    raise exception 'Encomenda de id % já foi pega!', encomenda_atual.id;
  end if;

  if hospede_id_prm is not null then
    if not verifica_autorizacao_hospede(encomenda_atual.morador_id_destino, hospede_id_prm) then
      raise exception 'Hóspede de id % não está autorizado a pegar encomendas do morador de destino!', hospede_id_prm;
    end if;

    update encomenda 
    set hospede_id = hospede_id_prm,
    hospede_pega_data = now()
    where id = encomenda_id_prm;
    return;
  end if;

  if morador_id_prm is not null then
    if not verifica_autorizacao_morador(encomenda_atual.morador_id_destino, morador_id_prm) then
      raise exception 'Morador de id % não está autorizado a pegar encomendas do morador de destino!', morador_id_prm;
    end if;

    update encomenda
    set morador_id_pega = morador_id_prm,
    morador_pega_data = now()
    where id = encomenda_id_prm;
    return;
  end if;

  raise exception 'Argumentos inválidos: hospede_id e morador_id são nulos!';

  exception
    when foreign_key_violation then
      raise notice 'Houve um erro ao tentar registrar retirada: usuário que pegou não existe!'; 
    
    when others then
      raise notice 'Houve um erro: %', sqlerrm;
end; 
$$ language plpgsql;
