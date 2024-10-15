Import-Module ActiveDirectory

param(
    [Parameter(Mandatory=$true)]
    [string]$SourceGroupName,
    [Parameter(Mandatory=$true)]
    [string]$DestinationGroupName
)

function Import-GroupMembers {
    param(
        [string]$srcGroupName,
        [string]$destGroupName
    )

    # Obtention des membres du groupe d'origine
    $sourceGroupMembers = Get-ADGroupMember -Identity $srcGroupName -Recursive

    # Boucle pour ajouter chaque membre au groupe de destination
    foreach ($member in $sourceGroupMembers) {
        try {
            # Ajouter des membres au groupe de destination
            Add-ADGroupMember -Identity $destGroupName -Members $member
            Write-Host "Membre ajouté : $($member.SamAccountName) au groupe $destGroupName"
        } catch {
            Write-Host "Erreur lors de l'ajout du membre : $($member.SamAccountName). Erreur : $_"
        }
    }
}