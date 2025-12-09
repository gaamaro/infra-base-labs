pipeline {
    agent any
    
    stages {
        stage('Build & Push: TF Agent') {
            // Só roda se houver mudança dentro da pasta da imagem
            when { 
                changeset "containers/jenkins-agents/terraform-aws/**" 
            }
            steps {
                script {
                    echo "Detectada alteração no agente Terraform. Iniciando build..."
                    // Usa o Makefile que criamos para padronizar
                    sh "make build-tf-agent"
                    
                    // Passo extra: Login e Push (exemplo genérico)
                    // sh "docker login ..."
                    // sh "docker push infra-base-labs/jenkins-agent-tf:latest"
                }
            }
        }

        // Futuro stage para outras imagens
        // stage('Build: Python Agent') { ... }
    }
}