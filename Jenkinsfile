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

        stage('Verify Green Traffic') {
            steps {
                sh '''
                    set -eu
                    for i in $(seq 1 10); do
                        RESPONSE=$(kubectl run vle8-health-check --rm -i --restart=Never \
                          --image=curlimages/curl:latest --quiet -- \
                          curl -fsS --max-time 5 http://vle8-blue-green-service 2>/dev/null) || true

                        if printf '%s' "$RESPONSE" | grep -q 'VLE-8 - GREEN ENVIRONMENT'; then
                            echo "Green traffic verified successfully."
                            exit 0
                        fi

                        sleep 2
                    done

                    echo "Green health check failed; rolling traffic back to Blue."
                    kubectl patch service vle8-blue-green-service \
                      -p '{"spec":{"selector":{"app":"vle8-app","color":"blue"}}}'
                    exit 1
                '''
            }
        }
    }

    post {
        success {
            echo 'VLE-8 pipeline completed. Traffic is routed to GREEN.'
        }
        failure {
            echo 'Pipeline failed. Check the logs and current Service selector.'
        }
    }
}
