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
                        sh 'scp -i $SSH_KEY k8s/deployment.yaml user@52.66.144.27:/home/user/'
                        sh 'scp -i $SSH_KEY k8s/service.yaml user@52.66.144.27:/home/user/'
                        sh 'ssh -i $SSH_KEY user@52.66.144.27 kubectl apply -f /home/user/deployment.yaml'
                        sh 'ssh -i $SSH_KEY user@52.66.144.27 kubectl apply -f /home/user/service.yaml'
                    }
                }
            }
        }
    }
}


