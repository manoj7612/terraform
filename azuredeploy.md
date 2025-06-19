**Create an ARM template using JSON file named 'azuredeploy.json' as follows:**

```
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "adminUsername": {
      "type": "string",
      "defaultValue": "madevuser",
      "metadata": {
        "description": "Admin username for the VM."
      }
    },
    "sshPublicKey": {
      "type": "string",
      "metadata": {
        "description": "SSH public key for authentication."
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.Network/networkSecurityGroups",
      "apiVersion": "2023-02-01",
      "name": "madevnsg01",
      "location": "[resourceGroup().location]",
      "properties": {
        "securityRules": [
          {
            "name": "AllowSshFromAny",
            "properties": {
              "priority": 100,
              "protocol": "Tcp",
              "access": "Allow",
              "direction": "Inbound",
              "sourceAddressPrefix": "0.0.0.0/0",
   1           "sourcePortRange": "*",
              "destinationAddressPrefix": "*",
              "destinationPortRange": "22"
            }
          }
        ]
      }
    },
    {
      "type": "Microsoft.Network/virtualNetworks",
      "apiVersion": "2023-02-01",
      "name": "maVnet01",
      "location": "[resourceGroup().location]",
      "properties": {
        "addressSpace": {
          "addressPrefixes": ["10.0.0.0/8"]
        },
        "subnets": [
          {
            "name": "maSubnet01",
            "properties": {
              "addressPrefix": "10.1.0.0/16",
              "networkSecurityGroup": {
                "id": "[resourceId('Microsoft.Network/networkSecurityGroups', 'madevnsg01')]"
              }
            }
          }
        ]
      }
    },
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2023-01-01",
      "name": "madevstorage01",
      "location": "[resourceGroup().location]",
      "sku": {
        "name": "Standard_LRS"
      },
      "kind": "StorageV2",
      "properties": {
        "accessTier": "Hot",
        "allowBlobPublicAccess": false,
        "minimumTlsVersion": "TLS1_0",
        "supportsHttpsTrafficOnly": true
      }
    },
    {
      "type": "Microsoft.Network/publicIPAddresses",
      "apiVersion": "2023-02-01",
      "name": "madevvm01mPublicIP",
      "location": "[resourceGroup().location]",
      "properties": {
        "publicIPAllocationMethod": "Dynamic"
      }
    },
    {
      "type": "Microsoft.Network/networkInterfaces",
      "apiVersion": "2023-02-01",
      "name": "madevvm01mNIC",
      "location": "[resourceGroup().location]",
      "dependsOn": [
        "maVnet01",
        "madevnsg01",
        "madevvm01mPublicIP"
      ],
      "properties": {
        "ipConfigurations": [
          {
            "name": "ipconfig1",
            "properties": {
              "subnet": {
                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'maVnet01', 'maSubnet01')]"
              },
              "privateIPAllocationMethod": "Dynamic",
              "publicIPAddress": {
                "id": "[resourceId('Microsoft.Network/publicIPAddresses', 'madevvm01mPublicIP')]"
              }
            }
          }
        ]
      }
    },
    {
      "type": "Microsoft.Compute/virtualMachines",
      "apiVersion": "2023-03-01",
      "name": "madevvm01m",
      "location": "[resourceGroup().location]",
      "dependsOn": [
        "madevvm01mNIC"
      ],
      "properties": {
        "hardwareProfile": {
          "vmSize": "Standard_B1s"
        },
        "osProfile": {
          "computerName": "madevvm01m",
          "adminUsername": "[parameters('adminUsername')]",
          "linuxConfiguration": {
            "disablePasswordAuthentication": true,
            "ssh": {
              "publicKeys": [
                {
                  "path": "[format('/home/{0}/.ssh/authorized_keys', parameters('adminUsername'))]",
                  "keyData": "[parameters('sshPublicKey')]"
                }
              ]
            }
          }
        },
        "storageProfile": {
          "imageReference": {
            "publisher": "Canonical",
            "offer": "0001-com-ubuntu-server-jammy",
            "sku": "22_04-lts",
            "version": "latest"
          },
          "osDisk": {
            "createOption": "FromImage"
          }
        },
        "networkProfile": {
          "networkInterfaces": [
            {
              "id": "[resourceId('Microsoft.Network/networkInterfaces', 'madevvm01mNIC')]"
            }
          ]
        }
      }
    }
  ]
}
```

**Create a Resource group named 'madev'**

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

**Deploy the above template 'azuredeploy.json' using the following command 'az deployment group create'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az deployment group create --resource-group madev --template-file azuredeploy.json --parameters adminUsername=madevuser sshPublicKey="$(cat ~/.ssh/id_rsa.pub)"
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Resources/deployments/azuredeploy",
  "location": null,
  "name": "azuredeploy",
  "properties": {
    "correlationId": "<REDACTED>",
    "dependencies": [
      {
        "dependsOn": [
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01",
            ...
          },
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01",
            ...
          },
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/publicIPAddresses/madevvm01mPublicIP",
            ...
          }
        ],
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkInterfaces/madevvm01mNIC",
        ...
      },
      {
        "dependsOn": [
          {
            "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkInterfaces/madevvm01mNIC",
            ...
          }
        ],
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Compute/virtualMachines/madevvm01m",
        ...
      }
    ],
    "duration": "PT1M3.3991049S",
    "error": null,
    "mode": "Incremental",
    "outputResources": [
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Compute/virtualMachines/madevvm01m"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkInterfaces/madevvm01mNIC"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/publicIPAddresses/madevvm01mPublicIP"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01"
      },
      {
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Storage/storageAccounts/madevstorage01"
      }
    ],
    "parameters": {
      "adminUsername": {
        "type": "String",
        "value": "madevuser"
      },
      "sshPublicKey": {
        "type": "String",
        "value": "<REDACTED SSH PUBLIC KEY>"
      }
    },
    "provisioningState": "Succeeded"
  },
  "resourceGroup": "madev",
  "type": "Microsoft.Resources/deployments"
}
@<REDACTED> ➜ /workspaces/terraform (main) $
```

**Delete the Resource group 'madev'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group delete --name madev
Are you sure you want to perform this operation? (y/n): y
@<REDACTED> ➜ /workspaces/terraform (main) $
```

**Confirm the deletion of Resource group 'madev' by running 'az group show' command for this resource group**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name madev
(ResourceGroupNotFound) Resource group 'madev' could not be found.
Code: ResourceGroupNotFound
Message: Resource group 'madev' could not be found.
@<REDACTED> ➜ /workspaces/terraform (main) $
```
