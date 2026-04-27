pipeline {
    agent any

    environment {
        IMAGE = "calculator-app:${BUILD_NUMBER}"
    }

    stages {

        stage('Build + Unit Test') {
            steps {
                bat 'mvn clean test package'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE% .'
            }
        }

        stage('Deploy Staging') {
            steps {
                bat '''
                docker rm -f calc-staging || exit 0
                docker run --name calc-staging %IMAGE%
                '''
            }
        }

        stage('Show Staging Logs') {
            steps {
                bat 'docker logs calc-staging'
            }
        }

        stage('Backup Old Production') {
            steps {
                bat '''
                docker image inspect calculator-app:latest >nul 2>&1 && docker tag calculator-app:latest calculator-app:previous || exit 0
                '''
            }
        }

        stage('Deploy Production') {
            steps {
                bat '''
                docker rm -f calc-prod || exit 0
                docker tag %IMAGE% calculator-app:latest
                docker run --name calc-prod calculator-app:latest
                '''
            }
        }

        stage('Show Production Logs') {
            steps {
                bat 'docker logs calc-prod'
            }
        }
    }

    post {
        failure {
            bat '''
            docker rm -f calc-prod || exit 0
            docker image inspect calculator-app:previous >nul 2>&1 && docker run --name calc-prod calculator-app:previous || exit 0
            '''
        }
    }
}