pipeline {
 agent any
  

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

        stage('Build the code artifact and Sonarqube Analysis') {
            steps {
                  withSonarQubeEnv ('SONAR_LATEST') {
                
                    sh '/opt/apache-maven-3.9.9/bin/mvn clean package sonar:sonar -DskipTests=true -Dcheckstyle.skip' 
                  }
            }  
       }

       stage('Test Maven - JUnit') {
            steps {
              sh "/opt/apache-maven-3.9.9/bin/mvn test -Dcheckstyle.skip"
              }
            
            post{
              always{
                junit testResults: 'target/surefire-reports/*.xml'
              }
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
         stage('building a docker image') {
            steps {
                sh "docker build -t shubhamshuklaa/petclinicapp:${BUILD_NUMBER} ."
            }
         }
          stage("TRIVY"){
            steps{
                sh "trivy image  shubhamshuklaa/petclinicapp:${BUILD_NUMBER} --scanners vuln > trivyimage.txt" 
            }
        }

        stage('docker image push') {
            steps {
                withDockerRegistry(credentialsId: 'dockercred', url: '') {
                    sh "docker push shubhamshuklaa/petclinicapp:${BUILD_NUMBER}"
                }
            }
        }

    }

        

       















}
