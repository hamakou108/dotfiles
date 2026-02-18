# Global Instructions

## Writing Style

When writing in Japanese, add spaces around English words and parentheses, just like in English.

- Good: これは Claude Code の設定です (推奨)
- Bad: これはClaude Codeの設定です（非推奨）

## Git Commit Messages

- Follow [Conventional Commits](https://www.conventionalcommits.org/) format
- Use the language that matches the project's convention

## Coding Principles

Follow the project's conventions first, while keeping these principles in mind:

- **Fail Fast**: Detect and report errors as early as possible. Validate inputs at boundaries and throw exceptions immediately rather than propagating invalid state.
- **SRP (Single Responsibility Principle)**: Each module, class, or function should have one reason to change. If you need "and" to describe what it does, consider splitting it.
- **Don't Mix Simple and Easy**: Keep simplicity (fewer concepts) and easiness (fewer steps) separate. Mixing them in the same place obscures intent and makes code harder to reason about.

## Research and Verification

- **Verify Version-Specific Information**: When working with technical specifications, languages, frameworks, or libraries, always verify the latest information for the version in use before proceeding, as specifications may have changed over time.
