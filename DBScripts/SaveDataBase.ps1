param (
    [Parameter(Mandatory=$true)]
    [string]$Path,  # Chemin du fichier d'exportation
    [Parameter(Mandatory=$true)]
    [string]$Delimiter,  # Délimiteur pour le fichier CSV
    [Parameter(Mandatory=$true)]
    [string[]]$AdditionalParameters  # Liste des propriétés supplémentaires à inclure
)

Import-Module ActiveDirectory

function Export-ADInfo {
    param (
        [string]$ExportPath,
        [string]$CsvDelimiter,
        [string[]]$Properties
    )

    # Récupérer les informations des utilisateurs
    $userProperties = @('Name', 'SamAccountName', 'EmailAddress') + $Properties
    $users = Get-ADUser -Filter * -Property $userProperties |
             Select-Object -Property $userProperties

    # Récupérer les informations des groupes
    $groupProperties = @('Name', 'GroupScope', 'GroupCategory') + $Properties
    $groups = Get-ADGroup -Filter * -Property $groupProperties |
              Select-Object -Property $groupProperties

    # Concaténer les deux informations dans un même tableau
    $data = $users + $groups

    # Exporter les données dans un fichier CSV
    $data | Export-Csv -Path $ExportPath -Delimiter $CsvDelimiter -Encoding UTF8
    Write-Host "Les informations ont été exportées avec succès vers $ExportPath" -ForegroundColor Green
}

# Appeler la fonction avec les paramètres fournis
Export-ADInfo -ExportPath $Path -CsvDelimiter $Delimiter -Properties $AdditionalParameters



# .\SaveDataBase.ps1 -Path "C:\Users\Administrateur\Desktop\data.csv" -Delimiter ";" -AdditionalParameters 'DistinguishedName', 'Description', 'ObjectClass', 'ObjectGUID', 'WhenCreated', 'WhenChanged'