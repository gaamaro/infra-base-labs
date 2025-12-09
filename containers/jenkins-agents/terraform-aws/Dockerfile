# Imagem base leve (Debian-based)
FROM debian:bullseye-slim

# Argumentos para facilitar upgrades futuros
ARG TERRAFORM_VERSION=1.6.6
ARG AWS_CLI_VERSION=2.15.0

# Instala dependências básicas (curl, unzip, git, etc)
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    jq \
    make \
    && rm -rf /var/lib/apt/lists/*

# Instala AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip

# Instala Terraform
# O Docker vai substituir ${TERRAFORM_VERSION} automaticamente aqui
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

# Verifica as instalações
RUN aws --version && terraform --version

# Define diretório de trabalho padrão
WORKDIR /workspace

CMD ["/bin/bash"]