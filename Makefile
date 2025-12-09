.PHONY: build-tf-agent test-tf-agent

# Variáveis
IMAGE_NAME = infra-base-labs/jenkins-agent-tf
TAG = latest

# Builda a imagem do Terraform Agent
build-tf-agent:
	docker build -t $(IMAGE_NAME):$(TAG) ./containers/jenkins-agents/terraform-aws

# Testa rodando um container rápido para checar versões
test-tf-agent:
	docker run --rm $(IMAGE_NAME):$(TAG) sh -c "terraform --version && aws --version"

# Atalho para buildar e testar
all: build-tf-agent test-tf-agent
