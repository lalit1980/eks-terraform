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
      choice(name: 'ACTION', choices: ['', 'blue', 'blue-90','split','green-90','green','destroy'], description: 'Select create or delete EKS cluster')
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
                    def yes='true'
                    def no= 'false'
                    def ACTION=params.ACTION
                    if(params.ACTION == "blue"){
                        sh 'terraform apply -var /'traffic_distribution/' = $ACTION -var /'enable_blue_env/'='true' -var /'enable_green_env/'='false' -auto-approve -no-color'
                    }
                    
                }//script
            } //steps
        }  //stage
   }  // stages
} //pipeline
