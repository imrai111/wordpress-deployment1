pipeline {
    agent any

    environment {
        DB_HOST = credentials('db-host')
        DB_USER = credentials('db-user')
        DB_PASSWORD = credentials('db-password')
        DB_NAME = 'wordpress_db'
    }

    stages {
        stage('Load Environment Variables') {
            steps {
                script {
                    def envFile = new File('.env')
                    envFile.eachLine { line ->
                        def (key, value) = line.split('=')
                        env[key] = value
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
                    sh 'docker-compose up -d'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'sleep 30'  // Wait for 30 seconds
                    sh 'curl -I http://localhost:8081'
                }
            }
        }
    }
}

