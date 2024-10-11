Import-Module ActiveDirectory

param(
    [Parameter(Mandatory=$true)]
    [string]$accountName,
    [Parameter(Mandatory=$true)]
    [string]$orgUnit,
    [Parameter(Mandatory=$true)]
    [string]$groupName
)


# Générer l'adresse e-mail et le UserPrincipalName
$email = "$($accountName.Split(' ')[0]).$($accountName.Split(' ')[1])@domolia.com".ToLower()
# Récupérer le mot de passe du compte 
$password = (Read-Host -Prompt -AsSecureString 'Entrez un mot de passe sécurisé') 
# Configuration des paramètres de l'utilisateur avec splatting en créant une table de hachage
$splat = @{
    Name = $accountName                # nom complet de l'utilisateur
    UserPrincipalName = $email         # nom principal de l'utilisateur (UPN), qui est généralement l'adresse e-mail
    SamAccountName = $accountName      # nom de compte SAM
    EmailAddress = $email              # Adresse e-mail de l'utilisateur
    Path = $orgUnit                    # L'unité d'organisation dans laquelle l'utilisateur sera placé
    AccountPassword = $password
    PasswordNeverExpires = $false      # Indique si le mot de passe doit expirer
    ChangePasswordAtLogon = $true      # Oblige l'utilisateur à changer de mot de passe à la première connexion
    Enabled = $true                    # Active le compte direct après sa création
}

try {
    # Créer l'utilisateur dans l'AD
    New-ADUser @splat
    Write-Host "Utilisateur créé avec succès." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de la création de l'utilisateur : $($_.Exception.Message)" -ForegroundColor Red
    Exit 1
}

try {
    # Ajout de l'utilisateur au bon groupe
    Add-ADGroupMember -Identity $groupName -Members $accountName
    Write-Host "Utilisateur ajouté au groupe avec succès." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de l'ajout de l'utilisateur au groupe : $($_.Exception.Message)" -ForegroundColor Red
}