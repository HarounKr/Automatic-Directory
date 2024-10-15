Import-Module ActiveDirectory

param (
    [Parameter(Mandatory=$true)]
    [string]$GroupName,
    [Parameter(Mandatory=$true)]
    [string]$attributeName,
    [Parameter(Mandatory=$true)]
    [string]$newValue
)

# Modification de l'attribut du groupe
try {
    $group = Get-ADGroup -Identity $GroupName
    if ($group) {
        Set-ADGroup -Identity $accountName -Replace @{$attributeName = $newValue}
        Write-Host "L'attribut '$attributeName' a été modifié avec succès pour le groupe '$accountName'." -ForegroundColor Green
    } else {
        Write-Host "Le group '$GroupName' n'existe pas." -ForegroundColor Red 
    }
} catch {
    Write-Error "Une erreur est survenue lors de la modification de l'attribut : $_ : $($_.Exception.Message) " -ForegroundColor Red
}