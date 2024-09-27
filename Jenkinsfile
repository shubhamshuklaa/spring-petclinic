pipeline {
 agent any
  
      tools {
        jfrog 'jfrog-cli'
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

        stage('maven build artifact and sonarqube analysis') {
            steps {
               jf 'mvn-config --petclinic_artifact-libs-release --petclinic_artifact-libs-snapshot --petclinic_artifact-libs-release-local --petclinic_artifact-libs-snapshot-local'
                   
            
               sh 'mvn clean package -DskipTests=true '  // Correct capitalization for -DskipTests
                
                 } 
                 
            }
        

        

       stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
     }
















}
