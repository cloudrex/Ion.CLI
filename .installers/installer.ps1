# Utility functions.
function Resolve {
    param([string] $path)

    # Return the resolved path.
    return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}

function PathAppend {
    param([string] $path)

    # Ensure path is resolved.
    $path = Resolve-Path $path

    # Set the environment variable.
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$path", [System.EnvironmentVariableTarget]::User)
}

# Constant declaration.
$ToolsUrl = "https://github.com/IonLanguage/Ion.CLI/releases/download/llvm-tools/tools.zip"
$ToolsZipFile = "llvm-tools.zip"
$FinishedMessage = "Operation completed."
$InstallationPath = "$env:LOCALAPPDATA\Programs\IonLanguage"

# Enter installation directory.
Set-Location -Path $InstallationPath

# Create other constants.
$MainExeFullPath = "$InstallationPath\IonCLI.exe"
$FinalExeFullPath = "$InstallationPath\ion.exe"

# Inform the user of the process.
"We're getting everything ready for you! Please do not close this window."

# Rename IonCLI executable if applicable.
if ([System.IO.File]::Exists($MainExeFullPath)) {
    Move-Item -Force -Path $MainExeFullPath -Destination $FinalExeFullPath
}

# Add IonCLI's executable to path.
"Adding IonCLI to path ..."
PathAppend $InstallationPath

# Cleanup.
"Cleaning up ..."

# Remove LLVM tools package file.
Remove-Item $ToolsZipFile -ErrorAction Ignore

# Inform the user the process completed.
$FinishedMessage
