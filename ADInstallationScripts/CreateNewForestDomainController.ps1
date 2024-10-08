# CreateNewForestDomainController.ps1
Import-Module ServerManager

param (
    [string]$DomainAddress, # domonia.local
    [string]$NetbiosName  # DOMONIA
)

# Configuration du nouveau domaine
# Configuration du mot de passe sous forme de chaine sécurisée
$domainSafeModePassword = ConvertTo-SecureString "Password1234" -AsPlainText -Force 

# Installer et configurer le nouveau domaine
try {
    Install-ADDSForest -DomainName $DomainAddress -DomainNetbiosName $NetbiosName -SafeModeAdministratorPassword $domainSafeModePassword -InstallDNS:$true -Force
    Write-Host "Le domaine $DomainAddress a été créé avec succès." -ForegroundColor Green
}
catch {
    Write-Host "La création du domaine a échoué : $_" -ForegroundColor Red
}
