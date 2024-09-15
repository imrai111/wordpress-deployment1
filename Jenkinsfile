pipeline {
    agent any

    environment {
        DB_NAME = 'wordpress_db'
        DOCKERFILE_PATH = './home/ubuntu/wordpress-deployment1/Dockerfile' // Use static value for Dockerfile path
    }

    stages {
        stage('Load Environment Variables') {
            steps {
                script {
                    // Use the 'withCredentials' step to securely handle credentials
                    withCredentials([
                        string(credentialsId: 'db-host-id', variable: 'DB_HOST'),
                        string(credentialsId: 'db-user-id', variable: 'DB_USER'),
                        string(credentialsId: 'db-password-id', variable: 'DB_PASSWORD')
                    ]) {
                        // Print the variables for debugging (avoid printing sensitive values in production)
                        echo "Database Host: ${env.DB_HOST}"
                        echo "Database User: ${env.DB_USER}"
                        echo "Database Password: ${env.DB_PASSWORD}" // Avoid printing passwords
                        echo "Database Name: ${env.DB_NAME}"
                        echo "Dockerfile Path: ${env.DOCKERFILE_PATH}"
                    }
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    // Use the Dockerfile path from the environment variable
                    docker.build('wordpress', "${env.DOCKERFILE_PATH}")
                }
            }
        }

        stage('Deploy Locally') {
            steps {
                script {
                    // Use docker-compose to deploy
                    sh 'docker-compose up -d'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'sleep 30'  // Wait for 30 seconds for the container to be ready
                    sh 'curl -I http://localhost:8081'
                }
            }
        }
    }
}

