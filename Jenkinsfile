pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'VLE-8 Blue-Green Deployment Pipeline'
                sh 'pwd'
            }
        }

        stage('Validate Kubernetes') {
            steps {
                sh 'kubectl get deployments vle8-blue vle8-green'
                sh 'kubectl get service vle8-blue-green-service'
            }
        }

        stage('Build Blue and Green Images') {
            steps {
                dir('app') {
                    sh 'docker build -f Dockerfile -t vle8-blue:v1 .'
                    sh 'docker build -f Dockerfile.green -t vle8-green:v1 .'
                }
            }
        }

        stage('Export and Load Images into Minikube') {
            steps {
                sh 'docker save vle8-blue:v1 -o /tmp/vle8-blue.tar'
                sh 'docker save vle8-green:v1 -o /tmp/vle8-green.tar'
                sh 'sudo /usr/local/bin/vle8-load-image /tmp/vle8-blue.tar'
                sh 'sudo /usr/local/bin/vle8-load-image /tmp/vle8-green.tar'
            }
        }

        stage('Verify Deployments') {
            steps {
                sh 'kubectl rollout status deployment/vle8-blue --timeout=120s'
                sh 'kubectl rollout status deployment/vle8-green --timeout=120s'
            }
        }

        stage('Approval Before Green') {
            steps {
                input message: 'Approve switching live traffic to GREEN?', ok: 'Deploy Green'
            }
        }

        stage('Switch Traffic to Green') {
            steps {
                sh """kubectl patch service vle8-blue-green-service -p '{"spec":{"selector":{"app":"vle8-app","color":"green"}}}'"""
                sh 'kubectl get service vle8-blue-green-service -o yaml'
            }
        }
    }

    post {
        success {
            echo 'VLE-8 pipeline completed. Traffic is routed to GREEN.'
        }
        failure {
            echo 'Pipeline failed or was aborted. Check stage logs and the current Service selector.'
        }
    }
}
