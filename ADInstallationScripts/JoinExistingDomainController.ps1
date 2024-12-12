param (
    [string]$DomainAddress
)
Import-Module ServerManager

# Configuration du mot de passe sous forme de chaine s�curis�
$domainSafeModePassword = ConvertTo-SecureString "Hkrifa1234" -AsPlainText -Force 


try {
    # V�rifier si le domaine est accessible
    $domainController = Get-ADDomainController -Discover -DomainName $DomainAddress
    Write-Host "Connexion au domaine $DomainAddress r�ussi. Contr�leur de domaine trouv� : $($domainController.HostName)" -ForegroundColor Green

    # Promouvoir le serveur en tant que DC en le rajoutant au domaine existant 
    Install-ADDSDomainController -DomainName $DomainAddress -SafeModeAdministratorPassword $domainSafeModePassword -InstallDNS:$true -Force
    Write-Host "Le serveur a été promu en tant que contrôleur de domaine dans le domaine $DomainAddress." -ForegroundColor Green
}
catch {
    if ($_.Exception.Message -like "*Le domaine sp�cifi� n�existe pas ou n�a pas pu �tre contact�*") {
        Write-Host "Le domaine sp�cifi� n'existe pas ou n'est pas accessible. Veuillez vérifier le nom du domaine et la connectivité réseau." -ForegroundColor Red
    }
    else {
        Write-Host "La promotion du serveur a échoué : $_" -ForegroundColor Red
    }
}