param (
    [Parameter(Mandatory=$true)]
    [string]$DomainAddress, # Ex : domolia.local
    [Parameter(Mandatory=$true)]
    [string]$NetbiosName  # Ex : DOMOLIA
)

# Vérifier et importer le module ServerManager
if (-not (Get-Module -ListAvailable -Name ServerManager)) {
    Write-Host "Le module ServerManager n'est pas disponible. Veuillez l'installer avant de continuer." -ForegroundColor Red
    exit 1
}

Import-Module ServerManager

# Configuration du mot de passe sous forme de chaîne sécurisée
$domainSafeModePassword = ConvertTo-SecureString "Hkrifa1234" -AsPlainText -Force 

# Installer et configurer le nouveau domaine
try {
    Write-Host "Création du domaine $DomainAddress..." -ForegroundColor Yellow
    Install-ADDSForest -DomainName $DomainAddress -DomainNetbiosName $NetbiosName -SafeModeAdministratorPassword $domainSafeModePassword -InstallDNS:$true -Force
    Write-Host "Le domaine $DomainAddress a été créé avec succès." -ForegroundColor Green
    
    # Redémarrer la machine pour finaliser la configuration
    Write-Host "Redémarrage en cours pour finaliser la configuration..." -ForegroundColor Yellow
    Restart-Computer -Force
}
catch {
    Write-Host "La création du domaine a échoué : $($_.Exception.Message)" -ForegroundColor Red
}
