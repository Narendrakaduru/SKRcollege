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

    stage('Build-steps') {
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

    stage('Upload to Artifactory') {
      steps {
        sh 'jf rt u --url http://localhost:8081/artifactory/ --access-token ${ARTIFACTORY_ACCESS_TOKEN} target/SKRcollege.war SKRcollege/'
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
    CI = true
    ARTIFACTORY_ACCESS_TOKEN = credentials('artifactory-access-token')
    TESTER = 'Nani'
    BUILD_ID = '1.0.0'
  }
}
