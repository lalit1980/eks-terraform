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
      choice(name: 'ACTION', choices: ['', 'plan-apply', 'destroy'], description: 'Select create or delete EKS cluster')
    }
    stages{
        stage('Clean Workspace') { 
            steps {
                cleanWs()
                sh 'env'
                script{
                    if (params.ACTION == ""){
                        currentBuild.result = 'ABORTED'
                        error('Aborting the build as no action selected.')
                        return
                    }
                }
            } //steps
        }  //stage

        //${params.Acción}
        stage("SCM Checkout"){
            steps {
                git branch: env.BRANCH_NAME, credentialsId: 'GITHUB-JENKINS', url: 'https://github.com/lalit1980/eks-terraform.git'
                sh 'pwd' 
                sh 'ls -l'
            } //steps
        }  //stage
    
        stage('Terraform Init') {
         steps {
            sh 'terraform --version'
            sh 'ls -la'
            sh 'terraform init -no-color'
            } //steps
        }  //stage

        stage('Terraform Plan') {
            steps {
               sh 'ls -la'
               sh 'terraform plan -refresh=true -lock=true -no-color'
            }  
        }  //stage
        
        
        stage('Terraform Apply or Destroy') {
            steps {
                script{  
                    if (params.ACTION == "destroy"){
                            sh 'terraform destroy -auto-approve -no-color'
                    } else if (params.ACTION == "plan-apply"){
                            sh 'terraform apply -refresh=true -auto-approve -no-color'  
                            sh ' aws eks update-kubeconfig --name eks' 
                            sh ' kubectl get nodes' 
                            sh ' kubectl get deploy' 
                            sh ' kubectl get pods' 
                            sh ' kubectl get svc' 
                    } else{
                        sh ' echo  "No Action Selected: " '
                    } // if
                }
            } //steps
        }  //stage
   }  // stages
} //pipeline