pipeline {
 agent any

 tools {
      maven 'maven'
 }

 environment {
     SCANNER_HOME= tool 'sonar-scanner'
 }

    stages {
        stage('snyk scan') {
            steps {
                snykSecurity(
                    snykInstallation: 'snyk@latest',
                    snykTokenId: 'snyk_api_token',
                    monitorProjectOnBuild: false,
                    failOnIssues: false,  // Use boolean for failOnIssues
                    additionalArguments: '--json-file-output=all-vulnerabilities.json'
                )
            }
        }

        stage('Compile') {
         steps {
          sh ' mvn compile'
         }
        }

        stage('Unit-Test') {
         steps {
          sh 'mvn test'
         }
        }

        stage('Trivy FS Scan') {
         steps {
          sh 'trivy fs --format table -o fs.html .'
         }
        }

        stage('Sonar-Analysis') {
         steps {
          withSonarQubeEnv('sonar') {
           sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=taskmaster -Dsonar.projectKey=taskmaster -Dsonar.java.binaries=target '''
          }
         }
        }

        stage('Build Application') {
         steps {
          sh 'mvn package'
         }
        }

          

    }

        

       















}
