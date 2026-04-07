@echo off
setlocal

set "FREE_CODE_EXE=%~dp0cli.exe"

if not defined ANTHROPIC_BASE_URL set "ANTHROPIC_BASE_URL=https://api.minimaxi.com/anthropic"
if not defined ANTHROPIC_AUTH_TOKEN if defined ANTHROPIC_API_KEY set "ANTHROPIC_AUTH_TOKEN=%ANTHROPIC_API_KEY%"

if not exist "%FREE_CODE_EXE%" (
  echo cypherfree: cli.exe not found at "%FREE_CODE_EXE%"
  exit /b 1
)

"%FREE_CODE_EXE%" %*
exit /b %ERRORLEVEL%
