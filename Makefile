.PHONY: build-tf-agent test-tf-agent

# Variáveis
IMAGE_NAME = infra-base-labs/jenkins-agent-tf
TAG = latest
HARBOR_TAG = v$1

# Builda a imagem do Terraform Agent
build-tf-agent:
	docker build -t $(IMAGE_NAME):$(TAG) ./containers/jenkins-agents/terraform-aws

# Testa rodando um container rápido para checar versões
test-tf-agent:
	docker run --rm $(IMAGE_NAME):$(TAG) sh -c "terraform --version && aws --version"

# Tag a imagem para o Harbor
harbor-tag:
	docker tag $(IMAGE_NAME):$(TAG) registry.lab/$(IMAGE_NAME):$(HARBOR_TAG)

#Push to Harbor
push-tf-agent:
	docker push registry.lab/$(IMAGE_NAME):$(HARBOR_TAG)

# Atalho para buildar e testar
all: build-tf-agent test-tf-agent harbor-tag push-tf-agent
