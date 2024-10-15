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
            Add-AdGroupMember -Identity $GroupName -Members $UserName
            $userAdded = Get-ADGroupMember -Identity Users-Security | Select SamAccountName
            if ($userAdded) {
                Write-Host "L'utilisateur '$UserName' a été ajouté au groupe '$GroupName' avec succès" -ForegroundColor Green
            } else {
                Write-Host "L'utilisateur '$UserName' n'a pas pu etre ajouter au groupe '$GroupName'" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "Le groupe '$GroupName' n'existe pas" -ForegroundColor Red
    }
} catch {
    Write-Error "Une erreur est survenue : $($_.Exception.Message)" -ForegroundColor Red
}