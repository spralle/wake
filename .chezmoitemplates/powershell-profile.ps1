# wake managed dotfile — do not edit directly, use `chezmoi edit`

# Editor
$env:EDITOR = "nvim"

# Starship prompt
Invoke-Expression (&starship init powershell)

# PSReadLine configuration
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Aliases
Set-Alias -Name ll -Value Get-ChildItem
function gs { git status }
function gd { git diff }
function gl { git log --oneline -20 }
function gp { git pull --rebase }

# Chezmoi aliases
function cm { & chezmoi $args }
function cma { chezmoi apply }
function cmd { chezmoi diff }
function cmu { chezmoi update }

# mise (runtime manager)
if (Get-Command mise -ErrorAction SilentlyContinue) {
    & mise activate pwsh | Invoke-Expression
}

# fzf integration
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    $env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border"
}
