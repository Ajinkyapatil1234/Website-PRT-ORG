pipeline {
    agent any
    environment {
        registry = "ajinkyadoc1234/my-website"
        registryCredential = 'dockerhub_credentials'
        kubernetesCred = 'kubeconfig-credentials-id'
        sshCred = 'ssh-key-credentials'
    }
    stages {
        stage('Build') {
            steps {
                script {
                    docker.build registry
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        docker.image(registry).push('latest')
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: sshCred, keyFileVariable: 'SSH_KEY')]) {
                        sh 'scp -i $SSH_KEY k8s/deployment.yaml user@k8s-slave-instance:/home/user/'
                        sh 'scp -i $SSH_KEY k8s/service.yaml user@k8s-slave-instance:/home/user/'
                        sh 'ssh -i $SSH_KEY user@k8s-slave-instance kubectl apply -f /home/user/deployment.yaml'
                        sh 'ssh -i $SSH_KEY user@k8s-slave-instance kubectl apply -f /home/user/service.yaml'
                    }
                }
            }
        }
    }
}
