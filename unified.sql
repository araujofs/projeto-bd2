/* Tabelas e constraints (PK, FK, UNIQUE, campos que não podem ter valores
nulos, checks de validação) de acordo com as regras de negócio do projeto. */
create table
  porteiro (
    matricula SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    turno CHAR(1) NOT NULL CHECK (turno ~* '^[mtn]$'),
    senha VARCHAR(50) NOT NULL
  );

create table
  apartamento (
    id SERIAL PRIMARY KEY,
    numero INTEGER NOT NULL,
    bloco VARCHAR(5) DEFAULT 'A' CHECK (bloco ~ '^[A-Z]{1,5}$'),
    UNIQUE (numero, bloco)
  );

create table
  hospede (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    apartamento_id INTEGER NOT NULL,
    FOREIGN KEY (apartamento_id) REFERENCES apartamento (id)
  );

create table
  morador (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    apartamento_id INTEGER NOT NULL,
    FOREIGN KEY (apartamento_id) REFERENCES apartamento (id)
  );

create table
  encomenda (
    id SERIAL PRIMARY KEY,
    cod_rastreio VARCHAR(30) NOT NULL UNIQUE,
    porteiro_recebe_data TIMESTAMP NOT NULL,
    morador_pega_data TIMESTAMP,
    hospede_pega_data TIMESTAMP,
    porteiro_matricula INTEGER NOT NULL,
    morador_id_destino INTEGER NOT NULL,
    morador_id_pega INTEGER,
    hospede_id INTEGER,
    FOREIGN KEY (porteiro_matricula) REFERENCES porteiro (matricula),
    FOREIGN KEY (morador_id_destino) REFERENCES morador (id),
    FOREIGN KEY (morador_id_pega) REFERENCES morador (id),
    FOREIGN KEY (hospede_id) REFERENCES hospede (id)
  );

create table
  morador_autoriza_morador (
    morador_autoriza_id INTEGER,
    morador_autorizado_id INTEGER,
    FOREIGN KEY (morador_autoriza_id) REFERENCES morador (id),
    FOREIGN KEY (morador_autorizado_id) REFERENCES morador (id),
    PRIMARY KEY (morador_autoriza_id, morador_autorizado_id)
  );

create table
  morador_autoriza_hospede (
    morador_id INTEGER,
    hospede_id INTEGER,
    FOREIGN KEY (morador_id) REFERENCES morador (id),
    FOREIGN KEY (hospede_id) REFERENCES hospede (id),
    PRIMARY KEY (morador_id, hospede_id)
  );

-- Inserção de dados
INSERT INTO
  porteiro (nome, turno, senha)
VALUES
  ('João da Silva', 'M', 'senha123'),
  ('Maria Oliveira', 'T', 'senha123'),
  ('Pedro Santos', 'N', 'senha123'),
  ('Ana Costa', 'M', 'senha123'),
  ('Fernando Mendes', 'T', 'senha123'),
  ('Isabela Rocha', 'N', 'senha123');

INSERT INTO
  apartamento (numero, bloco)
VALUES
  (101, 'A'),
  (102, 'A'),
  (103, 'A'),
  (104, 'A'),
  (105, 'A'),
  (201, 'B'),
  (202, 'B'),
  (203, 'B'),
  (204, 'B'),
  (205, 'B'),
  (301, 'C'),
  (302, 'C'),
  (303, 'C'),
  (304, 'C'),
  (305, 'C'),
  (401, 'D'),
  (402, 'D'),
  (403, 'D'),
  (404, 'D'),
  (405, 'D'),
  (501, 'E'),
  (502, 'E'),
  (503, 'E'),
  (504, 'E'),
  (505, 'E'),
  (601, 'F'),
  (602, 'F'),
  (603, 'F'),
  (604, 'F'),
  (605, 'F');

INSERT INTO
  morador (nome, telefone, cpf, email, senha, apartamento_id)
