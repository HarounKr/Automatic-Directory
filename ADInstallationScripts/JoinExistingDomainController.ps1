param (
    [string]$DomainAddress
)
Import-Module ServerManager

# Configuration du mot de passe sous forme de chaine sécurisé
$domainSafeModePassword = ConvertTo-SecureString "Hkrifa1234" -AsPlainText -Force 


try {
    # Vérifier si le domaine est accessible
    $domainController = Get-ADDomainController -Discover -DomainName $DomainAddress
    Write-Host "Connexion au domaine $DomainAddress réussi. Contrôleur de domaine trouvé : $($domainController.HostName)" -ForegroundColor Green

    # Promouvoir le serveur en tant que DC en le rajoutant au domaine existant 
    Install-ADDSDomainController -DomainName $DomainAddress -SafeModeAdministratorPassword $domainSafeModePassword -InstallDNS:$true -Force
    Write-Host "Le serveur a Ã©tÃ© promu en tant que contrÃ´leur de domaine dans le domaine $DomainAddress." -ForegroundColor Green
}
catch {
    if ($_.Exception.Message -like "*Le domaine spécifié n’existe pas ou n’a pas pu être contacté*") {
        Write-Host "Le domaine spécifié n'existe pas ou n'est pas accessible. Veuillez vÃ©rifier le nom du domaine et la connectivitÃ© rÃ©seau." -ForegroundColor Red
    }
    else {
        Write-Host "La promotion du serveur a Ã©chouÃ© : $_" -ForegroundColor Red
    }
}