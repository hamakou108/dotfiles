# Global Instructions

## General Practices

When writing in Japanese, add spaces around English words and parentheses, just like in English.

- Good: これは Claude Code の設定です (推奨)
- Bad: これはClaude Codeの設定です（非推奨）

## Development Practices

- Follow [Conventional Commits](https://www.conventionalcommits.org/) format for commit messages, using the language that matches the project's convention.
- When making changes that affect documented behavior, update the relevant documentation (e.g., CLAUDE.md, README) in the same commit.
- When working with technical specifications, languages, frameworks, or libraries, always verify the latest information for the version in use before proceeding, as specifications may have changed over time.

## Coding Principles

Follow the project's conventions first, while keeping these principles in mind:

- **Fail Fast**: Detect and report errors as early as possible. Validate inputs at boundaries and throw exceptions immediately rather than propagating invalid state.
- **SRP (Single Responsibility Principle)**: Each module, class, or function should have one reason to change. If you need "and" to describe what it does, consider splitting it.
- **Don't Mix Simple and Easy**: Keep simplicity (fewer concepts) and easiness (fewer steps) separate. Mixing them in the same place obscures intent and makes code harder to reason about.

## Tool Preferences

- **File search**: Prefer the Glob tool over `fd` over `find`.
- **Content search**: Prefer the Grep tool over `rg` over `grep`.

## Troubleshooting

- **Sandbox restrictions**: When a command fails, first suspect sandbox restrictions as the cause—not just for obvious "Operation not permitted" errors, but also for indirect failures like GPG/SSH signing errors or socket access issues. Always retry with sandbox disabled before attempting any other workaround. Never modify the command itself (e.g., adding flags to skip features) to work around a failure.
