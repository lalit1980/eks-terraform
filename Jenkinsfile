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
      choice(name: 'ACTION', choices: ['', 'traffic-distribution-apply-blue', 'traffic-distribution-apply-blue-90','traffic-distribution-apply-split','traffic-distribution-apply-green-90','traffic-distribution-apply-green','destroy'], description: 'Select create or delete EKS cluster')
    }
    stages{
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

        //${params.Acción}
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
                    if(params.ACTION == "traffic-distribution-apply-blue"){
                        sh 'terraform apply -var traffic_distribution=blue  -var enable_blue_env=true -var enable_green_env=false -auto-approve -no-color'
                    }else if(params.ACTION == "traffic-distribution-apply-green"){
                        sh 'terraform apply -var traffic_distribution=green  -var enable_blue_env=false -var enable_green_env=true -auto-approve -no-color'
                    }else if(params.ACTION == "traffic-distribution-apply-blue-90"){
                        sh 'terraform apply -var traffic_distribution=blue-90 -var enable_green_env=true -auto-approve -no-color'
                    }else if(params.ACTION == "traffic-distribution-apply-split"){
                        sh 'terraform apply -var traffic_distribution=split -var enable_green_env=true -auto-approve -no-color'
                    }else if(params.ACTION == "traffic-distribution-apply-green-90"){
                        sh 'terraform apply -var traffic_distribution=green-90 -var enable_green_env=true -auto-approve -no-color'
                    }else if (params.ACTION == "destroy"){
                            sh 'terraform destroy -auto-approve -no-color'
                    }else{
                        sh ' echo  "No Action Selected: " '
                        return
                    }
                    sh ' aws eks update-kubeconfig --name eks' 
                    sh ' kubectl get all'
                    sh ' kubectl get nodes' 
                    sh ' kubectl get deploy' 
                    sh ' kubectl get pods' 
                    sh ' kubectl get svc' 
                }
            } //steps
        }  //stage
   }  // stages
} //pipeline
