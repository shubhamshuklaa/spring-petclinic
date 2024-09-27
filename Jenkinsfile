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
               jf 'mvn-config --repo-resolve-releases maven-remote-libs-release --repo-resolve-snapshots maven-remote-libs-snapshot --repo-deploy-releases maven-remote-libs-release-local --repo-deploy-snapshots maven-remote-libs-snapshot-local'
                   
            withSonarQubeEnv('SONARQUBE') {
               sh 'mvn clean package sonar:sonar -DskipTests=true '  // Correct capitalization for -DskipTests
                   }
                 } 
                 
            }
        

        

       stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
     }
















}