VALUES
  (
    'Ana Paula Pereira',
    '83999998888',
    '11111111111',
    'ana.paula@email.com',
    'senha123',
    21
  ),
  (
    'Bruno Costa',
    '83999997777',
    '22222222222',
    'bruno.costa@email.com',
    'senha123',
    22
  ),
  (
    'Carlos Eduardo Lima',
    '83999996666',
    '33333333333',
    'carlos.lima@email.com',
    'senha123',
    23
  ),
  (
    'Daniela Martins',
    '83999995555',
    '44444444444',
    'daniela.martins@email.com',
    'senha123',
    24
  ),
  (
    'Eduarda Alves',
    '83999994444',
    '55555555555',
    'eduarda.alves@email.com',
    'senha123',
    25
  ),
  (
    'Felipe Gomes',
    '83999993333',
    '66666666666',
    'felipe.gomes@email.com',
    'senha123',
    26
  ),
  (
    'Leticia Pereira',
    '83999992222',
    '77777777777',
    'leticia.pereira@email.com',
    'senha123',
    27
  ),
  (
    'Gustavo Costa',
    '83999991111',
    '88888888888',
    'gustavo.costa@email.com',
    'senha123',
    28
  ),
  (
    'Henrique Rocha',
    '83988881111',
    '99999999999',
    'henrique.rocha@email.com',
    'senha123',
    29
  ),
  (
    'Isabela Souza',
    '83988882222',
    '10101010101',
    'isabela.souza@email.com',
    'senha123',
    30
  ),
  (
    'Juliana Melo',
    '83988883333',
    '12121212121',
    'juliana.melo@email.com',
    'senha123',
    9
  ),
  (
    'Lucas Fernandes',
    '83988884444',
    '13131313131',
    'lucas.fernandes@email.com',
    'senha123',
    10
  ),
  (
    'Mariana Santos',
    '83988885555',
    '14141414141',
    'mariana.santos@email.com',
    'senha123',
    11
  ),
  (
    'Nicolas Pires',
    '83988886666',
    '15151515151',
    'nicolas.pires@email.com',
    'senha123',
    12
  ),
  (
    'Olivia Lima',
    '83988887777',
    '16161616161',
    'olivia.lima@email.com',
    'senha123',
    13
  ),
  (
    'Paulo Souza',
    '83988888888',
    '17171717171',
    'paulo.souza@email.com',
    'senha123',
    14
  ),
  (
    'Roberta Alves',
    '83988889999',
    '18181818181',
    'roberta.alves@email.com',
    'senha123',
    15
  ),
  (
    'Thiago Mendes',
    '83987771111',
    '19191919191',
    'thiago.mendes@email.com',
    'senha123',
    16
  ),
  (
    'Vivian Costa',
    '83987772222',
    '20202020202',
    'vivian.costa@email.com',
    'senha123',
    17
  ),
  (
    'Walter Ferreira',
    '83987773333',
    '21212121212',
    'walter.ferreira@email.com',
    'senha123',
    18
  ),
  (
    'Xenia Gomes',
    '83987774444',
    '22222122222',
    'xenia.gomes@email.com',
    'senha123',
    19
  ),
  (
    'Yago Lima',
    '83987775555',
    '23232323232',
    'yago.lima@email.com',
    'senha123',
    20
  ),
  (
    'Zoe Santos',
    '83987776666',
    '24242424242',
    'zoe.santos@email.com',
    'senha123',
    1
  ),
  (
    'André Morais',
    '83987777777',
    '25252525252',
    'andre.morais@email.com',
    'senha123',
    3
  ),
  (
    'Bia Rodrigues',
    '83987778888',
    '26262626262',
    'bia.rodrigues@email.com',
    'senha123',
    4
  ),
  (
    'Gabriel Barbosa',
    '83987654321',
    '30303030303',
    'gabriel.b@email.com',
    'senha123',
    1
  ),
  (
    'Fernanda Silva',
    '83987654322',
    '31313131313',
    'fernanda.s@email.com',
    'senha123',
    2
  ),
  (
    'Rafael Oliveira',
    '83987654323',
    '32323232323',
    'rafael.o@email.com',
    'senha123',
    3
  ),
  (
    'Sofia Santos',
    '83987654324',
    '33433333333',
    'sofia.s@email.com',
    'senha123',
    4
  ),
  (
    'Matheus Souza',
    '83987654325',
    '34343434343',
    'matheus.s@email.com',
    'senha123',
    5
  );

INSERT INTO
  hospede (nome, email, apartamento_id)
