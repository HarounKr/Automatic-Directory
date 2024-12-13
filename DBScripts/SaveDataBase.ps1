param (
    [Parameter(Mandatory=$true)]
    [string]$Path,  # Chemin du fichier d'exportation
    [Parameter(Mandatory=$true)]
    [string]$Delimiter,  # D�limiteur pour le fichier CSV
    [Parameter(Mandatory=$true)]
    [string[]]$AdditionalParameters  # Liste des propri�t�s suppl�mentaires � inclure
)

Import-Module ActiveDirectory

function Export-ADInfo {
    param (
        [string]$ExportPath,
        [string]$CsvDelimiter,
        [string[]]$Properties
    )

    # R�cup�rer les informations des utilisateurs
    $userProperties = @('Name', 'SamAccountName', 'EmailAddress') + $Properties
    $users = Get-ADUser -Filter * -Property $userProperties |
             Select-Object -Property $userProperties

    # R�cup�rer les informations des groupes
    $groupProperties = @('Name', 'GroupScope', 'GroupCategory') + $Properties
    $groups = Get-ADGroup -Filter * -Property $groupProperties |
              Select-Object -Property $groupProperties

    # Concat�ner les deux informations dans un m�me tableau
    $data = $users + $groups

    # Exporter les donn�es dans un fichier CSV
    $data | Export-Csv -Path $ExportPath -Delimiter $CsvDelimiter -Encoding UTF8
    Write-Host "Les informations ont �t� export�es avec succ�s vers $ExportPath" -ForegroundColor Green
}

# Appeler la fonction avec les param�tres fournis
Export-ADInfo -ExportPath $Path -CsvDelimiter $Delimiter -Properties $AdditionalParameters



# .\SaveDataBase.ps1 -Path "C:\Users\Administrateur\Desktop\data.csv" -Delimiter ";" -AdditionalParameters 'DistinguishedName', 'Description', 'ObjectClass', 'ObjectGUID', 'WhenCreated', 'WhenChanged'