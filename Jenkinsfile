pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'myapp'
        SONARQUBE_URL = 'http://sonarqube:9000'
        ZAP_URL = 'http://zap:8080'
        TRIVY_IMAGE = 'aquasec/trivy:latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run tests inside the app container
                    sh "docker run --rm $DOCKER_IMAGE python -m unittest discover"
                }
            }
        }

        stage('SonarQube Analysis') {

           steps {
           withSonarQubeEnv('sonarqube') {
            // This uses the SonarQube Scanner installed via Jenkins UI
            script {
                def scannerHome = tool 'sonarscanner' // Match the name you set in Jenkins > Global Tool Configuration
                sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=myapp -Dsonar.sources=. -Dsonar.projectVersion=1.0"
            }
        }
    }
            }

        stage('Trivy Scan') {
            steps {
                script {
                    // Scan built image for vulnerabilities
                    sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock $TRIVY_IMAGE image $DOCKER_IMAGE"
                }
            }
        }

        stage('ZAP Scan') {
            steps {
                script {
                    // Example: Run ZAP API scan on your app if running somewhere accessible
                    // You can trigger ZAP spider or active scan using ZAP API here
                    // This is a placeholder, ZAP setup depends on your app exposure and config
                    echo 'Trigger ZAP scan against app URL (implement API call here)'
                }
            }
        }

        stage('Deploy to k3d (Kubernetes)') {
            steps {
                script {
                    // You can add kubectl commands here to deploy app to your k3d cluster
                    // Example: sh 'kubectl apply -f k8s/deployment.yaml'
                    echo 'Deploy app to k3d cluster (add your kubectl commands)'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}
