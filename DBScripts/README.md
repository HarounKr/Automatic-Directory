# Scripts de base de données

Ces scripts permettent d'enregistrer et de charger des bases de données contenant les utilisateurs et groupes du contrôleur de domaine.

### Liste des scripts

| Nom | Description | Paramètres |
|------|------------|------------|
| **SaveDataBase.ps1** | Crée une base de données pour stocker tous les utilisateurs et groupes du contrôleur de domaine | - Chemin pour enregistrer le fichier .CSV <br> - Délimiteur souhaité <br> - Nombre indéfini de paramètres pour composer la base de données |
| **LoadDataBase.ps1** | Charge une base de données à partir d'un fichier enregistré | - Chemin du fichier .CSV à charger <br> - Délimiteur du fichier |

### Utilisation

| Script | Commande |
|--------|---------|
| **SaveDataBase.ps1** | `.\SaveDataBase.ps1 -Path "C:\Path\to\file.csv" -Delimiter ";" -AdditionalParameters 'DistinguishedName', 'Description', 'ObjectClass', 'ObjectGUID', 'WhenCreated', 'WhenChanged'` |
| **LoadDataBase.ps1** | `.\LoadDataBase.ps1 -Path "C:\Path\to\file.csv" -Delimiter ";"` |