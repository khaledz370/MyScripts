# Get the current PATH environment variable
$path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

# Split the PATH into individual entries
$pathEntries = $path -split ";"

# Filter out non-existing directories
$validPaths = $pathEntries | Where-Object { Test-Path $_ }

# Update the PATH with only valid paths
[System.Environment]::SetEnvironmentVariable("Path", ($validPaths -join ";"), [System.EnvironmentVariableTarget]::User)

Write-Host "PATH variable cleaned up."
