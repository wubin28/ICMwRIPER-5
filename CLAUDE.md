# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the ICMwRIPER-5 methodology repository - a structured framework for human-AI collaboration in software development. It is NOT a software project with code to build or test. Instead, it provides:

1. **RIPER-5 Protocol** (`icmwriper-5.md`) - Strict operational rules requiring AI to work in 5 distinct modes: RESEARCH, INNOVATE, PLAN, EXECUTE, and REVIEW
2. **Template Files** - Starting points for new iterations:
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

## Repository Structure

This is a documentation/methodology repository with no build, test, or deployment commands. All files are Markdown templates and specifications.
