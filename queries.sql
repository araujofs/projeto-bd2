/* 10 consultas variadas de acordo com requisitos da aplicação, com justificativa
semântica e conforme critérios seguintes: */
-- 1 consulta com uma tabela usando operadores básicos de filtro (e.g., IN, between, is null, etc).
-- Consulta para saber os porteiros que trabalham de manhã e de tarde, excluindo a noite
select
  nome
from
  porteiro
where
  turno in ('m', 't');

-- 3 consultas com inner JOIN na cláusula FROM (pode ser self join, caso o domínio indique esse uso).
-- Consulta para listar as encomendas de um determinado usuário que ainda não foram pegas
select
  m.nome,
  e.cod_rastreio,
  p.nome as porteiro_recebeu
from
  encomenda e
  join porteiro p on e.porteiro_matricula = p.matricula
  join morador m on e.morador_id_destino = m.id
where
  m.id = 2
  and e.morador_id_pega is null
  and e.hospede_id is null;

-- Reescrita (dessa maneira fica mais semântico e simples)
select
  m.nome,
  e.cod_rastreio,
  p.nome as porteiro_recebeu
from
  encomenda e
  join porteiro p on e.porteiro_matricula = p.matricula
  join morador m on e.morador_id_destino = m.id
where
  m.id = 2
  AND coalesce(e.morador_id_pega, hospede_id) is null;

-- Consulta para listar todos os moradores autorizados a pegar as encomendas de outro morador específico
select
  ma.nome as autorizado,
  md.nome as autorizador
from
  morador ma
  join morador_autoriza_morador mam on ma.id = mam.morador_autorizado_id
  join morador md on mam.morador_autoriza_id = md.id
where
  md.id = 1;

-- Consulta para listar todos os hóspedes de um determinado apartamento
select
  h.nome,
  a.numero || a.bloco as apartamento
from
  hospede h
  join apartamento a on h.apartamento_id = a.id
where
  a.id = 12;

-- 1 consulta com left/right/full outer join na cláusula FROM
-- Consulta para listar todas as encomendas recebidas nos últimos 7 dias
select
  e.cod_rastreio,
  e.porteiro_recebe_data,
  md.nome as nome_destinatario,
  coalesce(e.hospede_pega_data, e.morador_pega_data) as data_retirada,
  coalesce(mp.nome, h.nome) as quem_retirou,
  case
    when coalesce(e.hospede_pega_data, e.morador_pega_data) is not null then 'retirada'
    else 'pendente'
  end as status
from
  encomenda e
  join morador md on e.morador_id_destino = md.id
  left join morador mp on e.morador_id_pega = mp.id
  left join hospede h on e.hospede_id = h.id
where
  e.porteiro_recebe_data >= now() - interval '7 days';

-- Reescrita para evitar dois coalesces iguais
with
  encomenda_sete_dias as (
    select
      e.cod_rastreio,
      e.porteiro_recebe_data,
      md.nome as nome_destinatario,
      coalesce(e.hospede_pega_data, e.morador_pega_data) as data_retirada,
      coalesce(mp.nome, h.nome) as quem_retirou
    from
      encomenda e
      join morador md on e.morador_id_destino = md.id
      left join morador mp on e.morador_id_pega = mp.id
      left join hospede h on e.hospede_id = h.id
    where
      e.porteiro_recebe_data >= now() - interval '7 days'
  )
select
  cod_rastreio,
  porteiro_recebe_data,
  nome_destinatario,
  data_retirada,
  quem_retirou,
  case
    when data_retirada is not null then 'retirada'
    else 'pendente'
  end as status
from
  encomenda_sete_dias;

-- 2 consultas usando Group By (e possivelmente o having)
-- Consulta para um morador saber quantas encomendas recebeu em um intervalo de tempo
select
  m.nome,
  count(e.id) as quantidade_encomendas
from
  morador m
  join encomenda e on e.morador_id_destino = m.id
where
  m.cpf = '22222222222'
  and porteiro_recebe_data >= (now() - interval '30 days')
group by
  m.id;

-- Consulta para saber quantas encomendas foram recebidas de cada apartamento em um intervalo determinado de tempo
select
  a.numero || a.bloco as apartamento,
  count(e.id) as quantidade_encomendas
from
  apartamento a
  join morador m on m.apartamento_id = a.id
  join encomenda e on e.morador_id_destino = m.id
where
  e.porteiro_recebe_data >= (now() - interval '15 days')
