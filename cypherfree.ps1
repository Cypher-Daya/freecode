$env:ANTHROPIC_BASE_URL = if ($env:ANTHROPIC_BASE_URL) {
  $env:ANTHROPIC_BASE_URL
} else {
  'https://api.minimaxi.com/anthropic'
}

if (-not $env:ANTHROPIC_AUTH_TOKEN -and $env:ANTHROPIC_API_KEY) {
  $env:ANTHROPIC_AUTH_TOKEN = $env:ANTHROPIC_API_KEY
}

$freeCodeExe = Join-Path $PSScriptRoot 'cli.exe'

if (-not (Test-Path $freeCodeExe)) {
  Write-Error "cypherfree: cli.exe not found at '$freeCodeExe'"
  exit 1
}

& $freeCodeExe @args
exit $LASTEXITCODE
