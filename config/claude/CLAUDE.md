# Global Instructions

## Collaboration

- **Communicate more when context is thin**: Early in a session, before enough context has been gathered, check in with the user more often—ask clarifying questions and confirm direction instead of assuming. Decisions made at this stage carry the highest risk of rework.

## Writing

These conventions apply across code, tests, and documentation.

- **Record in the project's language**: When recording user input in any file (audit.md, plan, etc.), translate it into the language used by the project so all content stays consistent.
- **Space around English in Japanese**: When writing in Japanese, add spaces around English words and parentheses, just like in English.
  - Good: これは Claude Code の設定です (推奨)
  - Bad: これはClaude Codeの設定です（非推奨）
- **Order additions logically**: When adding elements—list items, type definitions, methods, test cases, bullet points, and the like—place them where they belong in a natural, logical order rather than simply appending to the end.
- **Write for an outside reader**: Write comments and documentation so that someone not involved in the change can understand them. Add the context needed to grasp the intent, but keep it concise and leave out information relevant only to the current working context.

## Development Principles

Follow the project's conventions first, while keeping these principles in mind:

- **Fail Fast**: Detect and report errors as early as possible. Validate inputs at boundaries and throw exceptions immediately rather than propagating invalid state.
- **SRP (Single Responsibility Principle)**: Each module, class, or function should have one reason to change. If you need "and" to describe what it does, consider splitting it.
- **Don't Mix Simple and Easy**: Keep simplicity (fewer concepts) and easiness (fewer steps) separate. Mixing them in the same place obscures intent and makes code harder to reason about.
- **Match each artifact to its intent ([HWWWn](https://scrapbox.io/tanaken0515/HWWWn_%EF%BC%88%E3%81%AF%E3%82%8F%E3%82%8F%E3%82%8F%E3%82%93%EF%BC%89%E3%81%AE%E5%8E%9F%E5%89%87))**: Express the right kind of intent in the right place—**code** expresses _How_ (what it does), **test code** expresses _What_ (the behavior guaranteed), **commit logs** express _Why_ (the reason for the change), and **code comments** express _Why not_ (why alternatives were rejected, and the constraints behind the choice).
- **Judge designs against a single dominant axis (Decision Quality)**: For any non-trivial design or architecture decision, name the one evaluation axis that matters most now, keep the rest as minimum-level secondary conditions, and check whether the current choice is falling into a known design-judgment failure pattern. The `design-judgment` skill holds the eight axes and the failure-pattern catalog—invoke it when the situation calls for one.

## Development Practices

- Follow [Conventional Commits](https://www.conventionalcommits.org/) format for commit messages, using the language that matches the project's convention.
- When making changes that affect documented behavior, update the relevant documentation (e.g., CLAUDE.md, README) in the same commit.
- When working with technical specifications, languages, frameworks, or libraries, always verify the latest information for the version in use before proceeding, as specifications may have changed over time.
- Before implementing with unfamiliar or potentially outdated technologies, invoke the `best-practices-researcher` agent to research current best practices.

## Working with External Systems

These apply to any system outside the local working copy—hosted services (e.g., GitHub, Slack), APIs, databases, and deployed environments.

- Before updating data on an external system, always read the current state first. Even if the same data was updated earlier in the session, someone else may have changed it since then, and writing without checking risks overwriting their work.
- When posting content (e.g., comments, messages) under the operator's account, include information that identifies the content as AI-generated.

## Tool Preferences

- **File search**: Prefer the Glob tool over `fd` over `find`.
- **Content search**: Prefer the Grep tool over `rg` over `grep`.

## Troubleshooting

- **Sandbox restrictions**: When a command fails, first suspect sandbox restrictions as the cause—not just for obvious "Operation not permitted" errors, but also for indirect failures like GPG/SSH signing errors or socket access issues. Always retry with sandbox disabled before attempting any other workaround. Never modify the command itself (e.g., adding flags to skip features) to work around a failure.
- **Interactive aliases**: `mv`, `cp`, and `rm` are aliased to their `-i` (interactive) variants in zsh, which prompt for confirmation and block non-interactive execution. When running these commands, always use the `-f` flag to bypass the interactive prompt (e.g., `mv -f`, `cp -f`, `rm -f`).
