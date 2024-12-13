param(
    [Parameter(Mandatory=$true)]
    [string]$name,
    [Parameter(Mandatory=$true)]
    [string]$ou,
    [Parameter(Mandatory=$true)]
    [string]$groupName
)

Import-Module ActiveDirectory

# Générer l'adresse e-mail et le UserPrincipalName
$email = "$name@domolia.com".ToLower()
# Récupérer le mot de passe du compte 
$password = (Read-Host -AsSecureString 'Entrez un mot de passe sécurisé')

# Configuration des paramètres de l'utilisateur avec splatting en créaant une table de hachage
$hashtable = @{
    Name = $name                # nom complet de l'utilisateur
    UserPrincipalName = $email         # nom principal de l'utilisateur (UPN), qui est généralement l'adresse e-mail
    SamAccountName = $name      # nom de compte SAM
    EmailAddress = $email              # Adresse e-mail de l'utilisateur
    Path = $ou                # L'unitée d'organisation dans laquelle l'utilisateur sera placé
    AccountPassword = $password
    PasswordNeverExpires = $false      # Indique si le mot de passe doit expirer
    ChangePasswordAtLogon = $true      # Oblige l'utilisateur Ã  changer de mot de passe Ã  la première connexion
    Enabled = $true                    # Active le compte direct après sa création
}

try {
    # Créer l'utilisateur dans l'AD
    New-ADUser @hashtable
    Write-Host "Utilisateur créé avec succés." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de la création de l'utilisateur : $($_.Exception.Message)" -ForegroundColor Red
    Exit 1
}

try {
    # Ajout de l'utilisateur au bon groupe
    Add-ADGroupMember -Identity $groupName -Members $name
    Write-Host "Utilisateur ajouté au groupe avec succés." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de l'ajout de l'utilisateur au groupe : $($_.Exception.Message)" -ForegroundColor Red
}

<#
 Get-ADOrganizationalUnit -Filter *
 Get-ADGroup -Filter * | Where-Object {$_.Name -eq "Test"}
 OU=TestUnit,DC=domolia,DC=local

 .\UserCreation.ps1 -name hkrifa -ou "OU=TestUnit,DC=domolia,DC=local" -groupeName "Test"
#>