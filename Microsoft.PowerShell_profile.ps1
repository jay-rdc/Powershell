# FUNCTIONS
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

# ENVIRONMENT VARIABLES
$env:nvimdir = "$env:LOCALAPPDATA\nvim"
$NVIM_DIR = "$env:nvimdir"

$env:histfile = "$((Get-PSReadlineOption).HistorySavePath)"
$HISTFILE = "$env:histfile"

# KEYBOARD SHORTCUTS
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord "Tab" -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+j" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key "Ctrl+u" -Function RevertLine
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function PreviousHistory
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function NextHistory

Remove-PSReadLineKeyHandler -Key "Ctrl+v"

# ALIASES
Remove-Alias -Name nv -Force
New-Alias -Name nv -Value nvim
