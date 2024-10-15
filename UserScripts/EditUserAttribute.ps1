Import-Module ActiveDirectory
param(
    [Parameter(Mandatory=$true)]
    [string]$accountName,
    [Parameter(Mandatory=$true)]
    [string]$attributeName,
    [Parameter(Mandatory=$true)]
    [string]$newValue
)

# Modification de l'attribut de l'utilisateur
try {
    Set-ADUser -Identity $accountName -Replace @{$attributeName = $newValue}
    Write-Host "L'attribut '$attributeName' a été modifié avec succès pour l'utilisateur '$accountName'." -ForegroundColor Green
} catch {
    Write-Error "Une erreur est survenue lors de la modification de l'attribut : $_ : $($_.Exception.Message)" -ForegroundColor Red
}
