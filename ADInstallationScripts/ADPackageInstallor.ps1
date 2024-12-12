Import-Module ServerManager

# Configuration réseau
$InterfaceAlias = "Ethernet"  
$IPAddress = "10.0.2.16"  
$SubnetMask = "255.255.255.0"
$DefaultGateway = "10.0.2.2"
$DNSServer = "127.0.0.1"

Write-Host "Configuration réseau en cours..." -ForegroundColor Yellow

# Configurer une adresse IP statique
New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $DefaultGateway

# Configurer les serveurs DNS
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DNSServer

Write-Host "Configuration réseau terminée." -ForegroundColor Green

# Installer les fonctionnalités nécessaires pour Active Directory
Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeManagementTools

# Vérifier si les rôles sont installés correctement
if ((Get-WindowsFeature -Name AD-Domain-Services).InstallState -eq "Installed" -and 
    (Get-WindowsFeature -Name DNS).InstallState -eq "Installed") {
    Write-Host "L'installation des rôles Active Directory et DNS a réussi." -ForegroundColor Green
} else {
    Write-Host "L'installation des rôles Active Directory et/ou DNS a échoué." -ForegroundColor Red
    Exit
}

Write-Host "L'installation des rôles Active Directory et DNS est terminée." -ForegroundColor Green