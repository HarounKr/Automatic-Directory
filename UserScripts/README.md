# Scripts utilisateur

Ces scripts permettent de gérer les utilisateurs dans l'Active Directory en effectuant des actions comme la création de comptes, la modification d'attributs et la récupération d'informations.

### Liste des scripts

| Nom | Description | Paramètres |
|------|------------|------------|
| **UserCreation.ps1** | Permet de créer un utilisateur via un hashtable. | - Nom du compte <br> - Unité organisationnelle à rejoindre <br> - Groupe souhaité |
| **ResetUserPassword.ps1** | Réinitialise le mot de passe d'un utilisateur spécifié. | - Nom du compte |
| **EditUserAttribute.ps1** | Modifie un attribut d'un utilisateur et lui attribue une nouvelle valeur. | - Nom du compte <br> - Nom de l'attribut <br> - Valeur souhaitée |
| **ReadUserInformation.ps1** | Récupère les informations d'un utilisateur à partir du serveur. | - Nom du compte <br> - Filtre des attributs à récupérer |
| **ReadDataBaseInformation.ps1** | Récupère les informations de tous les utilisateurs depuis le serveur. | - Nom du compte <br> - Filtre des attributs à récupérer |

### Utilisation

| Script | Commande |
|--------|---------|
| **UserCreation.ps1** | `.\UserCreation.ps1 -accountName "hkrifa" -ou "OU=TestUnit,DC=domolia,DC=local" -groupeName "Test"` |
| **ResetUserPassword.ps1** | `.\ResetUserPassword.ps1 -accountName "hkrifa"` |
| **EditUserAttribute.ps1** | `.\EditUserAttribute.ps1 -accountName "hkrifa" -attributeName "GivenName" -newValue "krifa"` |
| **ReadUserInformation.ps1** | `.\ReadUserInformation.ps1 -accountName "hkrifa" -attributesToRetrieve "displayName", "mail", "department"` |
| **ReadDataBaseInformation.ps1** | ` .\ReadDataBaseInformation.ps1 -attributesToRetrieve "SamAccountName", "mail", "department"` |