#!/usr/bin/env bash


if [ ${ACTION} == "blue" ]
    then
    terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=true -var "enable_green_env"=false -auto-approve -no-color
        
elif [ ${ACTION} == "green" ]
    then
    terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color
        
elif [ ${ACTION} == "blue-90" ]
    then
    terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color
        
elif [ ${ACTION} == "split" ]
    then
    terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color

elif [ ${ACTION} == "green-90" ]
    then
    terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color
        
elif [ ${ACTION} == "destroy" ]
    then
    terraform destroy -auto-approve -no-color
        
else
    echo 'Error: Nothing selected'
fi








echo "Terraform apply succeeded inside apply.sh file.${ACTION}"
terraform apply -var \'traffic_distribution=${params.ACTION}\'  -var \'enable_blue_env=true\' -var \'enable_green_env=false\' -auto-approve -no-color'