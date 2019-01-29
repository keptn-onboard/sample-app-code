@Library('dynatrace@master') _

pipeline {
  agent {
    label 'nodejs'
  }
  environment {
    APP_NAME = "sample-app"
    VERSION = readFile('version').trim()
    ARTEFACT_ID = "${env.GITHUB_ORGANIZATION}/" + "${env.APP_NAME}"
    BASE_TAG = "${env.DOCKER_REGISTRY_URL}:5000/library/${env.ARTEFACT_ID}"
    IMAGE_TAG = "${env.BASE_TAG}:pr-${env.CHANGE_ID}"
    //PR_BRANCH = "${env.APP_NAME}-${env.BRANCH_NAME}".toLowerCase()
  }
  stages {
    stage('Node build') {
      steps {
        checkout scm
        container('nodejs') {
          sh 'npm install'
        }
      }
    }
    stage('Docker build') {
      steps {
        container('docker') {
          sh "docker -v"
          sh "docker build -t ${env.IMAGE_TAG} ."
        }
      }
    }
    stage('Docker push to registry'){
      when {
        expression {
          return env.BRANCH_NAME ==~'PR.*' 
        }
      }
      steps {
        container('docker') {
          sh "docker push ${env.IMAGE_TAG}"
        }
      }
    }
    /*
    stage('Create pull request') {
      steps {
        container('curl') {
          withCredentials([usernamePassword(credentialsId: 'git-credentials-acm', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            sh "curl -X POST \"https://api.github.com/repos/${env.GITHUB_ORGANIZATION}/config/pulls\" --user \"${GIT_USERNAME}:${GIT_PASSWORD}\" -H \"accept: application/json\" -H \"Content-Type: application/json\" -d \"{ \\\"title\\\": \\\"${env.PR_BRANCH}\\\", \\\"base\\\": \\\"dev\\\", \\\"head\\\": \\\"pr/${env.PR_BRANCH}\\\"}\" "
          }  
        }
      }
    }
    */
  }
}
