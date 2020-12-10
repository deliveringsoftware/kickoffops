Param
(    
    [Parameter(Mandatory=$true)]     
    [SecureString]$PAT,
    [Parameter(Mandatory=$true)]      
    [string]$orgName,	
    [Parameter(Mandatory=$true)]      
    [string]$tpName,
    [Parameter(Mandatory=$true)]      
    [string]$tpVisibility
)

function Get-OrganizationURL{
    param (
        [string]$Organization
    )
    return "https://dev.azure.com/$Organization"
}

function Get-PersonalAccessToken{
    param(
        [SecureString]$secureString
    )
    $secstring = ConvertTo-SecureString -string (ConvertFrom-SecureString $secureString)
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secstring)
    return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
}

$OrganizationUrl = Get-OrganizationURL -Organization $orgName

Write-Progress -Activity "=== Login to organization $orgName ==="
Write-Output (Get-PersonalAccessToken $PAT) | az devops login --org $OrganizationUrl

$tpProcess = "Agile"

az devops project create --name $tpName -d $tpDescription --org $org -p $tpProcess --visibility $tpVisibility