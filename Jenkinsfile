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
                    jf '/opt/apache-maven-3.9.9/bin/mvn-config --repo-resolve-releases maven-libs-release --repo-resolve-snapshots maven-libs-snapshot --repo-deploy-releases maven-libs-release-local --repo-deploy-snapshots maven-libs-snapshot-local'
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
    }

        

       















}
