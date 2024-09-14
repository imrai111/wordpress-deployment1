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
          // Build the WordPress Docker image
          docker.build('wordpress', './wordpress')
        }
      }
    }

    stage('Deploy Locally') {
      steps {
        script {
          // Use Docker Compose to start the containers
          sh 'docker-compose up -d'
        }
      }
    }

    stage('Test') {
      steps {
        script {
          // Test WordPress deployment
          sh 'curl -I http://localhost:8081'
        }
      }
    }
  }

  post {
    always {
      steps {
        // Example post-build steps
        echo 'Pipeline execution completed.'
        // Additional cleanup or notifications can be added here
      }
    }
  }
}

