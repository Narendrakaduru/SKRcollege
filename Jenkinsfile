pipeline {
  agent any
  stages {
    stage('Checkout SCM') {
      parallel {
        stage('Checkout SCM') {
          steps {
            git(url: 'https://github.com/Narendrakaduru/SKRcollege.git', credentialsId: 'GitAuth', branch: 'main')
          }
        }

        stage('Check POM') {
          steps {
            fileExists 'pom.xml'
          }
        }

      }
    }

    stage('Build') {
      parallel {
        stage('Build') {
          steps {
            sh 'mvn clean package'
          }
        }

        stage('Print Tester') {
          steps {
            echo "The Tester is ${TESTER}"
            sleep 5
          }
        }

        stage('Build No') {
          steps {
            echo "Print Build No ${BUILD_ID}"
            sleep 10
          }
        }

      }
    }

    stage('SonarQube analysis') {
        //def scannerHome = tool 'SonarQubeScanner-4.7.0';
        steps{
        withSonarQubeEnv('sonarqube-8.9.8') { 
        // If you have configured more than one global server connection, you can specify its name
        //  sh "${scannerHome}/bin/sonar-scanner"
        sh "mvn sonar:sonar"
        }
      }
    }

    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t skr-college-img .'
      }
    }

    stage('Push to DockerHub') {
      steps {
        sh 'docker tag skr-college-img:latest narendra8686/skr-college-img:latest'
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        sh 'docker push narendra8686/skr-college-img:latest'
      }
    }

  }
  tools {
    maven 'M2_HOME'
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('DockerAuth')
    TESTER = 'Nani'
    BUILD_ID = '1.0.0'
  }
}
