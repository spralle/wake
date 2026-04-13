# sync-principles — Sync shared code principles from dotfiles into the current project
#
# Usage:
#   sync-principles              # interactive — shows diff, asks before overwriting
#   sync-principles --force      # overwrite without asking
#   sync-principles --dry-run    # show what would change without writing
#   sync-principles --help       # show usage

$Force = $false
$DryRun = $false

function Show-Usage {
    Write-Host "Usage: sync-principles [--force | --dry-run | --help]"
    Write-Host ""
    Write-Host "Syncs shared code principles from ~/.config/opencode/principles/"
    Write-Host "into the current project's docs\principles\ directory."
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  --force     Overwrite changed files without asking"
    Write-Host "  --dry-run   Show what would change without writing anything"
    Write-Host "  --help      Show this help"
    Write-Host ""
    Write-Host "Project-specific files (ones not in the global source) are never touched."
}

# Parse args
foreach ($arg in $args) {
    switch ($arg) {
        "--force"   { $Force = $true }
        "--dry-run" { $DryRun = $true }
        "--help"    { Show-Usage; exit 0 }
        default     { Write-Host "Unknown option: $arg"; Show-Usage; exit 1 }
    }
}

$SourceDir = Join-Path $env:USERPROFILE ".config\opencode\principles"
$TargetDir = "docs\principles"

# Validate
if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory not found: $SourceDir"
    Write-Host "Run 'chezmoi apply' first to set up your dotfiles."
    exit 1
}

if (-not (Test-Path "opencode.json") -and -not (Test-Path "package.json")) {
    Write-Error "Not in a project root (no opencode.json or package.json found)."
    exit 1
}

# Ensure target directory exists
if (-not $DryRun) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

# Track results
$synced = 0
$skipped = 0
$unchanged = 0

Get-ChildItem -Path $SourceDir -Filter "*.md" | ForEach-Object {
    $sourceFile = $_.FullName
    $filename = $_.Name
    $targetFile = Join-Path $TargetDir $filename

    # New file
    if (-not (Test-Path $targetFile)) {
        if ($DryRun) {
            Write-Host "[new]       $filename"
        } else {
            Copy-Item $sourceFile $targetFile
            Write-Host "[added]     $filename"
        }
        $script:synced++
        return
    }

    # Compare content
    $sourceContent = Get-Content $sourceFile -Raw
    $targetContent = Get-Content $targetFile -Raw

    if ($sourceContent -eq $targetContent) {
        $script:unchanged++
        return
    }

    # File differs
    if ($DryRun) {
        Write-Host "[changed]   $filename"
        $script:synced++
        return
    }

    if ($Force) {
        Copy-Item $sourceFile $targetFile
        Write-Host "[updated]   $filename"
        $script:synced++
        return
    }

    # Interactive
    Write-Host ""
    Write-Host "--- $filename has changes ---"
    Write-Host ""
    $answer = Read-Host "Overwrite $filename? [y/N]"
    if ($answer -eq "y" -or $answer -eq "Y") {
        Copy-Item $sourceFile $targetFile
        Write-Host "[updated]   $filename"
        $script:synced++
    } else {
        Write-Host "[skipped]   $filename"
        $script:skipped++
    }
}

Write-Host ""
Write-Host "Done. $synced synced, $unchanged unchanged, $skipped skipped."

if ($synced -gt 0 -and -not $DryRun) {
    Write-Host ""
    Write-Host "Remember to update opencode.json instructions if you added new principle files."
}
