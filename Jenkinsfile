#!/usr/bin/groovy

pipeline{
    agent any 
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    environment {
        TF_HOME = tool('terraform')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
    }
    stages {
 
    stage('Git Checkout') {
        steps {
        checkout scm 
        }
    }


    stage('Login to Azure') {
        steps {
                azureCLI commands: [[exportVariablesString: '', script: 'az login --service-principal -u "$ARM_CLIENT_ID" -p "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"']], principalCredentialId: 'Jenkins'

            }
        }
    }
    
    stage('Terraform Init') {
        steps {

    withCredentials([azureServicePrincipal(
    credentialsId: 'Jenkins',
    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
    clientIdVariable: 'ARM_CLIENT_ID',
    clientSecretVariable: 'ARM_CLIENT_SECRET',
    tenantIdVariable: 'ARM_TENANT_ID'
  ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
        
        sh """
                
        echo "Initialising Terraform"
        terraform init -no-color \
                       -backend-config="resource_group_name=Jenkins" \
                       -backend-config="storage_account_name=tfbackend2020" \
                       -backend-config="container_name=tfremote" \
                       -backend-config="key=terraform.tfstate" \
                       -backend-config="access_key=$ARM_ACCESS_KEY"
        """
            }
        }
    }

    stage('Terraform Plan') {
        steps {

    withCredentials([azureServicePrincipal(
    credentialsId: 'Jenkins',
    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
    clientIdVariable: 'ARM_CLIENT_ID',
    clientSecretVariable: 'ARM_CLIENT_SECRET',
    tenantIdVariable: 'ARM_TENANT_ID'
  ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
        
        sh """
        
        echo "Creating Terraform Plan"
        terraform plan -no-color -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID" 
        """
            }
        }
    }

    stage('Waiting for Approval') {

        timeout(time: 10, unit: 'MINUTES') {
          input (message: "Deploy the infrastructure?")
            }
        
        }
    

    stage('Terraform Apply') {
        steps {
        
    withCredentials([azureServicePrincipal(
    credentialsId: 'Jenkins',
    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
    clientIdVariable: 'ARM_CLIENT_ID',
    clientSecretVariable: 'ARM_CLIENT_SECRET',
    tenantIdVariable: 'ARM_TENANT_ID'
  ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {

        sh """
        echo "Applying the plan"
        terraform apply -auto-approve -no-color -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID" 
        """
                }
            }
        }
    }
}