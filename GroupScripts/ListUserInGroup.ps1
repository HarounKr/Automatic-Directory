Import-Module ActiveDirectory

param ( 
    [Parameter(Mandatory=$true)]
    [string]$GroupName
)

try {
    $groupMembers = Get-ADGroupMember "Users-Security" -recursive | Get-ADUser -property Displayname
    $groupMembers
    Write-Host "Les membres du groupe '$groupMembers' ont été récupéré avec succès" -ForegroundColor Green
} catch {
    Write-Error "Une erreur est survenue : $($_.Exception.Message)" -ForegroundColor Red
}