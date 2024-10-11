Import-Module ActiveDirectory

param(
    [Parameter(Mandatory=$true)]
    [string]$userName
)

function SecureStringToString {
    param ([Security.SecureString]$secureString)

    # Convertit la Secure String en Binary String
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
    try {
        # Convertit la Binary String en String
        return [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
    }
    finally {
        # ZeroFreeBSTR libére la mémoire alloué par $bstr
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
    }
}

try {
    # Demander l'ancien mot de passe
    $oldPassword = Read-Host -Prompt "Entrez l'ancien mot de passe pour $userName" -AsSecureString
    # Demander le nouveau mot de passe
    $newPassword = Read-Host -Prompt "Entrez le nouveau mot de passe pour $userName" -AsSecureString
    $confirmPassword = Read-Host -Prompt "Confirmez le nouveau mot de passe pour $userName" -AsSecureString

    # Vérifier que les deux mots de passe entrés sont identiques
    $pass1 = SecureStringToString -secureString $newPassword
    $pass2 = SecureStringToString -secureString $confirmPassword
    if ($pass1 -eq $pass2) {
        # Changer le mot de passe
        Set-ADAccountPassword -Identity $userName -OldPassword $oldPassword -NewPassword $newPassword
        Write-Host "Le mot de passe a été changé avec succès pour l'utilisateur $userName." -ForegroundColor Green
    } else {
        Write-Host "Les mots de passe ne correspondent pas. Veuillez réessayer." -ForegroundColor Red
    }
} catch {
    Write-Host "Erreur lors de la modification du mot de passe : $($_.Exception.Message)"
}
