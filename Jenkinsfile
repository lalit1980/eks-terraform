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


    stages{
        stage('Terraform Apply or Destroy') {
            steps {
                script{  
                    if(params.ACTION == "green"){
                        def Action=params.ACTION
                        echo "Action....$ACTION" 
                        sh '''
                            terraform apply -var 'traffic_distribution=$ACTION' -var 'enable_blue_env'=false -var 'enable_green_env'=true -auto-approve -no-color
                        '''
                    }else if(params.ACTION == "blue"){
                        def Action=params.ACTION
                        echo "Action....$ACTION" 
                        sh '''
                            terraform apply -var 'traffic_distribution=$ACTION' -var 'enable_blue_env'=true -var 'enable_green_env'=false -auto-approve -no-color
                        '''
                    }else if(params.ACTION == "blue-90"){
                        def Action=params.ACTION
                        echo "Action....$ACTION" 
                        sh '''
                            terraform apply -var 'traffic_distribution=$ACTION' -var 'enable_blue_env'=false -var 'enable_green_env'=true -auto-approve -no-color
                        '''
                    }else if(params.ACTION == "split"){
                        def Action=params.ACTION
                        echo "Action....$ACTION" 
                        sh '''
                            terraform apply -var 'traffic_distribution=$ACTION' -var 'enable_blue_env'=false -var 'enable_green_env'=true -auto-approve -no-color
                        '''
                    }else if(params.ACTION == "green-90"){
                        def Action=params.ACTION
                        echo "Action....$ACTION" 
                        sh '''
                            terraform apply -var 'traffic_distribution=$ACTION' -var 'enable_blue_env'=false -var 'enable_green_env'=true -auto-approve -no-color
                        '''
                    }
                }
            } //steps
        }  //stage
   }  // stages
} //pipeline
