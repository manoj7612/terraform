**Login to Azure from GitHub Codespaces:**

We have already installed `Azure CLI devcontainers` in the previous setup.
From the terminal window, type the following command to login to Azure:
```
@manoj7612 ➜ /workspaces/terraform (main) $ az login
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code XXXXXXXXX to authenticate.
```

Open the given URL, enter the given code and authenticate yourself using your microsoft account.

Return to terminal window, you will see the following message:

```
Select a subscription and tenant (Type a number or Enter for no changes):
```

Type the number from the given list of tenants and press enter key.  You are now connected to your Azure account from the terminal. 
To confirm, type the following command, it will list all the resource groups under the selected tenant in your account.

```
@manoj7612 ➜ /workspaces/terraform (main) $ az group list
```

