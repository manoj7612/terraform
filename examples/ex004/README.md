Create a resource group by calling the module in the location '/workspaces/terraform/modules/' by writing the following code construct in main.tf

```
module "rg" {
  source = "/workspaces/terraform/modules/"
  group_name = "TestRG"
  location = "Central India"
}
```

Alternatively you can also write:

```
module "azurerm_resource_group" {
  source = "/workspaces/terraform/modules/"
  group_name = "TestRG"
  location = "Central India"
}
```

