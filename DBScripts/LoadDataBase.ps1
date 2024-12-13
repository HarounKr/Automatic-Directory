param (
    [Parameter(Mandatory=$true)]
    [string]$Path, # Chemin du fichier
    [Parameter(Mandatory=$true)]
    [string]$Delimiter #Deliliteur
)

function Load-CSVData {
    # V�rifier si le fichier existe
    if (-Not (Test-Path $Path)) {
        Write-Host "Le fichier sp�cifi� n'existe pas : $Path" -ForegroundColor Red
        Exit 1
    }

    try {
        # Charger les donn�es du fichier CSV
        $csvData = Import-Csv -Path $Path -Delimiter $Delimiter
        Write-Host "Donn�es charg�es avec succ�es depuis : $Path" -ForegroundColor Green
        
        # Afficher les donn�ees charg�ees (pour v�rification)
        $csvData | Format-Table -AutoSize
        return $csvData
    }
    catch {
        Write-Host "Erreur lors du chargement des donn�ees : $_" -ForegroundColor Red
    }
}

$loadedData = Load-CSVData

$loadedData

# .\LoadDataBase.ps1 -Path "C:\Users\Administrateur\Desktop\data.csv" -Delimiter ";"