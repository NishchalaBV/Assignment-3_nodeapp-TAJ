@Library('github.com/releaseworks/jenkinslib') _

pipeline {
    agent any
    environment {
        registry = "499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins"
    }

    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sumeetkhastgir/C7-Assignment.git']]])
            }
        }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }

    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
        steps{
            script {
                sh 'docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins '
                sh 'docker push 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins'
            }
        }
    }

    stage('Docker Run') {
     steps{
         script {
             sshagent(credentials : ['aws_ec2']){

                sh 'ssh -o StrictHostKeyChecking=no -i assignment-c7key.pem ubuntu@10.0.2.129'

             }
                //sh 'ssh -i /login/assignment-c7key.pem ubuntu@10.0.2.129'
                sh 'docker run -d -p 8081:8080 --rm --name node 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins'
            }
      }
    }
    }
}
