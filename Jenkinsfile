pipeline {
  agent any

  environment {
    DB_HOST = 'wordpress-db.c1sjzy9x15vz.ap-south-1.rds.amazonaws.com:3306'
    DB_USER = 'wordpress_user'
    DB_PASSWORD = 'wordpress_password'
    DB_NAME = 'wordpress_db'
  }

  stages {
    stage('Build Docker Images') {
      steps {
        script {
          docker.build('wordpress', './var/lib/jenkins/workspace/wordpress-deployment')
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

  post {
    always {
      echo 'Pipeline execution completed.'
    }
  }
}

