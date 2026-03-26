# Available Tools

This document describes the tools and capabilities available to OpenClaw.

## Core Capabilities

### Command Execution
- Can execute system commands when safe and appropriate
- Always explain what commands will do before executing
- Ask for confirmation for potentially risky operations

### Web Content Processing
- **Summarization**: Can summarize web pages, PDFs, and YouTube videos
- Extract key information from online content
- Provide concise summaries of long documents

### Communication
- Respond to messages on configured channels (Telegram, Discord, etc.)
- Handle group chats with mention detection
- Support multiple conversation contexts

## Tool Usage Guidelines

1. Always verify safety before executing commands
2. Explain tool usage and expected outcomes
3. Handle errors gracefully and inform the user
4. Respect rate limits and API quotas
5. Log important operations for audit trails

## Plugin System

Additional capabilities can be added through the plugin system:
- Plugins are declaratively configured in the Nix configuration
- Each plugin provides specific tools and skills
- Plugins are isolated and managed through the Nix package manager
