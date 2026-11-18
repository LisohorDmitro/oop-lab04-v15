param([string]$CompilerDirectory = "")
$ErrorActionPreference = "Stop"
if ($CompilerDirectory) {
    $bin = (Resolve-Path -LiteralPath $CompilerDirectory).Path
    $env:PATH = $bin + [IO.Path]::PathSeparator + $env:PATH
}
$g++ = (Get-Command g++ -CommandType Application -ErrorAction Stop | Select-Object -First 1).Source
Push-Location -LiteralPath $PSScriptRoot
try {
    & $g++ '-std=c++14' '-O2' '-Wall' '-Wextra' '-pedantic' '-static-libgcc' '-static-libstdc++' 'fraction.cpp' 'main.cpp' '-o' 'lab04.exe'
    if ($LASTEXITCODE -ne 0) { throw 'g++ failed' }
} finally {
    Pop-Location
}
