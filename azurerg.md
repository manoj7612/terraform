**Create a Resource Group named 'madev' in 'Central India' location**

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
```

**List the groups to confirm that 'madev' is created successfully**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group list
[
  {
    "id": "/subscriptions/<REDACTED>/resourceGroups/matest",
    "location": "centralindia",
    "managedBy": null,
    "name": "matest",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {},
    "type": "Microsoft.Resources/resourceGroups"
  },
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
]
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**Create a Virtual Network inside Resource group 'madev' created earlier and assign the address space as '10.0.0.0/8' and subnet as '10.1.0.0/16'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az network vnet create --resource-group madev --name maVnet01 --address-prefix 10.0.0.0/8 --subnet-name maSubnet01 --subnet-prefixes 10.1.0.0/16
{
  "newVNet": {
    "addressSpace": {
      "addressPrefixes": [
        "10.0.0.0/8"
      ]
    },
    "enableDdosProtection": false,
    "etag": "W/\"<REDACTED>\"",
    "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01",
    "location": "centralindia",
    "name": "maVnet01",
    "privateEndpointVNetPolicies": "Disabled",
    "provisioningState": "Succeeded",
    "resourceGroup": "madev",
    "resourceGuid": "<REDACTED>",
    "subnets": [
      {
        "addressPrefix": "10.1.0.0/16",
        "delegations": [],
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01/subnets/maSubnet01",
        "name": "maSubnet01",
        "privateEndpointNetworkPolicies": "Disabled",
        "privateLinkServiceNetworkPolicies": "Enabled",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "type": "Microsoft.Network/virtualNetworks/subnets"
      }
    ],
    "type": "Microsoft.Network/virtualNetworks",
    "virtualNetworkPeerings": []
  }
}
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**List all the Virtual Networks in the Resource Group 'madev'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az network vnet list --resource-group madev
[
  {
    "addressSpace": {
      "addressPrefixes": [
        "10.0.0.0/8"
      ]
    },
    "enableDdosProtection": false,
    "etag": "W/\"<REDACTED>\"",
    "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01",
    "location": "centralindia",
    "name": "maVnet01",
    "privateEndpointVNetPolicies": "Disabled",
    "provisioningState": "Succeeded",
    "resourceGroup": "madev",
    "resourceGuid": "<REDACTED>",
    "subnets": [
      {
        "addressPrefix": "10.1.0.0/16",
        "delegations": [],
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01/subnets/maSubnet01",
        "name": "maSubnet01",
        "privateEndpointNetworkPolicies": "Disabled",
        "privateLinkServiceNetworkPolicies": "Enabled",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "type": "Microsoft.Network/virtualNetworks/subnets"
      }
    ],
    "type": "Microsoft.Network/virtualNetworks",
    "virtualNetworkPeerings": []
  }
]
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**Create a Storage account named 'madevstorage01' inside Resource group 'madev', Virtual network 'maVnet01', SKU as Locally Redundant Storage and in Region 'centralindia'** 

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az storage account create --name madevstorage01 --resource-group madev --location centralindia --sku Standard_LRS --kind StorageV2 --allow-blob-public-access false
{
  "accessTier": "Hot",
  "accountMigrationInProgress": null,
  "allowBlobPublicAccess": false,
  "allowCrossTenantReplication": false,
  "allowSharedKeyAccess": null,
  "allowedCopyScope": null,
  "azureFilesIdentityBasedAuthentication": null,
  "blobRestoreStatus": null,
  "creationTime": "<REDACTED>",
  "customDomain": null,
  "defaultToOAuthAuthentication": null,
  "dnsEndpointType": null,
  "enableExtendedGroups": null,
  "enableHttpsTrafficOnly": true,
  "enableNfsV3": null,
  "encryption": {
    "encryptionIdentity": null,
    "keySource": "Microsoft.Storage",
    "keyVaultProperties": null,
    "requireInfrastructureEncryption": null,
    "services": {
      "blob": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "<REDACTED>"
      },
      "file": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "<REDACTED>"
      },
      "queue": null,
      "table": null
    }
  },
  "extendedLocation": null,
  "failoverInProgress": null,
  "geoReplicationStats": null,
  "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Storage/storageAccounts/madevstorage01",
  "identity": null,
  "immutableStorageWithVersioning": null,
  "isHnsEnabled": null,
  "isLocalUserEnabled": null,
  "isSftpEnabled": null,
  "isSkuConversionBlocked": null,
  "keyCreationTime": {
    "key1": "<REDACTED>",
    "key2": "<REDACTED>"
  },
  "keyPolicy": null,
  "kind": "StorageV2",
  "largeFileSharesState": null,
  "lastGeoFailoverTime": null,
  "location": "centralindia",
  "minimumTlsVersion": "TLS1_0",
  "name": "madevstorage01",
  "networkRuleSet": {
    "bypass": "AzureServices",
    "defaultAction": "Allow",
    "ipRules": [],
    "ipv6Rules": [],
    "resourceAccessRules": null,
    "virtualNetworkRules": []
  },
  "primaryEndpoints": {
    "blob": "https://<REDACTED>.blob.core.windows.net/",
    "dfs": "https://<REDACTED>.dfs.core.windows.net/",
    "file": "https://<REDACTED>.file.core.windows.net/",
    "internetEndpoints": null,
    "microsoftEndpoints": null,
    "queue": "https://<REDACTED>.queue.core.windows.net/",
    "table": "https://<REDACTED>.table.core.windows.net/",
    "web": "https://<REDACTED>.z29.web.core.windows.net/"
  },
  "primaryLocation": "centralindia",
  "privateEndpointConnections": [],
  "provisioningState": "Succeeded",
  "publicNetworkAccess": null,
  "resourceGroup": "madev",
  "routingPreference": null,
  "sasPolicy": null,
  "secondaryEndpoints": null,
  "secondaryLocation": null,
  "sku": {
    "name": "Standard_LRS",
    "tier": "Standard"
  },
  "statusOfPrimary": "available",
  "statusOfSecondary": null,
  "storageAccountSkuConversionStatus": null,
  "tags": {},
  "type": "Microsoft.Storage/storageAccounts"
}
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**List all the Storage accounts in Resource group 'madev'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az storage account list --resource-group madev
[
  {
    "accessTier": "Hot",
    "accountMigrationInProgress": null,
    "allowBlobPublicAccess": false,
    "allowCrossTenantReplication": false,
    "allowSharedKeyAccess": null,
    "allowedCopyScope": null,
    "azureFilesIdentityBasedAuthentication": null,
    "blobRestoreStatus": null,
    "creationTime": "<REDACTED>",
    "customDomain": null,
    "defaultToOAuthAuthentication": null,
    "dnsEndpointType": null,
    "enableExtendedGroups": null,
    "enableHttpsTrafficOnly": true,
    "enableNfsV3": null,
    "encryption": {
      "encryptionIdentity": null,
      "keySource": "Microsoft.Storage",
      "keyVaultProperties": null,
      "requireInfrastructureEncryption": null,
      "services": {
        "blob": {
          "enabled": true,
          "keyType": "Account",
          "lastEnabledTime": "<REDACTED>"
        },
        "file": {
          "enabled": true,
          "keyType": "Account",
          "lastEnabledTime": "<REDACTED>"
        },
        "queue": null,
        "table": null
      }
    },
    "extendedLocation": null,
    "failoverInProgress": null,
    "geoReplicationStats": null,
    "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Storage/storageAccounts/madevstorage01",
    "identity": null,
    "immutableStorageWithVersioning": null,
    "isHnsEnabled": null,
    "isLocalUserEnabled": null,
    "isSftpEnabled": null,
    "isSkuConversionBlocked": null,
    "keyCreationTime": {
      "key1": "<REDACTED>",
      "key2": "<REDACTED>"
    },
    "keyPolicy": null,
    "kind": "StorageV2",
    "largeFileSharesState": null,
    "lastGeoFailoverTime": null,
    "location": "centralindia",
    "minimumTlsVersion": "TLS1_0",
    "name": "madevstorage01",
    "networkRuleSet": {
      "bypass": "AzureServices",
      "defaultAction": "Allow",
      "ipRules": [],
      "ipv6Rules": [],
      "resourceAccessRules": null,
      "virtualNetworkRules": []
    },
    "primaryEndpoints": {
      "blob": "https://<REDACTED>.blob.core.windows.net/",
      "dfs": "https://<REDACTED>.dfs.core.windows.net/",
      "file": "https://<REDACTED>.file.core.windows.net/",
      "internetEndpoints": null,
      "microsoftEndpoints": null,
      "queue": "https://<REDACTED>.queue.core.windows.net/",
      "table": "https://<REDACTED>.table.core.windows.net/",
      "web": "https://<REDACTED>.z29.web.core.windows.net/"
    },
    "primaryLocation": "centralindia",
    "privateEndpointConnections": [],
    "provisioningState": "Succeeded",
    "publicNetworkAccess": null,
    "resourceGroup": "madev",
    "routingPreference": null,
    "sasPolicy": null,
    "secondaryEndpoints": null,
    "secondaryLocation": null,
    "sku": {
      "name": "Standard_LRS",
      "tier": "Standard"
    },
    "statusOfPrimary": "available",
    "statusOfSecondary": null,
    "storageAccountSkuConversionStatus": null,
    "tags": {},
    "type": "Microsoft.Storage/storageAccounts"
  }
]
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**Create a Network security group named madevnsg01 inside Resource group 'madev'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az network nsg create --name madevnsg01 --resource-group madev
{
  "NewNSG": {
    "defaultSecurityRules": [
      {
        "access": "Allow",
        "description": "Allow inbound traffic from all VMs in VNET",
        "destinationAddressPrefix": "VirtualNetwork",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01/defaultSecurityRules/AllowVnetInBound",
        "name": "AllowVnetInBound",
        "priority": 65000,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "sourceAddressPrefix": "VirtualNetwork",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow inbound traffic from azure load balancer",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01/defaultSecurityRules/AllowAzureLoadBalancerInBound",
        "name": "AllowAzureLoadBalancerInBound",
        "priority": 65001,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "sourceAddressPrefix": "AzureLoadBalancer",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Deny",
        "description": "Deny all inbound traffic",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01/defaultSecurityRules/DenyAllInBound",
        "name": "DenyAllInBound",
        "priority": 65500,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow outbound traffic from all VMs to all VMs in VNET",
        "destinationAddressPrefix": "VirtualNetwork",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01/defaultSecurityRules/AllowVnetOutBound",
        "name": "AllowVnetOutBound",
        "priority": 65000,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "sourceAddressPrefix": "VirtualNetwork",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow outbound traffic from all VMs to Internet",
        "destinationAddressPrefix": "Internet",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01/defaultSecurityRules/AllowInternetOutBound",
        "name": "AllowInternetOutBound",
        "priority": 65001,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Deny",
        "description": "Deny all outbound traffic",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"<REDACTED>\"",
        "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01/defaultSecurityRules/DenyAllOutBound",
        "name": "DenyAllOutBound",
        "priority": 65500,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "madev",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      }
    ],
    "etag": "W/\"<REDACTED>\"",
    "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01",
    "location": "centralindia",
    "name": "madevnsg01",
    "provisioningState": "Succeeded",
    "resourceGroup": "madev",
    "resourceGuid": "<REDACTED>",
    "securityRules": [],
    "type": "Microsoft.Network/networkSecurityGroups"
  }
}
@<REDACTED> ➜ /workspaces/terraform (main) $ 
 
```

