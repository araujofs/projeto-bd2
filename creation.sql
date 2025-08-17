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