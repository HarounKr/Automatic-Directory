param(
    [Parameter(Mandatory=$true)]
    [string]$accountName,
    [Parameter(Mandatory=$true)]
    [string]$attributeName,
    [Parameter(Mandatory=$true)]
    [string]$newValue
)

Import-Module ActiveDirectory

# Modification de l'attribut de l'utilisateur
try {
    Set-ADUser -Identity $accountName -Replace @{$attributeName = $newValue}
    Write-Host "L'attribut '$attributeName' a été modifié avec succés pour l'utilisateur '$accountName'." -ForegroundColor Green
} catch {
    Write-Error "Une erreur est survenue lors de la modification de l'attribut : $_ : $($_.Exception.Message)"
}


# .\EditUserAttribute.ps1 -accountName "hkrifa" -attributeName "GivenName" -newValue "Le bogoss"