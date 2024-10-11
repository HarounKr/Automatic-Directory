Import-Module ActiveDirectory
param(
    [string]$accountName,
    [string]$attributeName,
    [string]$newValue
)

# Modification de l'attribut de l'utilisateur
try {
    Set-ADUser -Identity $accountName -Replace @{$attributeName = $newValue}

    Write-Host "L'attribut '$attributeName' a été modifié avec succès pour l'utilisateur '$accountName'." -ForegroundColor Green
} catch {
    Write-Error "Une erreur est survenue lors de la modification de l'attribut : $_" -ForegroundColor Red
}