**Create a rule in the above nsg 'madevnsg01' to allow incoming connections on port 22**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az network nsg rule create --resource-group madev --nsg-name madevnsg01 --name AllowSshFromAny --priority 100 --access Allow --protocol Tcp --direction Inbound --destination-port-ranges 22 --source-address-prefixes 0.0.0.0/0
{
  "access": "Allow",
  "destinationAddressPrefix": "*",
  "destinationAddressPrefixes": [],
  "destinationPortRange": "22",
  "destinationPortRanges": [],
  "direction": "Inbound",
  "etag": "W/\"<REDACTED>\"",
  "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01/securityRules/AllowSshFromAny",
  "name": "AllowSshFromAny",
  "priority": 100,
  "protocol": "Tcp",
  "provisioningState": "Succeeded",
  "resourceGroup": "madev",
  "sourceAddressPrefix": "0.0.0.0/0",
  "sourceAddressPrefixes": [],
  "sourcePortRange": "*",
  "sourcePortRanges": [],
  "type": "Microsoft.Network/networkSecurityGroups/securityRules"
}
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**Attach the above NSG to the Subnet we have already created above**


```
@<REDACTED> ➜ /workspaces/terraform (main) $ az network vnet subnet update --resource-group madev --vnet-name maVnet01 --name maSubnet01 --network-security-group madevnsg01
{
  "addressPrefix": "10.1.0.0/16",
  "delegations": [],
  "etag": "W/\"<REDACTED>\"",
  "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/virtualNetworks/maVnet01/subnets/maSubnet01",
  "name": "maSubnet01",
  "networkSecurityGroup": {
    "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Network/networkSecurityGroups/madevnsg01",
    "resourceGroup": "madev"
  },
  "privateEndpointNetworkPolicies": "Disabled",
  "privateLinkServiceNetworkPolicies": "Enabled",
  "provisioningState": "Succeeded",
  "resourceGroup": "madev",
  "type": "Microsoft.Network/virtualNetworks/subnets"
}
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**Now create a Ubuntu Virtual machine in Resource group 'madev', using Virtual network 'maVnet01', subnet 'maSubnet01', inside region 'centralindia' and inside Storage account 'madevstorage01'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az vm create --resource-group madev --name madevvm01m --image Ubuntu2204 --size Standard_B1s --vnet-name maVnet01 --subnet maSubnet01 --admin-username madevuser --generate-ssh-keys
SSH key files '/home/codespace/.ssh/id_rsa' and '/home/codespace/.ssh/id_rsa.pub' have been generated under ~/.ssh to allow SSH access to the VM. If using machines without permanent storage, back up your keys to a safe location.
{
  "fqdns": "",
  "id": "/subscriptions/<REDACTED>/resourceGroups/madev/providers/Microsoft.Compute/virtualMachines/madevvm01m",
  "location": "centralindia",
  "macAddress": "<REDACTED>",
  "powerState": "VM running",
  "privateIpAddress": "<REDACTED>",
  "publicIpAddress": "<REDACTED>",
  "resourceGroup": "madev",
  "zones": ""
}
@<REDACTED> ➜ /workspaces/terraform (main) $
```

**Now delete the Resource group madev to delete everything inside it**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group delete --name madev
Are you sure you want to perform this operation? (y/n): y
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```

**Check to confirm that the Resource group madev is deleted**

**Note:** 'az group list' command is used to list all the resource groups whereas 'az group show' command is used to list specific rosource group specified with '--name <resourcegroup>' parameter.

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name madev
(ResourceGroupNotFound) Resource group 'madev' could not be found.
Code: ResourceGroupNotFound
Message: Resource group 'madev' could not be found.
@<REDACTED> ➜ /workspaces/terraform (main) $ 
```
