pipeline {
    agent any

    environment {
        DB_NAME = 'wordpress_db'
        DOCKERFILE_PATH = './${env.DOCKERFILE_PATH}'
    }

    stages {
        stage('Load Environment Variables') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'db-host', variable: 'DB_HOST'),
                        string(credentialsId: 'db-user', variable: 'DB_USER'),
                        string(credentialsId: 'db-password', variable: 'DB_PASSWORD'),
                        // Assuming your AWS credentials are stored under one credential ID, such as 'aws-credentials'
                        string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        // Print variables for debugging (avoid printing sensitive info in production)
                        echo "Database Host: ${env.DB_HOST}"
                        echo "Database User: ${env.DB_USER}"
                        echo "AWS Access Key ID: ${env.AWS_ACCESS_KEY_ID}"
                        
                        // Example AWS CLI command using the credentials
                        sh '''
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                        aws rds describe-db-instances --region ap-south-1
                        '''
                    }
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    docker.build('wordpress', "${env.DOCKERFILE_PATH}")
                }
            }
        }

        stage('Deploy Locally') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'sleep 30'
                    sh 'curl -I http://localhost:8081'
                }
            }
        }
    }
}

