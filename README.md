🚀 Execução do ambiente (Docker Compose)
▶️ Subindo os serviços em segundo plano (background)

Para iniciar toda a stack (Nginx + Redis) em modo desacoplado (detached mode), execute:

docker compose up -d --build
🔍 O que esse comando faz?
up → cria e inicia os containers
-d → executa em segundo plano (background)
--build → força o build da imagem (importante para o Nginx customizado)

👉 Em modo -d, o terminal fica livre para você continuar usando normalmente, enquanto os containers seguem rodando em segundo plano

📊 Verificando se os serviços estão rodando
docker compose ps

Esse comando lista todos os containers ativos da aplicação.

📡 Monitoramento de logs em tempo real
🔴 Logs em tempo real (modo streaming)

Para acompanhar os logs ao vivo de todos os serviços:

docker compose logs -f
🔍 Explicação
logs → exibe logs dos containers
-f (--follow) → mantém o terminal aberto mostrando logs em tempo real

👉 Isso funciona mesmo após subir com -d, permitindo debug sem precisar parar o ambiente

📌 Logs de um serviço específico (ex: Nginx)
docker compose logs -f web

Ou para o Redis:

docker compose logs -f cache

👉 Ideal quando você quer focar em apenas um serviço específico

🧠 Dica importante (muito usada em DevOps)

Você pode combinar subida + logs:

docker compose up -d && docker compose logs -f

Assim:

Sobe tudo em background
Já começa a acompanhar os logs automaticamente
⏹️ Parar o ambiente
docker compose down

Isso para e remove os containers da stack.



![alt text](image.png)






------------------------------------------------RESPOSTAS__________----------------------------------------------

Seção 1

1.🔹 RUN e layers: cada RUN cria uma layer. Usar && junta comandos → menos layers. 🔹 Impacto: menos layers = imagem menor e melhor uso do cache (especialmente limpando arquivos no mesmo RUN). 🔹 docker history: mostra as layers, tamanho e comandos → serve para verificar se a imagem foi otimizada. 🔹 .dockerignore: evita enviar arquivos desnecessários/sensíveis no build → melhora performance e segurança. Ex: .git, debug.log, .env

2.🔹 Bridge padrão (bridge): Containers recebem IPs dinâmicos (ex: 172.17.0.x) que mudam ao reiniciar ❌ Não possui resolução de nomes (DNS) automática Comunicação depende de IP → instável para produção 🔹 Bridge customizada: Docker cria uma rede isolada com DNS automático embutido Containers se comunicam pelo nome do serviço/container (ex: db, api) ✔ Não importa se o IP muda → o nome continua funcionando

3.🔹 Infraestrutura como Código (IaC) no Docker: É tratar a “oficina” (containers, redes, volumes) como código versionado, usando arquivos como docker-compose.yml para definir tudo. 🔹 Imperativo (manual): Vários docker run → você monta a oficina peça por peça, comando por comando (mais erro e difícil de repetir). 🔹 Declarativo (YAML): No docker-compose.yml você descreve o estado final (ex: app + banco + rede) e o Docker monta tudo com um comando (docker compose up). 🔹 Vantagens (reprodutibilidade): Mesmo ambiente em qualquer máquina Menos erros humanos Fácil versionar (Git) Setup rápido (um comando)