group by
  a.id;

-- 1 consulta usando alguma operação de conjunto (union, except ou intersect)
-- Consulta para exibir todos os moradores juntamente com hóspedes do condomínio cadastrados
select
  nome,
  email
from
  morador
union
select
  nome,
  email
from
  hospede;

-- 2 consultas que usem subqueries.
-- Consulta para mostrar quantas encomendas cada morador e hospede pegou mesmo as que não sõo suas num tempo determinado
select
  m.nome,
  (
    select
      count(*)
    from
      encomenda
    where
      morador_id_pega = m.id
      and morador_pega_data >= (now() - interval '7 days')
  ) as encomendas_pegas,
  'morador' as tipo_usuario
from
  morador m
union
select
  h.nome,
  (
    select
      count(*)
    from
      encomenda
    where
      hospede_id = h.id
      and hospede_pega_data >= (now() - interval '7 days')
  ) as encomendas_pegas,
  'hóspede' as tipo_usuario
from
  hospede h;

-- Consulta para verificar quantos moradores e quantos hóspedes estão em um apartamento específico
select
  ap.numero || ap.bloco as "apartamento",
  (
    select
      count(*)
    from
      morador
    where
      apartamento_id = ap.id
  ) as quant_moradores,
  (
    select
      count(*)
    from
      hospede
    where
      apartamento_id = ap.id
  ) as quant_hospedes
from
  apartamento ap
where
  ap.id = 15;

/* Views */
-- 1 que permita inserção
-- View para visualizar os pares autorizador-autorizado de maneira mais simples, dado que essa operação envolve dois joins
create or replace view
  morador_hospede_autorizacoes as
select
  m.id as morador_id,
  m.nome as autorizador,
  h.id as hospede_id,
  h.nome as autorizado
from
  morador m
  join morador_autoriza_hospede mah on m.id = mah.morador_id
  join hospede h on mah.hospede_id = h.id
order by
  m.nome;

create
or replace function insert_view_morador_hospede () returns trigger as $$
begin
  if (select nome from morador where id = new.morador_id) is null then
    raise exception 'Morador não encontrado com id: %', new.morador_id;
  end if;

  if (select nome from hospede where id = new.hospede_id) is null then
    raise exception 'Hospede não encontrado com id: %', new.hospede_id;
  end if;

  insert into morador_autoriza_hospede values (new.morador_id, new.hospede_id);

  return null;
end;
$$ language plpgsql;

create trigger trg_ins_view_morador_hospede_autorizacoes instead of insert on morador_hospede_autorizacoes for each row
execute function insert_view_morador_hospede ();

-- 2 visões robustas (e.g., com vários joins) com justificativa semântica, de acordo com os requisitos da aplicação.
-- View para visualizar algumas informações do usuário e do seu apartamento, como quantidade de hóspedes e também a quantidade de encomendas ainda para serem pegas
create or replace view
  morador_apartamento as
select
  m.nome,
  m.telefone,
  m.email,
  ap.numero || ap.bloco as apartamento,
  (
    select
      count(*)
    from
      hospede
    where
      apartamento_id = ap.id
  ) as quant_hospedes,
  (
    select
      count(*)
    from
      encomenda
    where
      morador_id_destino = m.id
      and morador_id_pega is null
      and hospede_id is null
  ) as encomendas_pendentes
from
  morador m
  join apartamento ap on m.apartamento_id = ap.id;

-- View para visualizar informações sobre encomenda e também de seu morador e apartamento de destino
create or replace view
  encomenda_destino as
select
  e.cod_rastreio,
  e.porteiro_recebe_data as data_recebimento,
  p.nome as nome_porteiro,
  ap.numero || ap.bloco as apartamento_destino,
  m.nome as morador_destino,
  m.telefone as telefone_morador,
  m.email as email_morador
from
  encomenda e
  join porteiro p on e.porteiro_matricula = p.matricula
  join morador m on e.morador_id_destino = m.id
  join apartamento ap on m.apartamento_id = ap.id;

/* Indexes */
-- Índice para acelerar buscas por apartamento a partir de morador
create index idx_morador_apartamento_id on morador (apartamento_id);

-- Indíce para acelerar buscas por morador de destino associado à uma encomenda
create index idx_encomenda_morador_id_destino on encomenda (morador_id_destino);

-- Índice para acelerar buscas por apartamento a partir de hospede
create index idx_hospede_apartamento_id on hospede (apartamento_id);