VALUES
  ('Gabriela Souza', 'gabriela.souza@email.com', 21),
  (
    'Heloisa Ferreira',
    'heloisa.ferreira@email.com',
    23
  ),
  ('Mariana Rocha', 'mariana.rocha@email.com', 29),
  ('Felipe Silva', 'felipe.silva@email.com', 26),
  ('Livia Martins', 'livia.martins@email.com', 15),
  ('Rafaela Castro', 'rafaela.castro@email.com', 25),
  ('Samuel Almeida', 'samuel.almeida@email.com', 12),
  ('Patrícia Lopes', 'patricia.l@email.com', 1),
  ('Tiago Fernandes', 'tiago.f@email.com', 3);

-- Novas autorizações de morador para morador
INSERT INTO
  morador_autoriza_morador (morador_autoriza_id, morador_autorizado_id)
VALUES
  (1, 7),
  (1, 23),
  (2, 8),
  (3, 24),
  (4, 25),
  (5, 6),
  (9, 10),
  (13, 14),
  (18, 19);

-- Novas autorizações de morador para hóspede
INSERT INTO
  morador_autoriza_hospede (morador_id, hospede_id)
VALUES
  (1, 1),
  (3, 2),
  (9, 3),
  (10, 4),
  (15, 5),
  (5, 6),
  (12, 7),
  (26, 8), -- Gabriel Barbosa autoriza Patrícia Lopes
  (28, 9);

-- Rafael Oliveira autoriza Tiago Fernandes
-- Novas encomendas
INSERT INTO
  encomenda (
    cod_rastreio,
    porteiro_recebe_data,
    morador_pega_data,
    porteiro_matricula,
    morador_id_destino,
    morador_id_pega,
    hospede_id
  )
VALUES
  (
    'BR123456789BR',
    '2025-07-28 10:30:00',
    '2025-07-29 15:45:00',
    1,
    1,
    1,
    NULL
  ),
  (
    'BR987654321BR',
    '2025-07-29 11:15:00',
    '2025-07-30 09:20:00',
    2,
    2,
    2,
    NULL
  ),
  (
    'LA111222333LA',
    '2025-07-30 14:00:00',
    '2025-07-31 18:00:00',
    3,
    3,
    3,
    NULL
  ),
  (
    'FR444555666FR',
    '2025-08-01 09:00:00',
    '2025-08-02 11:30:00',
    4,
    4,
    4,
    NULL
  ),
  (
    'US123456789US',
    '2025-08-02 16:20:00',
    '2025-08-03 14:00:00',
    5,
    5,
    5,
    NULL
  ),
  (
    'DE789012345DE',
    '2025-08-03 21:00:00',
    '2025-08-04 07:40:00',
    6,
    6,
    6,
    NULL
  ),
  (
    'CN567890123CN',
    '2025-08-04 10:00:00',
    '2025-08-05 16:30:00',
    1,
    7,
    7,
    NULL
  ),
  (
    'UK123987654UK',
    '2025-08-05 12:55:00',
    '2025-08-06 17:05:00',
    2,
    8,
    8,
    NULL
  ),
  (
    'AU111222999AU',
    '2025-08-06 20:10:00',
    '2025-08-07 19:15:00',
    3,
    9,
    9,
    NULL
  );

-- Encomendas pegas por moradores autorizados
INSERT INTO
  encomenda (
    cod_rastreio,
    porteiro_recebe_data,
    morador_pega_data,
    porteiro_matricula,
    morador_id_destino,
    morador_id_pega,
    hospede_id
  )
VALUES
  (
    'NL123456789NL',
    '2025-08-07 09:40:00',
    '2025-08-08 11:10:00',
    4,
    1,
    7,
    NULL
  ),
  (
    'CA987654321CA',
    '2025-08-08 14:20:00',
    '2025-08-09 10:00:00',
    5,
    2,
    8,
    NULL
  ),
  (
    'JP111222333JP',
    '2025-08-09 19:50:00',
    '2025-08-10 16:45:00',
    6,
    1,
    23,
    NULL
  ),
  (
    'AR111222333AR',
    '2025-08-11 08:30:00',
    '2025-08-12 12:25:00',
    1,
    4,
    25,
    NULL
  ),
  (
    'PT777888999PT',
    '2025-08-12 17:00:00',
    '2025-08-13 19:30:00',
    2,
    5,
    6,
    NULL
  );

