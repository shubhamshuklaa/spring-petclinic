pipeline {
 agent any

 tools {
      maven 'maven'
      jfrog 'jfrog-cli'
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
          sh ' mvn compile -DskipTests=true -Dcheckstyle.skip'
         }
        }

        stage('Unit-Test') {
         steps {
          sh 'mvn test -DskipTests=true -Dcheckstyle.skip'
         }
        }

        stage('Trivy FS Scan') {
         steps {
          sh 'trivy fs .'
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
          jf 'mvn-config --repo-resolve-releases maven-libs-release --repo-resolve-snapshots maven-libs-snapshot --repo-deploy-releases maven-libs-release-local --repo-deploy-snapshots maven-libs-snapshot-local'
          sh 'mvn package -DskipTests=true -Dcheckstyle.skip'
         }
        }

        stage('Publish Artifact') {
         steps {
            jf 'rt build-publish'
         }
        }

        stage('Docker Build & Tag') {
         steps {
          script {
            withDockerRegistry(credentialsId: 'docker-cred' , toolName: 'docker') {
              sh 'docker build -t shubhamshuklaa/petclinicapp:latest .'
            }
          }
         }
        }

        stage('Trivy Scan') {
            steps {
                    sh 'trivy image --format table -o image.txt --scanners vuln shubhamshuklaa/petclinicapp:latest'
            }
        }

        stage('Docker Push') {
         steps {
          script {
           withDockerRegistry(credentialsId: 'docker-cred' , toolName: 'docker') {
            sh 'docker push shubhamshuklaa/petclinicapp:latest'
           }
          }
         }
        }

          

    }

        

       















}
