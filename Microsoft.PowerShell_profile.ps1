function Write-BranchName () {
  try {
    $branch = git rev-parse --abbrev-ref HEAD

      if ($branch -eq "HEAD") {
        $branch = git rev-parse --short HEAD
          Write-Host " ($branch)" -ForegroundColor "red"
      }
      else {
        Write-Host " ($branch)" -ForegroundColor "cyan"
      }
  } catch {
    Write-Host " (no branches yet)" -ForegroundColor "yellow"
  }
}

function prompt {
  $path = "`n$(Get-Location)".replace($HOME, "~")

  if (Test-Path .git) {
    Write-Host $path -NoNewline -ForegroundColor "green"
    Write-BranchName
  } else {
    Write-Host $path -ForegroundColor "green"
  }

  return "> "
}

Set-PSReadLineOption -BellStyle None

function wsl_home { wsl.exe --cd ~ }
New-Alias -Name wslh -Value wsl_home -Description "Run wsl in home directory"
