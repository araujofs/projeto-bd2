import os

# nomes dos arquivos na ordem desejada
arquivos = ["creation.sql", "insertion.sql", "queries.sql", "functions.sql", "triggers.sql"]
saida = "unified.sql"

with open(saida, "w", encoding="utf-8") as outfile:
    for nome in arquivos:
        caminho = os.path.join(os.getcwd(), nome)

        if not os.path.exists(caminho):
            print(f"Arquivo {nome} não encontrado, pulando...")
            continue

        with open(caminho, "r", encoding="utf-8") as infile:
            conteudo = infile.read()

            outfile.write(conteudo + "\n\n")
            
print(f"Arquivo '{saida}' gerado com sucesso!")
