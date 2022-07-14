pipeline {
    agent { label 'worker' }
    environment {
        registry = "499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins"
    }
    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/NishchalaBV/Assignment-3_nodeapp-TAJ.git']]])
            }
        }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          sh 'sudo docker build -t node-app-nish .'
        }
      }
    }// Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
        steps{
            script {
                sh 'aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 499058147482.dkr.ecr.us-east-1.amazonaws.com'
                sh 'sudo docker tag node-app-nish 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins:latest'
                sh 'sudo docker push 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins:latest'
            }
        }
    }
    stage('Docker Run') {
     steps{
         script {
             sh 'cd '
             sh 'pwd'
             sshagent(credentials : ['aws_ec2']){

                sh 'ssh -tt -o StrictHostKeyChecking=no ubuntu@10.0.1.32'
                

             }
                //sh 'ssh -i /login/NishKey2085per.pem ubuntu@10.0.1.32'
               sh 'ssh -o StrictHostKeyChecking=no ubuntu@10.0.2.12 "docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins && docker pull 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins:latest && (docker ps -f name=node -q | xargs --no-run-if-empty docker container stop) && (docker container ls -a -fname=node -q | xargs -r docker container rm) && docker run -d -p 8081:8081 --rm --name node 499058147482.dkr.ecr.us-east-1.amazonaws.com/assign3-jenkins"' 
                
               
            }
      }
    }
  
    }
}
