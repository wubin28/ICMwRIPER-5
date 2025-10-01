# Xiao Wu AI Coding Tools Showdown by Generating HTML Data Dashboard

A comparison of AI coding tools through a Python project that analyzes and visualizes AI agent performance metrics from Excel data, creates interactive HTML dashboards, and utilizes the ICMwRIPER-5 methodology.

## Project Purpose

This project evaluates the performance of various AI-assisted programming tools and their associated large language models through practical implementation challenges. Rather than relying solely on programming competition scores, we assess these rapidly evolving AI coding tools through real-world tasks that generate HTML data visualization dashboards, providing meaningful insights into their actual capabilities and effectiveness.

## Evaluation Methodology

Each Git branch represents a single evaluation session, with branch names containing comprehensive evaluation metadata. For example, the branch `2025-09-28--20-09-satisfied-by-codebuddycode-with-default-deepseekv3.1-in-codebuddycn-on-wsl` indicates:

- **Timestamp**: Evaluation started on September 28, 2025, at 20:09
- **Result**: "satisfied" - indicating satisfactory performance
- **AI CLI Tool**: CodeBuddy Code CLI
- **Model**: Default configuration with DeepSeek v3.1 large language model
- **AI IDE**: CodeBuddyCN (China domestic version)
- **Platform**: Windows 11 WSL2 Ubuntu 24.04

This systematic naming convention enables tracking and comparison of different AI tool combinations across various environments and configurations.

## ICMwRIPER-5 (Iterative Context Management with RIPER-5) Method

This project follows the **ICMwRIPER-5 Method** with six distinct development phases:

1. **Iterative Context Management** - Iteratively review and update the story description file `icm-story-yyyy-mm-dd--hh-mm.md` and starting prompt file `icm-bubble-yyyy-mm-dd--hh-mm.md` based on the current iteration story. This ensures proper alignment of AI context before entering the RIPER-5 iteration. Then send the prompts from `icm-bubble-yyyy-mm-dd--hh-mm.md` to the AI.
2. **RESEARCH** - Information gathering and file reading only
3. **INNOVATE** - Brainstorming approaches without implementation
4. **PLAN** - Create comprehensive technical specifications and save to timestamped todo file
5. **EXECUTE** - Follow the plan exactly with no creative decisions
6. **REVIEW** - Validate implementation against the original plan and go back to phase 1

**Critical**: AI assistants must declare their current mode with `[MODE: MODE_NAME]` at the start of each response.

### Getting Started with ICMwRIPER-5 Method

The `icm-bubble-template.md` and `icm-story-template.md` files serve as an Iterative Context Management template with prompt instructions. When first using this template:

1. Copy the `icm-bubble-template.md` and `icm-story-template.md` file
2. Rename them to `icm-bubble-yyyy-mm-dd--hh-mm.md` and `icm-story-yyyy-mm-dd--hh-mm.md` (using current timestamp)
3. Modify the content according to the specific story of the current iteration
4. Send the prompts from `icm-bubble-yyyy-mm-dd--hh-mm.md` to the AI to start a new iteration

This approach ensures each development iteration has customized context and prompts while maintaining consistency with the overall project structure.

## Project Description

This project processes and visualizes data from the "Agentic AI Performance Dataset 2025" to answer three key research questions about AI agent capabilities:

1. **Multimodal Agent Types**: Top 3 agent types by multimodal processing capability percentage
2. **Multimodal Architectures**: Top 3 model architectures by multimodal processing capability percentage
3. **Bias Detection Performance**: Top 3 task categories by bias detection median scores

## Features

- Excel data processing and analysis
- Interactive HTML dashboard generation
- Mobile-responsive design with light color scheme
- Static output (no external dependencies required)
- Comprehensive data visualization using multiple chart types

## Requirements

- Python 3.12
- Virtual environment (pre-configured)
- Excel dataset: `first-80-rows-agentic_ai_performance_dataset_20250622.xlsx` (80 records)

## Installation & Setup

1. **Activate the virtual environment:**
   ```bash

   # Linux/macOS
   python3 -m venv venv
   source venv/bin/activate

   # Windows
   python -m venv venv
   venv\Scripts\activate

   # exit venv
   deactivate
   ```

2. **Verify installed packages and Python version:**
   ```bash
   python --version
   pip list
   ```

## Dependencies

The project includes these pre-installed packages:

- **pandas** (2.3.2) - Data manipulation and analysis
- **openpyxl** (3.1.5) - Excel file reading
- **matplotlib** (3.10.6) - Static plotting
- **seaborn** (0.13.2) - Statistical visualization
- **plotly** (6.3.0) - Interactive plotting
- **numpy** (2.3.3) - Numerical computing

## Checking the data analysis result

1. **Run the data analysis script:**
   ```bash
   python analyze_data.py # Windows
   python3 analyze_data.py # macOS/Linux
   ```

2. **Open the generated dashboard:**
   ```bash
   # Open data-dashboard.html in your browser
   open data-dashboard.html      # macOS
   start data-dashboard.html     # Windows
   xdg-open data-dashboard.html  # Linux/WSL
   ```

## Output Files

- `analyze_data.py` - Python script for data processing and analysis
- `data-dashboard.html` - Interactive HTML dashboard with visualizations

## Project Structure

```
├── venv/                                                   # Python virtual environment
├── CLAUDE.md                                               # For Claude Code
├── first-80-rows-agentic_ai_performance_dataset_20250622.xlsx # Excel dataset (80 records)
├── icm-bubble-template.md                                  # Starting prompt template
├── icm-story-template.md                                   # Project story template (Chinese)
├── icmwriper-5.md                                          # ICMwRIPER-5 development protocol
├── README.md                                               # Project documentation
├── todo-yyyy-mm-dd--hh-mm.md                               # Task tracking
├── analyze_data.py                                      # Data processing script (generated)
└── data-dashboard.html                                     # Visualization dashboard (generated)
```

## Data Analysis Focus

The dashboard provides insights into:

- **Agent Type Analysis**: Distribution and capabilities of different AI agent types
- **Architecture Performance**: Comparison of model architectures and their multimodal capabilities
- **Bias Detection Metrics**: Fairness performance across different task categories
- **Statistical Summaries**: Comprehensive data overview and key metrics

## Technical Notes

- All visualizations are embedded in the HTML file (no external dependencies)
- Mobile-responsive design ensures compatibility across devices
- Light color scheme optimized for readability
- Dataset contains 80 records of AI agent performance data

## Security

- Handle sensitive operations with appropriate user confirmation
- Never commit API keys or sensitive data
- Validate all file operations before execution
