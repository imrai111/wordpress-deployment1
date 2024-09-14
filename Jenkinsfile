pipeline {
  agent any

  environment {
    DB_HOST = 'wordpress-db.c1sjzy9x15vz.ap-south-1.rds.amazonaws.com'
    DB_USER = 'wordpress_user'
    DB_PASSWORD = 'wordpress_password'
    DB_NAME = 'wordpress-db'
  }

  stages {
    stage('Build Docker Images') {
      steps {
        script {
          docker.build('wordpress', './wordpress')
          docker.build('mysql', './mysql')
        }
      }
    }

 stage('Deploy Locally on EC2') {
            steps {
                script {
                    // Start containers locally on the same EC2 instance
                    sh 'docker-compose up -d'
                }
            }
        }

    stage('Test') {
      steps {
        script {
          sh 'curl -I http://your-ec2-instance-ip:8080'
        }
      }
    }
  }
}

