param (
    [Parameter(Mandatory=$true)]
    [string]$DomainAddress, # Ex : domolia.local
    [Parameter(Mandatory=$true)]
    [string]$NetbiosName  # Ex : DOMOLIA
)

# V�rifier et importer le module ServerManager
if (-not (Get-Module -ListAvailable -Name ServerManager)) {
    Write-Host "Le module ServerManager n'est pas disponible. Veuillez l'installer avant de continuer." -ForegroundColor Red
    exit 1
}

Import-Module ServerManager

# Configuration du mot de passe sous forme de cha�ne s�curis�e
$domainSafeModePassword = ConvertTo-SecureString "Hkrifa1234" -AsPlainText -Force 

# Installer et configurer le nouveau domaine
try {
    Write-Host "Cr�ation du domaine $DomainAddress..." -ForegroundColor Yellow
    Install-ADDSForest -DomainName $DomainAddress -DomainNetbiosName $NetbiosName -SafeModeAdministratorPassword $domainSafeModePassword -InstallDNS:$true -Force
    Write-Host "Le domaine $DomainAddress a �t� cr�� avec succ�s." -ForegroundColor Green
    
    # Red�marrer la machine pour finaliser la configuration
    Write-Host "Red�marrage en cours pour finaliser la configuration..." -ForegroundColor Yellow
    Restart-Computer -Force
}
catch {
    Write-Host "La cr�ation du domaine a �chou� : $($_.Exception.Message)" -ForegroundColor Red
}
