# Scripts d'installation AD

## Description
Ces scripts PowerShell permettent d'installer et de configurer un contrôleur de domaine Active Directory.

## Scripts

| Nom | ADPackageInstallor.ps1 |
|------|------------------------|
| **Description** | Installe Active Directory et toutes les dépendances nécessaires au rôle de contrôleur de domaine |
| **Paramètre** | Aucun paramètre requis |

| Nom | CreateNewForestDomainController.ps1 |
|------|-------------------------------------|
| **Description** | Promeut un serveur AD en contrôleur de domaine en créant une nouvelle forêt |
| **Paramètre** | - DomainAddress / - NetbiosName |

| Nom | JoinExistingDomainController.ps1 |
|------|----------------------------------|
| **Description** | Promeut un serveur AD en contrôleur de domaine en rejoignant un domaine existant |
| **Paramètre** | - DomainAddress |

## Utilisation

| Script | Commande |
|--------|---------|
| **ADPackageInstallor.ps1** | `.\ADPackageInstallor.ps1` |
| **CreateNewForestDomainController.ps1** | `.\CreateNewForestDomainController.ps1 -DomainAddress "domolia.local" -NetbiosName "DOMOLIA"` |
| **JoinExistingDomainController.ps1** | `.\JoinExistingDomainController.ps1 -DomainAddress "domolia.local"` |