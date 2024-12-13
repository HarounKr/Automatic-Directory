param(
    [Parameter(Mandatory=$true)]
    [string]$name,
    [Parameter(Mandatory=$true)]
    [string]$ou,
    [Parameter(Mandatory=$true)]
    [string]$groupName
)

Import-Module ActiveDirectory

# G�n�rer l'adresse e-mail et le UserPrincipalName
$email = "$name@domolia.com".ToLower()
# R�cup�rer le mot de passe du compte 
$password = (Read-Host -AsSecureString 'Entrez un mot de passe s�curis�')

# Configuration des param�tres de l'utilisateur avec splatting en cr�aant une table de hachage
$hashtable = @{
    Name = $name                # nom complet de l'utilisateur
    UserPrincipalName = $email         # nom principal de l'utilisateur (UPN), qui est g�n�ralement l'adresse e-mail
    SamAccountName = $name      # nom de compte SAM
    EmailAddress = $email              # Adresse e-mail de l'utilisateur
    Path = $ou                # L'unit�e d'organisation dans laquelle l'utilisateur sera plac�
    AccountPassword = $password
    PasswordNeverExpires = $false      # Indique si le mot de passe doit expirer
    ChangePasswordAtLogon = $true      # Oblige l'utilisateur à changer de mot de passe à la premi�re connexion
    Enabled = $true                    # Active le compte direct apr�s sa cr�ation
}

try {
    # Cr�er l'utilisateur dans l'AD
    New-ADUser @hashtable
    Write-Host "Utilisateur cr�� avec succ�s." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de la cr�ation de l'utilisateur : $($_.Exception.Message)" -ForegroundColor Red
    Exit 1
}

try {
    # Ajout de l'utilisateur au bon groupe
    Add-ADGroupMember -Identity $groupName -Members $name
    Write-Host "Utilisateur ajout� au groupe avec succ�s." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de l'ajout de l'utilisateur au groupe : $($_.Exception.Message)" -ForegroundColor Red
}

<#
 Get-ADOrganizationalUnit -Filter *
 Get-ADGroup -Filter * | Where-Object {$_.Name -eq "Test"}
 OU=TestUnit,DC=domolia,DC=local

 .\UserCreation.ps1 -name hkrifa -ou "OU=TestUnit,DC=domolia,DC=local" -groupeName "Test"
#>