-- Encomendas pegas por hóspedes autorizados
INSERT INTO
  encomenda (
    cod_rastreio,
    porteiro_recebe_data,
    hospede_pega_data,
    porteiro_matricula,
    morador_id_destino,
    morador_id_pega,
    hospede_id
  )
VALUES
  (
    'ES444555666ES',
    '2025-08-10 10:10:00',
    '2025-08-11 15:55:00',
    1,
    1,
    NULL,
    1
  ),
  (
    'BR777888999BR',
    '2025-08-11 13:40:00',
    '2025-08-12 14:10:00',
    2,
    3,
    NULL,
    2
  ),
  (
    'IT123456789IT',
    '2025-08-13 18:20:00',
    '2025-08-14 11:05:00',
    3,
    10,
    NULL,
    4
  ),
  (
    'GR987654321GR',
    '2025-08-14 12:00:00',
    '2025-08-15 13:00:00',
    4,
    5,
    NULL,
    6
  );

-- Encomendas pendentes (ainda não foram pegas)
INSERT INTO
  encomenda (
    cod_rastreio,
    porteiro_recebe_data,
    porteiro_matricula,
    morador_id_destino,
    morador_id_pega,
    hospede_id
  )
VALUES
  (
    'LA777888999LA',
    '2025-08-12 21:00:00',
    3,
    10,
    NULL,
    NULL
  ),
  (
    'FR111222333FR',
    '2025-08-13 09:30:00',
    4,
    11,
    NULL,
    NULL
  ),
  (
    'US999888777US',
    '2025-08-14 15:15:00',
    5,
    12,
    NULL,
    NULL
  ),
  (
    'DE654321098DE',
    '2025-08-15 16:50:00',
    6,
    13,
    NULL,
    NULL
  ),
  (
    'CN456789012CN',
    '2025-08-16 11:45:00',
    1,
    14,
    NULL,
    NULL
  ),
  (
    'UK789012345UK',
    '2025-08-17 14:00:00',
    2,
    15,
    NULL,
    NULL
  ),
  (
    'CA123456789CA',
    '2025-08-18 08:00:00',
    3,
    16,
    NULL,
    NULL
  ),
  (
    'MX111222333MX',
    '2025-08-19 10:20:00',
    4,
    1,
    NULL,
    NULL
  ),
  (
    'CH987654321CH',
    '2025-08-20 17:30:00',
    5,
    2,
    NULL,
    NULL
  ),
  (
    'PE444555666PE',
    '2025-08-21 20:45:00',
    6,
    3,
    NULL,
    NULL
  ),
  (
    'BR555444333BR',
    '2025-08-11 16:00:00',
    1,
    26,
    NULL,
    NULL
  ),
  (
    'DE111999888DE',
    '2025-08-12 12:35:00',
    2,
    27,
    NULL,
    NULL
  ),
  (
    'US222888777US',
    '2025-08-13 14:40:00',
    3,
    28,
    NULL,
    NULL
  ),
  (
    'CN333777666CN',
    '2025-08-14 10:50:00',
    4,
    29,
    NULL,
    NULL
  ),
  (
    'UK444666555UK',
    '2025-08-15 13:10:00',
    5,
    30,
    NULL,
    NULL
  );

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
-- Consulta para um morador saber quantas encomendas recebeu nos últimos 30 dias
select
  m.nome,
  (
    select
      count(*)
    from
      encomenda
    where
      morador_id_destino = m.id
      and porteiro_recebe_data >= (now() - interval '30 days')
  ) as quantidade_encomendas
from
  morador m
where
  m.cpf = '11111111111';

-- Consulta para saber quantas encomendas foram recebidas de cada apartamento nos ultimos 15 dias
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
-- Consulta para saber todos os moradores juntamente com hóspedes do condomínio cadastrados
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
or replace function insert_view_morador_hospede()
returns trigger as $$
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

create trigger trg_ins_view_morador_hospede_autorizacoes
instead of insert on morador_hospede_autorizacoes
for each row
execute function insert_view_morador_hospede();
-- 2 visões robustas (e.g., com vários joins) com justificativa semântica, de acordo com os requisitos da aplicação.
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

