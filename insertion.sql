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