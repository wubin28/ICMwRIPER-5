# ICMwRIPER-5 (Iterative Context Management with RIPER-5) Method

An AI-assisted software development methodology that iteratively applies 1 human-driven Context Management step and 5 [RIPER-5](https://forum.cursor.com/t/i-created-an-amazing-mode-called-riper-5-mode-fixes-claude-3-7-drastically/65516) rules (Research, Innovate, Plan, Execute, Review) to guide AI code generation, producing higher-quality code that better meets your requirements.

## The Problem

Directly presenting final requirements to AI often leads to code generation that deviates from intended outcomes because the AI lacks human intervention during the development process. Without structured guidance, AI assistants may:

- Make assumptions that don't align with your actual needs
- Skip important planning steps and jump directly to implementation
- Generate code that technically works but doesn't solve the right problem
- Introduce unnecessary complexity or miss edge cases
- Drift away from the original vision as the codebase evolves

## The Solution: ICMwRIPER-5 Method

ICMwRIPER-5 provides a structured, iterative approach that keeps both human and AI aligned throughout the development lifecycle. By separating concerns into distinct phases and maintaining clear context management, this method ensures that AI-generated code stays on track and meets actual requirements.

## How It Works

The ICMwRIPER-5 method consists of six distinct phases that create a collaborative workflow between human and AI:

### 1. **Iterative Context Management (by human)**
Iteratively review and update two key files:
- `icm-story-yyyy-mm-dd--hh-mm.md` - Story description for the current iteration
- `icm-bubble-yyyy-mm-dd--hh-mm.md` - Starting prompts for the AI (bubbles visualize the chat bubbles between humans and AI)
- `icmwriper-5.md` - Updated RIPER-5 protocol rules

This ensures proper alignment of AI context before entering the RIPER-5 iteration. Once ready, send the prompts from `icm-bubble-yyyy-mm-dd--hh-mm.md` to the AI to begin.

### 2. **RESEARCH (by AI & human)**
Information gathering and file reading only. No code changes or implementation decisions are made. The AI explores the codebase, reads relevant files, and gathers necessary context.

**Critical**: AI assistants must declare `[MODE: RESEARCH]` at the start of their response.

### 3. **INNOVATE (by AI & human)**
Brainstorming approaches without implementation. The AI proposes multiple solution strategies, discusses trade-offs, and collaborates with you to select the best approach.

**Critical**: AI assistants must declare `[MODE: INNOVATE]` at the start of their response.

### 4. **PLAN (by AI & human)**
Create comprehensive technical specifications and save them to a timestamped todo file (`todo-yyyy-mm-dd--hh-mm.md`). The plan should be detailed enough to execute mechanically.

**Critical**: AI assistants must declare `[MODE: PLAN]` at the start of their response.

### 5. **EXECUTE (by AI & human)**
Follow the plan exactly with no creative decisions. The AI implements only what was specified in the plan, ensuring predictable outcomes and preventing scope creep.

**Critical**: AI assistants must declare `[MODE: EXECUTE]` at the start of their response.

### 6. **REVIEW (by AI & human)**
Validate implementation against the original plan. Check for completeness, correctness, and alignment with requirements. Then return to phase 1 for the next iteration.

**Critical**: AI assistants must declare `[MODE: REVIEW]` at the start of their response.

## Getting Started

### 1. Set Up Template Files

The repository includes two template files and one RIPER-5 file:
- `icm-bubble-template.md` - Starting prompt template
- `icm-story-template.md` - Story description template
- `icmwriper-5.md` - Updated RIPER-5 protocol rules

### 2. Create Your First Iteration

When starting a new iteration:

1. Copy the template files
2. Rename them to include the current timestamp:
   - `icm-bubble-yyyy-mm-dd--hh-mm.md`
   - `icm-story-yyyy-mm-dd--hh-mm.md`
3. Modify the content according to your specific iteration story
4. Send the prompts from `icm-bubble-yyyy-mm-dd--hh-mm.md` to your AI assistant

### 3. Follow the Workflow

Progress through each RIPER-5 phase systematically. Ensure your AI assistant declares the current mode at the start of each response. When the AI ​​stops in each mode and waits for your signals, carefully check the AI's output and, if necessary, ask the AI ​​to make adjustments until you are satisfied before issuing the signal to enter the next mode.

## Project Structure

```
├── icm-bubble-template.md       # Starting prompt template
├── icm-story-template.md        # Story description template
├── icmwriper-5.md              # Updated RIPER-5 protocol rules
├── README.md                   # This file
├── icm-bubble-yyyy-mm-dd--hh-mm.md   # Iteration prompts (created per iteration)
├── icm-story-yyyy-mm-dd--hh-mm.md    # Iteration stories (created per iteration)
└── todo-yyyy-mm-dd--hh-mm.md        # Task tracking (created during PLAN phase)
```

## Key Benefits

- **Controlled AI Behavior**: Explicit mode declarations prevent AI from jumping ahead or making unplanned decisions
- **Human Oversight**: Each phase requires human review and approval before proceeding
- **Iterative Refinement**: Regular return to Context Management keeps the project aligned with evolving requirements
- **Clear Documentation**: Timestamped files create an audit trail of decision-making
- **Predictable Outcomes**: Separation of planning and execution reduces unexpected surprises
- **Better Code Quality**: Thorough research and planning phases lead to more thoughtful implementations

## Use Cases

ICMwRIPER-5 is particularly effective for:

- **Complex Feature Development**: Multi-step features requiring careful planning
- **Refactoring Projects**: Large-scale code reorganization where AI might otherwise introduce breaking changes
- **Learning New Codebases**: Systematic exploration before making changes
- **Team Collaboration**: Clear phases make it easier to hand off work between team members
- **Quality-Critical Projects**: Applications where correctness is more important than speed

## Best Practices

1. **One Phase at a Time**: Don't skip phases or combine them
2. **Document Everything**: Keep thorough notes in your story and bubble files
3. **Review Before Proceeding**: Always validate AI output before moving to the next phase
4. **Update Context Regularly**: Return to Context Management phase when requirements change
5. **Enforce Mode Declarations**: Ensure your AI assistant explicitly declares its mode
6. **Maintain Timestamps**: Use consistent naming for all iteration files

## Contributing

We welcome contributions to improve the ICMwRIPER-5 methodology:

- Share your experience using the method
- Propose enhancements to the workflow
- Submit example projects demonstrating the methodology
- Improve documentation and templates

## Security

- Handle sensitive operations with appropriate user confirmation
- Never commit API keys or sensitive data
- Validate all file operations before execution
- Review AI-generated code carefully before deployment

## Further Reading

For detailed protocol specifications, see `icmwriper-5.md` in this repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

The orginial RIPER framework is by: [robotlovehuman](https://forum.cursor.com/t/i-created-an-amazing-mode-called-riper-5-mode-fixes-claude-3-7-drastically/65516)