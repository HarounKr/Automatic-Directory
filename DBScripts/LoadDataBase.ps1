param (
    [Parameter(Mandatory=$true)]
    [string]$Path, # Chemin du fichier
    [Parameter(Mandatory=$true)]
    [string]$Delimiter #Deliliteur
)

function Load-CSVData {
    # Vérifier si le fichier existe
    if (-Not (Test-Path $Path)) {
        Write-Host "Le fichier spécifié n'existe pas : $Path" -ForegroundColor Red
        Exit 1
    }

    try {
        # Charger les données du fichier CSV
        $csvData = Import-Csv -Path $Path -Delimiter $Delimiter
        Write-Host "Données chargées avec succées depuis : $Path" -ForegroundColor Green
        
        # Afficher les donnéees chargéees (pour vérification)
        $csvData | Format-Table -AutoSize
        return $csvData
    }
    catch {
        Write-Host "Erreur lors du chargement des donnéees : $_" -ForegroundColor Red
    }
}

$loadedData = Load-CSVData

$loadedData

# .\LoadDataBase.ps1 -Path "C:\Users\Administrateur\Desktop\data.csv" -Delimiter ";"