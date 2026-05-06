if ($env:ANTHROPIC_API_KEY) {
  $env:ANTHROPIC_AUTH_TOKEN = $env:ANTHROPIC_API_KEY
}

$env:ANTHROPIC_BASE_URL = 'https://api.minimaxi.com/anthropic'
$env:ANTHROPIC_MODEL = 'MiniMax-M2.7-highspeed'
$env:ANTHROPIC_SMALL_FAST_MODEL = 'MiniMax-M2.7-highspeed'
$env:ANTHROPIC_DEFAULT_SONNET_MODEL = 'MiniMax-M2.7-highspeed'
$env:ANTHROPIC_DEFAULT_OPUS_MODEL = 'MiniMax-M2.7-highspeed'
$env:ANTHROPIC_DEFAULT_HAIKU_MODEL = 'MiniMax-M2.7-highspeed'
$env:API_TIMEOUT_MS = '3000000'
$env:CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = '1'

$freeCodeExe = Join-Path $PSScriptRoot 'cli.exe'

if (-not (Test-Path $freeCodeExe)) {
  Write-Error "cypherfree: cli.exe not found at '$freeCodeExe'"
  exit 1
}

& $freeCodeExe @args
exit $LASTEXITCODE
