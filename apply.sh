#!/bin/bash
# vim: set ft=sh

set -eux


if [ ${ACTION} == "blue" ]
    then
        if terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=true -var "enable_green_env"=false -auto-approve -no-color; then
            echo "Terraform apply succeeded."
        else
            echo 'Error: terraform apply failed.' >&2
            exit 1
elif [ ${ACTION} == "green" ]
    then
        if terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color; then
            echo "Terraform apply succeeded."
        else
            echo 'Error: terraform apply failed.' >&2
            exit 1
elif [ ${ACTION} == "blue-90" ]
    then
        if terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color; then
            echo "Terraform apply succeeded."
        else
            echo 'Error: terraform apply failed.' >&2
            exit 1
elif [ ${ACTION} == "split" ]
    then
        if terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color; then
            echo "Terraform apply succeeded."
        else
            echo 'Error: terraform apply failed.' >&2
            exit 1
elif [ ${ACTION} == "green-90" ]
    then
        if terraform apply -var "traffic_distribution=${ACTION}" -var "enable_blue_env"=false -var "enable_green_env"=true -auto-approve -no-color; then
            echo "Terraform apply succeeded."
        else
            echo 'Error: terraform apply failed.' >&2
            exit 1
elif [ ${ACTION} == "destroy" ]
    then
        if terraform destroy -auto-approve -no-color; then
            echo "Terraform destroy succeeded."
        else
            echo 'Error: terraform destroy failed.' >&2
            exit 1
else
    echo 'Error: Nothing selected' >&2
            exit 1

fi








echo "Terraform apply succeeded inside apply.sh file.${ACTION}"
terraform apply -var \'traffic_distribution=${params.ACTION}\'  -var \'enable_blue_env=true\' -var \'enable_green_env=false\' -auto-approve -no-color'