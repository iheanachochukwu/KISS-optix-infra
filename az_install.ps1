# Download and Install Azure CLI
Invoke-WebRequest -Uri https://azcliprod.blob.core.windows.net/msi/azure-cli-2.19.1.msi -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList "/I AzureCLI.msi /quiet"; rm .\AzureCLI.msi

# Update PATH for Powershell to use new installed software
setx /M PATH "$env:Path += ;C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin"

# Test if PATH of Azure CLI exists
Test-Path -Path "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin"

# Reload Shell with new PATH 
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Check if AZ CLI is installed
az version