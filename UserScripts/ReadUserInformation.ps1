Import-Module ActiveDirectory

param(
    [Parameter(Mandatory=$true)]
    [string]$accountName,  # Nom de compte de l'utilisateur

    [string[]]$attributesToRetrieve  # Attributs à récupérer
)

# Récupération des informations de l'utilisateur
try {
    # Récupération des attributs spécifiés de l'utilisateur
    $userInfo = Get-ADUser -Identity $accountName -Properties $attributesToRetrieve
    
    # Affichage des informations récupérées
    $attributesToRetrieve | ForEach-Object {
        Write-Host "$_: $($userInfo.$_)"
    }
} catch {
    Write-Error "Une erreur est survenue lors de la récupération des informations : $_" -ForegroundColor Red
}


# .\ReadUserInformation.ps1 -accountName "hkrifa" -attributesToRetrieve "displayName", "mail", "department"
