pipeline {
    agent any

    stages {
        stage('Build and Test inside Docker') {
            steps {
                // 1. Build the image (this runs the JUnit tests)
                bat 'docker build --target package -t midterm-test-image .'

                // 2. Extract test results so Jenkins can show them
                // We create a temporary container to copy the XML files out
                bat 'docker create --name extract midterm-test-image'
                bat 'docker cp extract:/build/target/surefire-reports ./'
                bat 'docker rm extract'
            }
            post {
                always {
                    // This creates the blue/red status and test graphs in Jenkins
                    junit 'surefire-reports/*.xml'
                }
            }
        }

        stage('Finalize Image') {
            steps {
                // Build the actual final (slim) runtime image
                bat 'docker build -t midterm-project .'
            }
        }
    }
}