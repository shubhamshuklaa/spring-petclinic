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

        stage('maven build artifact') {
            steps {
                 withMaven(maven: 'maven'){
                 sh 'mvn clean package -DskipTests=true -Dcheckstyle.skip'  // Correct capitalization for -DskipTests
                 }
            }
        }
    }
}

    
    
  

  
