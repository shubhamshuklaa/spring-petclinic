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
                jf 'mvn-config --repo-resolve-releases petclinic-libs-release --repo-resolve-snapshots petclinic-libs-snapshot --repo-deploy-releases petclinic-libs-release-local --repo-deploy-snapshots petclinic-libs-snapshot-local'
                
                 withMaven(maven: 'maven'){
                 sh 'mvn clean package -DskipTests=true -Dcheckstyle.skip'  // Correct capitalization for -DskipTests
                 archive 'target/*.jar'
                 }
            }
        }

        stage('TRIVY FS SCAN') {
            steps {
                sh 'trivy fs . > trivyfs.txt'
            }
        }

        stage('BUILDING DOCKER IMAGE') {
            steps {
                sh "docker build -t shubham021095/petclinicapp:${BUILD_NUMBER} . "
            }
        }

        stage('IMAGE SCANNING') {
            steps {
                sh 'trivy image shubham021095/petclinicapp:${BUILD_NUMBER} --scanners vuln > trivyimage.txt'
            }
        }

        stage('docker image push') {
            steps {
                withDockerRegistry(credentialsId: 'docker-cred', url: '') {
                    sh 'docker push shubham021095/petclinicapp:${BUILD_NUMBER}'
                }
            }
        }
        
        stage('Publish Build Info') {
            steps {
                jf 'rt build-publish'
            }
        }
        
        stage('Pushing the Artifacts') {
            steps {
                jf 'rt u /var/lib/jenkins/workspace/Stage-2/artifacts/spring-petclinic-3.3.0-SNAPSHOT.jar petclinic-libs-snapshot-local'
            }
        }
            
                

        
    }
}

    
    
    
    
  

  
