pipeline {
    agent any

    stages {
        stage('Build and Test') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t midterm-project:${BUILD_NUMBER} .'
            }
        }
    }
}
