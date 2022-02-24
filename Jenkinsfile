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
        stage('Terraform Apply or Destroy') {
            steps {
                
                
                script{  
                    if(params.ACTION == "blue"){
                        def ACTION=$params.ACTION
                        echo "Action....$ACTION" 
                        sh './apply.sh'
                        //sh 'terraform apply -var \'traffic_distribution=${params.ACTION}\'  -var \'enable_blue_env=true\' -var \'enable_green_env=false\' -auto-approve -no-color'
                    }else if (params.ACTION == "destroy"){
                        sh ' echo  "Destroy: " '
                           // sh 'terraform destroy -auto-approve -no-color'
                    }else{
                        sh ' echo  "No Action Selected: " '
                        return
                    }
                }
            } //steps
        }  //stage
   }  // stages
} //pipeline
