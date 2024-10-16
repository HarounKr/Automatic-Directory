param (
    [string]$DomainAddress
)
Import-Module ServerManager

# Configuration du mot de passe sous forme de chaine sécurisée
$domainSafeModePassword = ConvertTo-SecureString "Password1234" -AsPlainText -Force 

# Vérifier si le domaine est accessible
try {
    $domainController = Get-ADDomainController -DomainName $DomainAddress
    Write-Host "Connexion au domaine $DomainAddress réussie. Contrôleur de domaine trouvé : $($domainController.HostName)" -ForegroundColor Green

    # Promouvoir le serveur en tant que DC en le rajoutant au domaine existant 
    Install-ADDSDomainController -DomainName $DomainAddress -SafeModeAdministratorPassword $domainSafeModePassword -InstallDNS:$true -Force
    Write-Host "Le serveur a été promu en tant que contrôleur de domaine dans le domaine $DomainAddress." -ForegroundColor Green
}
catch {
    if ($_.Exception.Message -like "*Could not find domain*") {
        Write-Host "Le domaine spécifié n'existe pas ou n'est pas accessible. Veuillez vérifier le nom du domaine et la connectivité réseau." -ForegroundColor Red
    }
    else {
        Write-Host "La promotion du serveur a échoué : $_" -ForegroundColor Red
    }
}