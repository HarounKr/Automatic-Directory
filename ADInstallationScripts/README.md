# Scripts d'installation AD

## Description
Ces scripts PowerShell permettent d'installer et de configurer un contrôleur de domaine Active Directory.

## Scripts

| Nom | Description | Paramètre |
|------|------------|-----------|
| **ADPackageInstallor.ps1** | Installe Active Directory et toutes les dépendances nécessaires au rôle de contrôleur de domaine | Aucun paramètre requis |
| **CreateNewForestDomainController.ps1** | Promeut un serveur AD en contrôleur de domaine en créant une nouvelle forêt | - DomainAddress <br> - NetbiosName |
| **JoinExistingDomainController.ps1** | Promeut un serveur AD en contrôleur de domaine en rejoignant un domaine existant | - DomainAddress |

## Utilisation

| Script | Commande |
|:--------|:---------|
| **ADPackageInstallor.ps1** | `.\ADPackageInstallor.ps1` |
| **CreateNewForestDomainController.ps1** | `.\CreateNewForestDomainController.ps1 -DomainAddress "domolia.local" -NetbiosName "DOMOLIA"` |
| **JoinExistingDomainController.ps1** | `.\JoinExistingDomainController.ps1 -DomainAddress "domolia.local"` |