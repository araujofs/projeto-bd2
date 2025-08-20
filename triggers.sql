CREATE OR REPLACE FUNCTION notificar_morador_encomenda()
RETURNS TRIGGER AS $$
DECLARE
  destinatario_nome VARCHAR;
  cod_rastreio_novo VARCHAR;
BEGIN
  SELECT nome INTO destinatario_nome FROM morador WHERE id = NEW.morador_id_destino;

  cod_rastreio_novo := NEW.cod_rastreio;

  -- Em um sistema real, aqui seria o código para enviar um e-mail, SMS ou notificação push.
  -- Para fins de demonstração, usamos RAISE NOTICE para simular a notificação.
  RAISE NOTICE 'Notificação: Olá, %! Sua encomenda com código de rastreio % acaba de chegar na portaria.', destinatario_nome, cod_rastreio_novo;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_apos_inserir_encomenda
AFTER INSERT ON encomenda
FOR EACH ROW
EXECUTE FUNCTION notificar_morador_encomenda();

--------------------------------

CREATE OR REPLACE FUNCTION impedir_auto_autorizacao()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.morador_autoriza_id = NEW.morador_autorizado_id THEN
    RAISE EXCEPTION 'Um morador não pode autorizar a si mesmo.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_antes_de_inserir_autorizacao_morador
BEFORE INSERT ON morador_autoriza_morador
FOR EACH ROW
EXECUTE FUNCTION impedir_auto_autorizacao();

--------------------------------

CREATE TABLE historico_encomendas (
    id SERIAL PRIMARY KEY,
    encomenda_id INTEGER NOT NULL,
    cod_rastreio VARCHAR(30) NOT NULL,
    data_retirada TIMESTAMP NOT NULL,
    retirado_por_nome VARCHAR(150),
    retirado_por_id INTEGER,
    tipo_usuario VARCHAR(10) NOT NULL CHECK (tipo_usuario IN ('morador', 'hospede'))
);

CREATE OR REPLACE FUNCTION auditar_retirada_encomenda()
RETURNS TRIGGER AS $$
DECLARE
  nome_retirou VARCHAR;
  tipo_usr VARCHAR;
  id_retirou INTEGER;
BEGIN
  IF OLD.morador_id_pega IS NULL AND NEW.morador_id_pega IS NOT NULL THEN
    SELECT nome INTO nome_retirou FROM morador WHERE id = NEW.morador_id_pega;
    tipo_usr := 'morador';
    id_retirou := NEW.morador_id_pega;

  ELSIF OLD.hospede_id IS NULL AND NEW.hospede_id IS NOT NULL THEN
    SELECT nome INTO nome_retirou FROM hospede WHERE id = NEW.hospede_id;
    tipo_usr := 'hospede';
    id_retirou := NEW.hospede_id;
  END IF;

  IF nome_retirou IS NOT NULL THEN
    INSERT INTO historico_encomendas 
        (encomenda_id, cod_rastreio, data_retirada, retirado_por_nome, retirado_por_id, tipo_usuario)
    VALUES (
        NEW.id,
        NEW.cod_rastreio,
        COALESCE(NEW.morador_pega_data, NEW.hospede_pega_data),
        nome_retirou,
        id_retirou,
        tipo_usr
    );
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_apos_atualizar_encomenda
AFTER UPDATE ON encomenda
FOR EACH ROW
EXECUTE FUNCTION auditar_retirada_encomenda();