**Create a Virtual machine using an ARM Template that uses a parameters file to provide various user-defined parameters towards creation of the Virtual machine**

**Create a resource group named 'madev' in location 'centralindia'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group create --name madev --location centralindia
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/madev",
  "location": "centralindia",
  "managedBy": null,
  "name": "madev",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
@<REDACTED> ➜ /workspaces/terraform (main) $
```

**Generate SSH key pair and store it in '~/.ssh'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ ssh-keygen -t rsa -b 2048 -f ~/.ssh/madevvm_key
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/<REDACTED>/.ssh/madevvm_key
Your public key has been saved in /home/<REDACTED>/.ssh/madevvm_key.pub
The key fingerprint is:
SHA256:<REDACTED> <REDACTED>@<REDACTED>
The key's randomart image is:
+---[RSA 2048]----+
|          .oBB*+o|
|          .E+Boo.|
|         .  . B..|
|          o  +.oo|
|        So . .+o+|
|       ...+  oo=.|
|         ..o.oB .|
|           .+* ..|
|           . o=oo|
+----[SHA256]-----+
@<REDACTED> ➜ /workspaces/terraform (main) $ ls ~/.ssh
id_rsa  id_rsa.pub  madevvm_key  madevvm_key.pub
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**Deploy the ARM Template with the Parameters file**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az deployment group create --resource-group madev --template-file azuredeploy.json --parameters @azuredeploy.parameters.json --parameters sshPublicKey="$(cat ~/.ssh/madevvm_key.pub)"
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Resources/deployments/azuredeploy",
  "location": null,
  "name": "azuredeploy",
  "properties": {
    "correlationId": "<REDACTED>",
    "debugSetting": null,
    "dependencies": [
      {
        "dependsOn": [
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01",
            "resourceGroup": "madev",
            "resourceName": "maVnet01",
            "resourceType": "Microsoft.Network/virtualNetworks"
          },
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01",
            "resourceGroup": "madev",
            "resourceName": "madevnsg01",
            "resourceType": "Microsoft.Network/networkSecurityGroups"
          },
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/publicIPAddresses/madevvm01mPublicIP",
            "resourceGroup": "madev",
            "resourceName": "madevvm01mPublicIP",
            "resourceType": "Microsoft.Network/publicIPAddresses"
          }
        ],
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkInterfaces/madevvm01mNIC",
        "resourceGroup": "madev",
        "resourceName": "madevvm01mNIC",
        "resourceType": "Microsoft.Network/networkInterfaces"
      },
      {
        "dependsOn": [
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkInterfaces/madevvm01mNIC",
            "resourceGroup": "madev",
            "resourceName": "madevvm01mNIC",
            "resourceType": "Microsoft.Network/networkInterfaces"
          }
        ],
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Compute/virtualMachines/madevvm01m",
        "resourceGroup": "madev",
        "resourceName": "madevvm01m",
        "resourceType": "Microsoft.Compute/virtualMachines"
      }
    ],
    "duration": "PT41.5608097S",
    "error": null,
    "mode": "Incremental",
    "onErrorDeployment": null,
    "outputResources": [
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Compute/virtualMachines/madevvm01m",
        "resourceGroup": "madev"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkInterfaces/madevvm01mNIC",
        "resourceGroup": "madev"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01",
        "resourceGroup": "madev"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/publicIPAddresses/madevvm01mPublicIP",
        "resourceGroup": "madev"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01",
        "resourceGroup": "madev"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Storage/storageAccounts/madevstorage01",
        "resourceGroup": "madev"
      }
    ],
    "outputs": null,
    "parameters": {
      "adminUsername": {
        "type": "String",
        "value": "madevuser"
      },
      "nicName": {
        "type": "String",
        "value": "madevvm01mNIC"
      },
      "nsgName": {
        "type": "String",
        "value": "madevnsg01"
      },
      "publicIpName": {
        "type": "String",
        "value": "madevvm01mPublicIP"
      },
      "sshPublicKey": {
        "type": "String",
        "value": "<REDACTED_PUBLIC_KEY>"
      },
      "storageAccountName": {
        "type": "String",
        "value": "madevstorage01"
      },
      "subnetAddressPrefix": {
        "type": "String",
        "value": "10.1.0.0/16"
      },
      "subnetName": {
        "type": "String",
        "value": "maSubnet01"
      },
      "vmName": {
        "type": "String",
        "value": "madevvm01m"
      },
      "vmSize": {
        "type": "String",
        "value": "Standard_B1s"
      },
      "vnetAddressPrefix": {
        "type": "String",
        "value": "10.0.0.0/8"
      },
      "vnetName": {
        "type": "String",
        "value": "maVnet01"
      }
    },
    "provisioningState": "Succeeded",
    "templateHash": "<REDACTED>",
    "timestamp": "<REDACTED_TIMESTAMP>"
  },
  "resourceGroup": "madev",
  "tags": null,
  "type": "Microsoft.Resources/deployments"
}
@<REDACTED> ➜ /workspaces/terraform (main) $

```





