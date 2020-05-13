#!/usr/bin/groovy

node {
 
    stage('Git Checkout') {
        checkout scm 
    }

    stage('Install Az-CLI and Terraform') {

        sh """
        
        echo "[*] Installing AZ CLI"
        rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
        
        yum install -y wget unzip azure-cli
        wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.24_linux_amd64.zip
        
        unzip ./terraform_0.12.24_linux_amd64.zip -d /usr/local/bin/
        
        terraform -v
        echo "[*] Terraform installation is successful !!!"
        """
    }

    stage('Login to Azure') {

    withCredentials([azureServicePrincipal(
    credentialsId: 'Jenkins',
    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
    clientIdVariable: 'ARM_CLIENT_ID',
    clientSecretVariable: 'ARM_CLIENT_SECRET',
    tenantIdVariable: 'ARM_TENANT_ID'
  ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {

        sh """
        echo "[*] Logging to Azure with Terraform Service Principal using Azure CLI"
        
        az login --service-principal -u "$ARM_CLIENT_ID" -p "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"
        echo "[*] Azure authentication is successful !!!"
        echo ""
        az account set -s $ARM_SUBSCRIPTION_ID

        """
        }
    }
    
    stage('Terraform Init') {

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

    stage('Terraform Plan') {

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

    stage('Waiting for Approval') {

        timeout(time: 10, unit: 'MINUTES') {
          input (message: "Deploy the infrastructure?")
            }
        
        }
    

    stage('Terraform Apply') {
        
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