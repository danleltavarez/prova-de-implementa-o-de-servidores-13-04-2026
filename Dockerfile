# Usa imagem oficial slim → menor tamanho e menos superfície de ataque (mais segura)
FROM python:3.11-slim

# Define diretório de trabalho dentro do container
WORKDIR /app

# Copia apenas o arquivo de dependências primeiro (melhora cache)
COPY requirements.txt .

# Instala dependências e limpa cache na mesma layer (reduz tamanho final)
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get remove -y gcc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copia o restante da aplicação
COPY . .

# Comando padrão (ajuste conforme sua app)
CMD ["python", "app.py"]