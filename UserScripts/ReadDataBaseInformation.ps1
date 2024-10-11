Import-Module ActiveDirectory

param(
    [string[]]$attributesToRetrieve  # Attributs à récupérer pour tous les utilisateurs
)

# Récupération et affichage des informations de tous les utilisateurs
try {
    # Récupération des utilisateurs et des attributs spécifiés
    $users = Get-ADUser -Filter * -Properties $attributesToRetrieve

    # Affichage des informations récupérées pour chaque utilisateur
    foreach ($user in $users) {
        Write-Host "User: $($user.SamAccountName)"
        foreach ($attr in $attributesToRetrieve) {
            Write-Host "`t$attr: $($user.$attr)"
        }
        Write-Host ""
    }
} catch {
    Write-Error "Une erreur est survenue lors de la récupération des informations : $_" -ForegroundColor Red
}

# .\ReadDataBaseInformation.ps1 -attributesToRetrieve "SamAccountName", "mail", "department"
