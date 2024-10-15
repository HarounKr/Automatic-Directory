Import-Module ActiveDirectory

param (
    [Parameter(Mandatory=$true)]
    [string]$GroupName,
    [Parameter(Mandatory=$true)]
    [string]$OrganisationUnit,
    [Parameter(Mandatory=$true)]
    [string]$GroupScope, # Globale, Universelle ou Locale
    [Parameter(Mandatory=$true)]
    [string]$Description
)

try {
    # Vérification de l'existence du groupe que l'on souhaite créé
    $group = Get-ADGroup -Identity $GroupName
    if (-not $group) {
        # Ajout du groupe avec les bons attributs donnés en param et en mode distribution
        New-ADGroup -Name $GroupName -Path $OrganisationUnit  -GroupCategory Distribution -GroupScope $GroupScope -Description $Description
        # Vérification du bon ajout du groupe
        $new_group = Get-ADGroup -Filter "Name -like '$GroupName'" | Select-Object -ExpandProperty Name
        if ($new_group) {
            Write-Host "Le groupe '$GroupName' été créé avec succès" -ForegroundColor Green
        } else {
            Write-Host "Le groupe '$GroupName' n'a pas été créé" -ForegroundColor Red
        }
    } else {
        Write-Host "Le groupe '$GroupName' existe : '$GroupName'" -ForegroundColor Red
    }
} catch {
    Write-Error "Une erreur est survenue lors de la création du groupe '$GroupName' : $($_.Exception.Message)" -ForegroundColor Red
}