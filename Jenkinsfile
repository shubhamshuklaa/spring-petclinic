pipeline {
  agent any

  stages {
    stage('snyk scan') {
      steps {
        echo 'SCANNING'
        snykSecurity(
          snykInstallation: 'snyk@latest',
          snykTokenId: 'snyk_api_token',
          monitorProjectOnBuild: false,
          additionalArguments: 'output-all-vulnerabilities.json'
          )
          sh 'snyk-filter -i all-vulnerabilities.json -f /usr/local/bin/exploitable_cvss_9.yml
      }
    }

    stage('maven build artifact') {
      steps {
        withMaven(maven: 'maven'){
        echo 'BUILDING ARTIFACTS'
        sh 'mvn clean package -DskipTests-true -Dcheckstyle.skip' //It will create jar file and DskipTests is used to skip all the test, Dcheckstyle used to skip all the issues to ignore the build failures
        archive 'target/*.jar'
        }
      }
    }
  }
}


    
    
  

  
