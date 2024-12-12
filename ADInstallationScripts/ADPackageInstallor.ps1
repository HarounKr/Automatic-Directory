Import-Module ServerManager

# Configuration r�seau
$InterfaceAlias = "Ethernet"  
$IPAddress = "10.0.2.16"  
$SubnetMask = "255.255.255.0"
$DefaultGateway = "10.0.2.2"
$DNSServer = "127.0.0.1"

Write-Host "Configuration r�seau en cours..." -ForegroundColor Yellow

# Configurer une adresse IP statique
New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $DefaultGateway

# Configurer les serveurs DNS
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DNSServer

Write-Host "Configuration r�seau termin�e." -ForegroundColor Green

# Installer les fonctionnalit�s n�cessaires pour Active Directory
Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeManagementTools

# V�rifier si les r�les sont install�s correctement
if ((Get-WindowsFeature -Name AD-Domain-Services).InstallState -eq "Installed" -and 
    (Get-WindowsFeature -Name DNS).InstallState -eq "Installed") {
    Write-Host "L'installation des r�les Active Directory et DNS a r�ussi." -ForegroundColor Green
} else {
    Write-Host "L'installation des r�les Active Directory et/ou DNS a �chou�." -ForegroundColor Red
    Exit
}

Write-Host "L'installation des r�les Active Directory et DNS est termin�e." -ForegroundColor Green