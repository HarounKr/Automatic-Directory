param (
    [Parameter(Mandatory=$true)]
    [string]$Path,
    [Parameter(Mandatory=$true)]
    [string]$Delimiter,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$AdditionalParameters
)
Import-Module ActiveDirectory

function Export-ADInfo {
    # Récupérer les informations des utilisateurs
    $users = Get-ADUser -Filter * -Property * | Select-Object -Property $AdditionalParameters

    # Récupérer les informations des groupes
    $groups = Get-ADGroup -Filter * -Property * | Select-Object -Property $AdditionalParameters

    # Combiner les informations dans un tableau
    $data = @($users, $groups)

    # Exporter les données vers un fichier CSV
    $data | Export-Csv -Path $Path -Delimiter $Delimiter -NoTypeInformation
    Write-Host "Les données ont été enregistrées dans le fichier '$Path'" -ForegroundColor Green
}

Export-ADInfo


#test : .\SaveDataBase.ps1 -Path "C:\path\to\csv" -Delimiter ";" -AdditionalParameters "Name", "SamAccountName", "EmailAddress"