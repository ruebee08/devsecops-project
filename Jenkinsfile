pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t myapp .'
            }
        }
        stage('Test') {
            steps {
                 sh 'docker run --rm my-python-app'
            }
        }
    }
}
