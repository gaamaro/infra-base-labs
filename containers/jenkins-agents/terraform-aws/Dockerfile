# ==========================================
# STAGE 1: Installer (Mantido igual)
# ==========================================
FROM debian:bullseye-slim AS installer

ARG TERRAFORM_VERSION=1.6.6

# Instala apenas o necessário para baixar e descompactar
RUN apt-get update && apt-get install -y curl unzip

# 1. Prepara AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# 2. Prepara Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/

# ==========================================
# STAGE 2: Final (A imagem que vai pro Harbor)
# ==========================================
FROM debian:bullseye-slim

# Instala dependências de RUNTIME
# ADICIONADO: openjdk-11-jre (Essencial para o Jenkins Agent funcionar)
# ADICIONADO: tar (Necessário para o Jenkins copiar o agente)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    jq \
    make \
    groff \
    less \
    ca-certificates \
    openjdk-11-jre \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Copia AWS CLI do stage anterior
COPY --from=installer /usr/local/aws-cli /usr/local/aws-cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws

# Copia Terraform do stage anterior
COPY --from=installer /usr/local/bin/terraform /usr/local/bin/terraform

# Setup final
WORKDIR /workspace
CMD ["sleep", "infinity"]