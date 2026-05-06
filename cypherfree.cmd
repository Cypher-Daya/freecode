@echo off
setlocal

set "FREE_CODE_EXE=%~dp0cli.exe"

if defined ANTHROPIC_API_KEY set "ANTHROPIC_AUTH_TOKEN=%ANTHROPIC_API_KEY%"

set "ANTHROPIC_BASE_URL=https://api.minimaxi.com/anthropic"
set "ANTHROPIC_MODEL=MiniMax-M2.7-highspeed"
set "ANTHROPIC_SMALL_FAST_MODEL=MiniMax-M2.7-highspeed"
set "ANTHROPIC_DEFAULT_SONNET_MODEL=MiniMax-M2.7-highspeed"
set "ANTHROPIC_DEFAULT_OPUS_MODEL=MiniMax-M2.7-highspeed"
set "ANTHROPIC_DEFAULT_HAIKU_MODEL=MiniMax-M2.7-highspeed"
set "API_TIMEOUT_MS=3000000"
set "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1"

if not exist "%FREE_CODE_EXE%" (
  echo cypherfree: cli.exe not found at "%FREE_CODE_EXE%"
  exit /b 1
)

"%FREE_CODE_EXE%" %*
exit /b %ERRORLEVEL%
