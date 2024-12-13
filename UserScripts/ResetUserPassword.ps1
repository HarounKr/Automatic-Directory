param(
    [Parameter(Mandatory=$true)]
    [string]$accountName
)

Import-Module ActiveDirectory

try {
  
    # Demander le nouveau mot de passe
    $newPassword = Read-Host -AsSecureString "Entrez le nouveau mot de passe pour $accountName"
    $confirmPassword = Read-Host -AsSecureString "Confirmez le nouveau mot de passe pour $accountName"

    # Passer les mot de passe en texte brute
    $newPasswordPlainText = [System.Net.NetworkCredential]::new("", $newPassword).Password
    $confirmPasswordPlainText = [System.Net.NetworkCredential]::new("", $confirmPassword).Password
    
    # Vérifier que les deux mots de passe entrées sont identiques
    if ($newPasswordPlainText -eq $confirmPasswordPlainText) {
    
        # Changer le mot de passe
        Set-ADAccountPassword -Identity $accountName -NewPassword $newPassword
        Write-Host "Le mot de passe a été changé avec succés pour l'utilisateur $accountName." -ForegroundColor Green
    } else {
        Write-Host "Les mots de passe ne correspondent pas. Veuillez réessayer." -ForegroundColor Red
    }
} catch {
    Write-Host "Erreur lors de la modification du mot de passe : $($_.Exception.Message)"
}


#  .\ResetUserPassword.ps1 -accountName "hkrifa"