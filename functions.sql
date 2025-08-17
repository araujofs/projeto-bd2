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
-- Função para 
create
or replace function
-- 1 procedure com justificativa semântica, conforme os requisitos da aplicação
-- Procedure para registrar retirada de uma encomenda
create
or replace procedure registra_retirada_encomenda (
  encomenda_id_prm INTEGER,
  hospede_id_prm INTEGER DEFAULT NULL,
  morador_id_prm INTEGER DEFAULT NULL,
) as $$
begin



  exception
    
end; $$ language plpgsql;

drop function conta_encomenda_ap;

select
  conta_encomenda_ap (1);