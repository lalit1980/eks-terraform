pipeline {
    agent any
    tools{
        terraform 'terraform12'
    } 
    environment {
        AWS_DEFAULT_REGION = 'ap-southeast-1'
        THE_BUTLER_SAY_SO=credentials("AWS-CREDENTIAL")
    }
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '',artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
    }
    parameters { 
      choice(name: 'ACTION', choices: ['', 'apply','destroy'], description: 'Select create or delete EKS cluster')
    }
    stages{
        stage('Set Terraform path') {
            steps {
                script {
                    def tfHome = tool name: 'terraform12'
                    env.PATH = "${tfHome}:${env.PATH}"
                }
                sh 'terraform version'

                }
        }
        stage('Clean Workspace') { 
                steps {
                    cleanWs()
                    sh 'env'
                    script{
                        if (params.ACTION == ""){
                            currentBuild.result = 'ABORTED'
                            error('Aborting the build as no action selected. Removed')
                            return
                        }
                    }
                } //steps
            }  //stage

        stage("Setup NGINX Ingress Controller"){
              steps {
                   script{
                        sh ("helm repo add eks https://aws.github.io/eks-charts")
                        sh ("kubectl apply -k /"/github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master/"/")
                        sh ("helm install nginx-release nginx-stable/nginx-ingress")
                   }

              }
           
        }
        stage("SCM Checkout"){
            steps {
                git branch: 'main', credentialsId: 'GITHUB-JENKINS', url: 'https://github.com/lalit1980/eks-terraform.git'
                sh 'pwd' 
                sh 'ls -l'
            } //steps
        }  //stage
    
        stage('Terraform Init & Plan') {
         steps {
            
             script{
                sh 'terraform --version'
                sh 'ls -la'
                sh 'terraform init -no-color'
                sh 'ls -la'
                sh 'terraform plan -refresh=true -lock=true -no-color'
             }
            
            } //steps
        }  //stage


    
        stage('Terraform Apply or Destroy') {
            steps {
                script{
                    def ACTION=params.ACTION
                    echo "Hello inside Terraform Apply.........."
                    if(params.ACTION == "apply"){
                        sh 'terraform apply  -auto-approve -no-color'
                    }else if(params.ACTION == "destroy"){
                        sh 'terraform destroy -auto-approve -no-color'
                    }else{
                        echo "No option selected provided...."
                        return
                    }
                    
                }//script
            } //steps
        }  //stage
   }  // stages
} //pipeline
