pipeline {
    agent any
    environment {
        registry = "ajinkyadoc1234/my-website"
        sshCred = 'ssh-key-credentials'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Ajinkyapatil1234/Website-PRT-ORG.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.build registry
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: sshCred, keyFileVariable: 'SSH_KEY')]) {
                        sh 'ssh-keyscan -H 13.235.24.122 >> ~/.ssh/known_hosts'
                        sh 'scp -i $SSH_KEY k8s/deployment.yaml ubuntu@13.235.24.122:/home/ubuntu/'
                        sh 'scp -i $SSH_KEY k8s/service.yaml ubuntu@13.235.24.122:/home/ubuntu/'
                        sh 'ssh -i $SSH_KEY ubuntu@13.235.24.122 kubectl apply -f /home/ubuntu/deployment.yaml'
                        sh 'ssh -i $SSH_KEY ubuntu@13.235.24.122 kubectl apply -f /home/ubuntu/service.yaml'
                    }
                }
            }
        }
    }
}



