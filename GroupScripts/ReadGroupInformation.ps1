Import-Module ActiveDirectory
param(
    [Parameter(Mandatory=$true)]
    [string]$GroupName,
    [string]$PropertyName
)


function Get-GroupInformation {
    param(
        [string]$groupName,
        [string]$propertyName
    )

    try {
        if (-not $propertyName) {
            $group = Get-ADGroup -Identity $groupName -Properties *
            Write-Output $group
        } else {
            $group = Get-ADGroup -Identity $groupName -Properties $propertyName
            Write-Output ($group | Select-Object -Property $propertyName)
        }
    } catch {
        Write-Error "Une erreur est survenue: $_"
    }
}

Get-GroupInformation -groupName $GroupName -propertyName $PropertyName