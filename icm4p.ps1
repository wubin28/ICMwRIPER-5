#!/usr/bin/env pwsh

# ICMwRIPER-5 PowerShell Script for Windows 11
# Converted from icmwriper-5-for-ubuntu for PowerShell 7.5.3 compatibility

param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$SubCommand,

    [Parameter(Position=1, Mandatory=$false, ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Function to show usage information
function Show-Usage {
    Write-Host "Usage: icm4p.ps1 {d | bo | snb <story-name> | create-html-data-dashboard [-gitee] <project-name> | create-nextjs-web-app [-gitee] <project-name>}"
}

# Function to create timestamp in ICMwRIPER-5 format
function Get-ICMTimestamp {
    return (Get-Date -Format "yyyy-MM-dd--HH-mm")
}

# Function to download file with error handling
function Download-File {
    param(
        [string]$Url,
        [string]$OutputPath
    )

    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Function to update story references in file
function Update-StoryReferences {
    param(
        [string]$FilePath,
        [string]$NewStoryFilename
    )

    $content = Get-Content -Path $FilePath -Raw
    # Replace both numeric timestamps and template placeholder format
    $content = $content -replace '@icm-story-(\d{4}-\d{2}-\d{2}--\d{2}-\d{2}|yyyy-mm-dd--hh-mm)\.md', "@$NewStoryFilename"
    Set-Content -Path $FilePath -Value $content -NoNewline
}

# Special handling for single-argument commands
if ($null -eq $Arguments -or $Arguments.Count -eq 0) {
    if ($SubCommand -eq "d") {
        # d subcommand handler
        # Generate timestamp
        $timestamp = Get-ICMTimestamp

        # Define target filename
        $targetFile = "dialog-$timestamp.md"

        # Create empty file
        try {
            New-Item -Path $targetFile -ItemType File -Force | Out-Null
            Write-Host "Success: Created empty file '$targetFile'."
            exit 0
        }
        catch {
            Write-Host "Error: Failed to create '$targetFile'."
            exit 1
        }
    }
    elseif ($SubCommand -eq "bo") {
        # bo subcommand handler (bubble only)
        # Check if bubble only template exists
        if (-not (Test-Path -Path "icm-bubble-only-template.md" -PathType Leaf)) {
            Write-Host "Error: File 'icm-bubble-only-template.md' does not exist."
            exit 1
        }

        # Generate timestamp
        $timestamp = Get-ICMTimestamp

        # Define target filename
        $targetFile = "icm-bubble-only-$timestamp.md"

        # Copy template file
        try {
            Copy-Item -Path "icm-bubble-only-template.md" -Destination $targetFile -ErrorAction Stop
            Write-Host "Success: Copied 'icm-bubble-only-template.md' to '$targetFile'."
            exit 0
        }
        catch {
            Write-Host "Error: Failed to copy 'icm-bubble-only-template.md' to '$targetFile'."
            exit 1
        }
    }
    else {
        # Not a single-argument command, continue to two-argument command processing
    }
}

# For two-argument commands, validate that Arguments is provided
if ($null -eq $Arguments -or $Arguments.Count -eq 0) {
    Write-Host "Error: Command '$SubCommand' requires an argument."
    Show-Usage
    exit 1
}

# Subcommand routing
switch ($SubCommand) {
    "snb" {
        # SNB (Story aNd Bubble) subcommand handler
        # Store story name
        $storyName = $Arguments[0]

        # Check if source story file exists
        if (-not (Test-Path -Path $storyName -PathType Leaf)) {
            Write-Host "Error: File '$storyName' does not exist."
            exit 1
        }

        # Find bubble template files
        $templateFiles = Get-ChildItem -Path . -Filter "icm-bubble-template*" | Sort-Object
        if ($templateFiles.Count -eq 0) {
            Write-Host "Error: No bubble template files found. Expected files starting with 'icm-bubble-template'."
            exit 1
        }
        
        # Use the first template file found
        $templateFile = $templateFiles[0].FullName

        # Generate timestamp (will be used for both files)
        $timestamp = Get-ICMTimestamp

        # Define target filenames
        $storyTarget = "icm-story-$timestamp.md"
        $bubbleTarget = "icm-bubble-$timestamp.md"

        # Copy story file
        try {
            Copy-Item -Path $storyName -Destination $storyTarget -ErrorAction Stop
        }
        catch {
            Write-Host "Error: Failed to copy '$storyName' to '$storyTarget'."
            exit 1
        }

        # Copy bubble file
        try {
            Copy-Item -Path $templateFile -Destination $bubbleTarget -ErrorAction Stop
        }
        catch {
            Write-Host "Error: Failed to copy '$templateFile' to '$bubbleTarget'."
            # Cleanup: remove the story file that was already created
            Remove-Item -Path $storyTarget -Force -ErrorAction SilentlyContinue
            exit 1
        }

        # Replace the story reference with the newly created story filename
        Update-StoryReferences -FilePath $bubbleTarget -NewStoryFilename $storyTarget

        # Success message
        Write-Host "Success: Copied '$storyName' to '$storyTarget'."
        Write-Host "Success: Copied '$templateFile' to '$bubbleTarget' and updated story reference to '$storyTarget'."
        exit 0
    }

    "create-html-data-dashboard" {
        # Generate HTML Data Dashboard subcommand handler

        # Parse arguments to determine repository source and project name
        if ($Arguments.Count -ge 2 -and $Arguments[0] -eq "-gitee") {
            # Use Gitee repository
            $repoUrl = "https://gitee.com/wubin28/ICMwRIPER-5/raw/main"
            $projectName = $Arguments[1]
            $repoSource = "Gitee"
        }
        elseif ($Arguments.Count -eq 1 -and $Arguments[0] -ne "-gitee") {
            # Use GitHub repository (default)
            $repoUrl = "https://raw.githubusercontent.com/wubin28/ICMwRIPER-5/main"
            $projectName = $Arguments[0]
            $repoSource = "GitHub"
        }
        else {
            # Invalid arguments
            if ($Arguments.Count -eq 1 -and $Arguments[0] -eq "-gitee") {
                Write-Host "Error: Missing project name after '-gitee' flag."
            }
            elseif ($Arguments.Count -ge 1 -and $Arguments[0] -ne "-gitee") {
                Write-Host "Error: Invalid flag '$($Arguments[0])'. Expected '-gitee'."
            }
            else {
                Write-Host "Error: Invalid arguments for create-html-data-dashboard."
            }
            Write-Host "Usage: icm4p.ps1 create-html-data-dashboard [-gitee] <project-name>"
            exit 1
        }

        # Directory existence check
        if (Test-Path -Path $projectName -PathType Container) {
            Write-Host "Error: Directory '$projectName' already exists."
            exit 1
        }

        # Define files to download with their paths
        # Root files (5 files)
        $rootFiles = @("icm-bubble-template.md", "icm-story-template.md", "icmwriper-5.md", "README.md", "icm-bubble-only-template.md")

        # Subdirectory files (2 files)
        $subdirFiles = @(
            "for-html-data-dashboard/first-80-rows-agentic_ai_performance_dataset_20250622.xlsx",
            "for-html-data-dashboard/.gitignore"
        )

        # Create project directory
        try {
            New-Item -Path $projectName -ItemType Directory -Force | Out-Null
        }
        catch {
            Write-Host "Error: Failed to create directory '$projectName'."
            exit 1
        }

        # Download root files
        foreach ($filename in $rootFiles) {
            $url = "$repoUrl/$filename"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filename from $repoSource. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Download subdirectory files
        foreach ($filepath in $subdirFiles) {
            # Extract just the filename for the target
            $filename = Split-Path $filepath -Leaf
            $url = "$repoUrl/$filepath"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filepath from $repoSource. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Rename README.md
        $readmePath = Join-Path $projectName "README.md"
        $newReadmePath = Join-Path $projectName "icmwriper-5-README.md"
        Move-Item -Path $readmePath -Destination $newReadmePath

        # Success message
        Write-Host "Success: Project '$projectName' created with ICMwRIPER-5 template files and HTML data dashboard resources (7 files downloaded from $repoSource)."
        exit 0
    }

    "create-nextjs-web-app" {
        # Generate Next.js Web App subcommand handler

        # Parse arguments to determine repository source and project name
        if ($Arguments.Count -ge 2 -and $Arguments[0] -eq "-gitee") {
            # Use Gitee repository
            $repoUrl = "https://gitee.com/wubin28/ICMwRIPER-5/raw/main"
            $projectName = $Arguments[1]
            $repoSource = "Gitee"
        }
        elseif ($Arguments.Count -eq 1 -and $Arguments[0] -ne "-gitee") {
            # Use GitHub repository (default)
            $repoUrl = "https://raw.githubusercontent.com/wubin28/ICMwRIPER-5/main"
            $projectName = $Arguments[0]
            $repoSource = "GitHub"
        }
        else {
            # Invalid arguments
            if ($Arguments.Count -eq 1 -and $Arguments[0] -eq "-gitee") {
                Write-Host "Error: Missing project name after '-gitee' flag."
            }
            elseif ($Arguments.Count -ge 1 -and $Arguments[0] -ne "-gitee") {
                Write-Host "Error: Invalid flag '$($Arguments[0])'. Expected '-gitee'."
            }
            else {
                Write-Host "Error: Invalid arguments for create-nextjs-web-app."
            }
            Write-Host "Usage: icm4p.ps1 create-nextjs-web-app [-gitee] <project-name>"
            exit 1
        }

        # Directory existence check
        if (Test-Path -Path $projectName -PathType Container) {
            Write-Host "Error: Directory '$projectName' already exists."
            exit 1
        }

        # Define files to download with their paths
        # Root files (3 files)
        $rootFiles = @("icmwriper-5.md", "README.md", "icm-bubble-only-template.md")

        # Subdirectory files (3 files)
        $subdirFiles = @(
            "for-nextjs-web-app/icm-bubble-template-for-nextjs-web-app.md",
            "for-nextjs-web-app/icm-story-template-for-nextjs-web-app.md",
            "for-nextjs-web-app/.gitignore"
        )

        # Create project directory
        try {
            New-Item -Path $projectName -ItemType Directory -Force | Out-Null
        }
        catch {
            Write-Host "Error: Failed to create directory '$projectName'."
            exit 1
        }

        # Download root files
        foreach ($filename in $rootFiles) {
            $url = "$repoUrl/$filename"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filename from $repoSource. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Download subdirectory files
        foreach ($filepath in $subdirFiles) {
            # Extract just the filename for the target
            $filename = Split-Path $filepath -Leaf
            $url = "$repoUrl/$filepath"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filepath from $repoSource. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Rename README.md
        $readmePath = Join-Path $projectName "README.md"
        $newReadmePath = Join-Path $projectName "icmwriper-5-README.md"
        Move-Item -Path $readmePath -Destination $newReadmePath

        # Success message
        Write-Host "Success: Project '$projectName' created with ICMwRIPER-5 template files and Next.js web app resources (6 files downloaded from $repoSource)."
        exit 0
    }

    default {
        Write-Host "Error: Unknown command '$SubCommand'. Supported commands: 'd', 'bo', 'snb', 'create-html-data-dashboard', 'create-nextjs-web-app'."
        exit 1
    }
}