param (
    [Parameter(Mandatory=$true)]
    [string]$Path
    [Parameter(Mandatory=$true)]
    [string]$Delimiter 
)

function Load-CSVData {
    # Vérifier si le fichier existe
    if (-Not (Test-Path $Path)) {
        Write-Host "Le fichier spécifié n'existe pas : $Path" -ForegroundColor Red
        return
    }

    try {
        # Charger les données du fichier CSV
        $csvData = Import-Csv -Path $Path -Delimiter $Delimiter
        Write-Host "Données chargées avec succès depuis : $Path" -ForegroundColor Green
        
        # Afficher les données chargées (pour vérification)
        $csvData | Format-Table -AutoSize
        return $csvData
    }
    catch {
        Write-Host "Erreur lors du chargement des données : $_" -ForegroundColor Red
    }
}

$loadedData = Load-CSVData

# .\LoadDataBase.ps1 -Path "C:\path\to\csv" -Delimiter ";"