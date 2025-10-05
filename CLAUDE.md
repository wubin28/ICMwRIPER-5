# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the ICMwRIPER-5 methodology repository - a structured framework for human-AI collaboration in software development. It is NOT a software project with code to build or test. Instead, it provides:

1. **RIPER-5 Protocol** (`icmwriper-5.md`) - Strict operational rules requiring AI to work in 5 distinct modes: RESEARCH, INNOVATE, PLAN, EXECUTE, and REVIEW
2. **Cross-Platform CLI Tools** - Bash scripts for managing ICMwRIPER-5 projects:
   - `icmwriper-5-for-ubuntu` - Ubuntu/WSL2 version with global installation
   - `icmwriper-5-for-macos` - macOS version with local script execution
3. **Template Files** - Starting points for new iterations:
   - `icm-bubble-template.md` - AI interaction prompts template
   - `icm-story-template.md` - Story/requirements template

## Critical Protocol Requirement

**EVERY response must begin with mode declaration: `[MODE: MODE_NAME]`**

When users reference `@icmwriper-5.md` in their prompts, they are invoking this strict protocol. You MUST:

1. Always declare your current mode at the start of every response
2. Never transition between modes without explicit user permission
3. In EXECUTE mode, follow the approved plan with 100% fidelity
4. If any deviation is needed during EXECUTE, immediately return to PLAN mode

## File Naming Conventions

Iteration-specific files use timestamp format `yyyy-mm-dd--hh-mm`:
- `icm-bubble-yyyy-mm-dd--hh-mm.md` - AI prompts for specific iteration
- `icm-story-yyyy-mm-dd--hh-mm.md` - Requirements for specific iteration
- `todo-yyyy-mm-dd--hh-mm.md` - Task checklist (created during PLAN mode)
- `icm-context-yyyy-mm-dd--hh-mm.md` - Context snapshots for AI tool switching/context management

## Workflow Overview

Users following ICMwRIPER-5 will:
1. Create timestamped story and bubble files from templates
2. Send prompts referencing these files and the protocol
3. Expect you to progress through RESEARCH → INNOVATE → PLAN → EXECUTE → REVIEW
4. Require explicit approval before each mode transition

## Mode Transition Signals

Only transition when user explicitly signals:
- "ENTER RESEARCH MODE"
- "ENTER INNOVATE MODE"
- "ENTER PLAN MODE"
- "ENTER EXECUTE MODE"
- "ENTER REVIEW MODE"

## CLI Tool Commands

The repository includes dual-platform bash scripts that provide 4 subcommands for project management:

### Platform-Specific Commands

**Ubuntu/WSL2**: `icmwriper-5-for-ubuntu <subcommand> <argument>` (global install)
**macOS**: `./icmwriper-5-for-macos <subcommand> <argument>` (local script)

Both implementations provide identical functionality with platform-specific optimizations.

### generate - Bootstrap New Projects

Creates a new project directory and downloads template files from GitHub.

**Example**:
- Ubuntu: `icmwriper-5-for-ubuntu generate <project-name>`
- macOS: `./icmwriper-5-for-macos generate <project-name>`

### story - Create Timestamped Story Files

Copies a story file with current timestamp format `icm-story-yyyy-mm-dd--hh-mm.md`.

**Example**:
- Ubuntu: `icmwriper-5-for-ubuntu story <source-story-file>`
- macOS: `./icmwriper-5-for-macos story <source-story-file>`

### bubble - Create Timestamped Bubble Files

Copies a bubble file using the timestamp from the latest story file. Automatically updates story file references inside the bubble file.

**Important**: The bubble file timestamp matches the latest story file, NOT the current time.

**Example**:
- Ubuntu: `icmwriper-5-for-ubuntu bubble <source-bubble-file>`
- macOS: `./icmwriper-5-for-macos bubble <source-bubble-file>`

### snb - Create Matched Story-Bubble Pairs

Creates both story and bubble files with identical timestamps in one command. This is the recommended approach for starting new iterations.

**What it does**:
- Copies the source story file with current timestamp
- Copies `icm-bubble-template.md` with the same timestamp
- Automatically updates story references in the bubble file

**Example**:
- Ubuntu: `icmwriper-5-for-ubuntu snb <source-story-file>`
- macOS: `./icmwriper-5-for-macos snb <source-story-file>`

## Context Management

Users may request you to generate comprehensive context files (`icm-context-yyyy-mm-dd--hh-mm.md`) to:
- Switch to other AI tools while preserving project state
- Clear the current chat context and start fresh with full context
- Document project milestones
- Share project status with team members

When asked to create a context file, include:
- Executive summary of the project
- Business requirements implemented
- Technical architecture and design decisions
- Implementation details
- Usage examples
- Current status and next steps

These context files serve as handoff documents between AI sessions or AI tools.

### Common Context Management Tasks:

When users request context file updates, you may need to:
1. Copy existing context files with new timestamps using `cp` command
2. Update context files to reflect latest developments from story/bubble pairs
3. Add new sections documenting completed implementations
4. Update metadata with current iteration counts and status

### Cross-Platform Development Notes:

The project recently completed a significant macOS conversion (2025-10-05), converting the Ubuntu-only CLI to dual-platform support. Key technical differences resolved:
- **sed syntax**: Ubuntu uses basic regex, macOS requires extended regex with `-E` flag
- **Quantifier syntax**: Ubuntu `\{n\}` vs macOS `{n}` in regex patterns
- **Installation approach**: Ubuntu global install vs macOS local script execution

Both platforms now provide identical functionality with optimized native implementations.

## Repository Structure

This is a documentation/methodology repository with no build, test, or deployment commands. All files are Markdown templates and specifications.

### Key File Types:
- **Templates**: `icm-bubble-template.md`, `icm-story-template.md` - Starting points for iterations
- **CLI Scripts**: `icmwriper-5-for-ubuntu`, `icmwriper-5-for-macos` - Cross-platform project management tools
- **Protocol**: `icmwriper-5.md` - Core RIPER-5 methodology rules
- **Iterations**: `icm-story-yyyy-mm-dd--hh-mm.md`, `icm-bubble-yyyy-mm-dd--hh-mm.md` - Timestamped iteration files
- **Context**: `icm-context-yyyy-mm-dd--hh-mm.md` - AI context snapshots for tool switching
- **Tasks**: `todo-yyyy-mm-dd--hh-mm.md` - Task tracking (created during PLAN mode)

### Platform-Specific Technical Details:
- **Ubuntu**: Uses `sed -i` for in-place editing
- **macOS**: Uses `sed -i '' -E` for in-place editing with extended regex support
- Both platforms support identical timestamp format: `yyyy-mm-dd--hh-mm`

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
