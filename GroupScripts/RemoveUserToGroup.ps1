Import-Module ActiveDirectory

param (
    [Parameter(Mandatory=$true)]
    [string]$UserName,
    [Parameter(Mandatory=$true)]
    [string]$GroupName
)

try {
    $group = Get-ADGroup -Identity $GroupName
    if ($group) {
        $user = Get-ADUser -Identity $UserName
        if ($user) {
            Remove-AdGroupMember -Identity $GroupName -Members $UserName
            $userDeleted = Get-ADGroupMember -Identity Users-Security | Select SamAccountName
            if (-not $userDeleted) {
                Write-Host "L'utilisateur '$UserName' a été supprimé du groupe '$GroupName' avec succès" -ForegroundColor Green
            } else {
                Write-Host "L'utilisateur '$UserName' n'a pas pu etre supprimé du groupe '$GroupName'" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "Le groupe '$GroupName' n'existe pas" -ForegroundColor Red
    }
} catch {
    Write-Error "Une erreur est survenue : $($_.Exception.Message)" -ForegroundColor Red
}