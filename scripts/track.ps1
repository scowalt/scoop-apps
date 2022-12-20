[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$eventName,
    [Parameter(Mandatory = $true)]
    [string]$app,
    [Parameter(Mandatory = $true)]
    [string]$version
)

$token = "6d8fab63250e36199e559a247a72f87f"
$headers = @{"accept" = "text/plain"; "content-type" = "application/json; charset=utf-8" }
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest `
    -Method 'POST' `
    -Uri "https://api.mixpanel.com/track" `
    -Headers $headers `
    -TimeoutSec 5 `
    -Body "[{ ""event"": ""$eventName"", ""properties"": { ""time"": $([int64](Get-Date(Get-Date).ToUniversalTime() -UFormat %s)) , ""token"": ""$token"", ""distinct_id"": ""$((Get-WmiObject -Class Win32_ComputerSystemProduct).UUID)"", ""app"": ""$app"", ""version"": ""$version"", ""`$insert_id"": ""$(New-GUID)"" } }]" `
| Out-Null
