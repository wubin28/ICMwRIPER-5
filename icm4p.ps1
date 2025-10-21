#!/usr/bin/env pwsh

# ICMwRIPER-5 PowerShell Script for Windows 11
# Converted from icmwriper-5-for-ubuntu for PowerShell 7.5.3 compatibility

param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$SubCommand,

    [Parameter(Position=1, Mandatory=$false)]
    [string]$Argument
)

# Function to show usage information
function Show-Usage {
    Write-Host "Usage: icmwriper-5-for-pwsh {b | bo | snb <story-name> | create-html-data-dashboard <project-name> | create-nextjs-web-app <project-name>}"
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
if ([string]::IsNullOrEmpty($Argument)) {
    if ($SubCommand -eq "b") {
        # b subcommand handler
        # Generate timestamp
        $timestamp = Get-ICMTimestamp

        # Define target filename
        $targetFile = "bubble-$timestamp.md"

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
        Write-Host "Error: Unknown single-argument command '$SubCommand'."
        Show-Usage
        exit 1
    }
}

# For two-argument commands, validate that Argument is provided
if ([string]::IsNullOrEmpty($Argument)) {
    Show-Usage
    exit 1
}

# Subcommand routing
switch ($SubCommand) {
    "snb" {
        # SNB (Story aNd Bubble) subcommand handler
        # Store story name
        $storyName = $Argument

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
        # Store project name
        $projectName = $Argument

        # Directory existence check
        if (Test-Path -Path $projectName -PathType Container) {
            Write-Host "Error: Directory '$projectName' already exists."
            exit 1
        }

        # GitHub repository configuration
        $githubRawUrl = "https://raw.githubusercontent.com/wubin28/ICMwRIPER-5/main"

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
            $url = "$githubRawUrl/$filename"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filename from GitHub. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Download subdirectory files
        foreach ($filepath in $subdirFiles) {
            # Extract just the filename for the target
            $filename = Split-Path $filepath -Leaf
            $url = "$githubRawUrl/$filepath"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filepath from GitHub. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Rename README.md
        $readmePath = Join-Path $projectName "README.md"
        $newReadmePath = Join-Path $projectName "icmwriper-5-README.md"
        Move-Item -Path $readmePath -Destination $newReadmePath

        # Success message
        Write-Host "Success: Project '$projectName' created with ICMwRIPER-5 template files and HTML data dashboard resources (7 files downloaded)."
        exit 0
    }

    "create-nextjs-web-app" {
        # Generate Next.js Web App subcommand handler
        # Store project name
        $projectName = $Argument

        # Directory existence check
        if (Test-Path -Path $projectName -PathType Container) {
            Write-Host "Error: Directory '$projectName' already exists."
            exit 1
        }

        # GitHub repository configuration
        $githubRawUrl = "https://raw.githubusercontent.com/wubin28/ICMwRIPER-5/main"

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
            $url = "$githubRawUrl/$filename"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filename from GitHub. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Download subdirectory files
        foreach ($filepath in $subdirFiles) {
            # Extract just the filename for the target
            $filename = Split-Path $filepath -Leaf
            $url = "$githubRawUrl/$filepath"
            $outputPath = Join-Path $projectName $filename

            if (-not (Download-File -Url $url -OutputPath $outputPath)) {
                Write-Host "Error: Failed to download $filepath from GitHub. Please check your internet connection and repository availability."
                Remove-Item -Path $projectName -Recurse -Force -ErrorAction SilentlyContinue
                exit 1
            }
        }

        # Rename README.md
        $readmePath = Join-Path $projectName "README.md"
        $newReadmePath = Join-Path $projectName "icmwriper-5-README.md"
        Move-Item -Path $readmePath -Destination $newReadmePath

        # Success message
        Write-Host "Success: Project '$projectName' created with ICMwRIPER-5 template files and Next.js web app resources (6 files downloaded)."
        exit 0
    }

    default {
        Write-Host "Error: Unknown command '$SubCommand'. Supported commands: 'b', 'bo', 'snb', 'create-html-data-dashboard', 'create-nextjs-web-app'."
        exit 1
    }
}