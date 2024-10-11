Import-Module ServerManager

# Installer les fonctionnalités nécessaires pour Active Directory
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Vérifier si le rôle est installé correctement
if ((Get-WindowsFeature -Name AD-Domain-Services).InstallState -eq "Installed")
{
    Write-Host "L'installation du rôle Active Directory a réussi." -ForegroundColor Green
}
else
{
    Write-Host "L'installation du rôle Active Directory a échoué." -ForegroundColor Red
    Exit
}

Write-Host "L'installation d'Active Directory et des dépendances est terminée." -ForegroundColor Green
