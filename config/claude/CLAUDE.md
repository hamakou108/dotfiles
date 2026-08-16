# Global Instructions

## Collaboration

- **Communicate more when context is thin**: Early in a session, before enough context has been gathered, check in with the user more often—ask clarifying questions and confirm direction instead of assuming. Decisions made at this stage carry the highest risk of rework.
- **Check that the information needed for a decision is in hand**: Before making a judgment call, verify that the facts it depends on are actually available. No amount of reasoning ability compensates for missing information—the decision will simply be wrong. Some of it may lie outside what is reachable from here (intent behind a past decision, constraints from other teams, unshared context). Ask the user when the missing fact would change the decision; when it would not, state the assumption and proceed.

## Writing

These conventions apply across code, tests, and documentation.

- **Record in the project's language**: When recording user input in any file (audit.md, plan, etc.), translate it into the project's natural language—the one used in its docs and commit messages—so all content stays consistent.
- **Space around English in Japanese**: When writing in Japanese, add spaces around English words and parentheses, just like in English.
  - Good: これは Claude Code の設定です (推奨)
  - Bad: これはClaude Codeの設定です（非推奨）
- **Order additions logically**: When adding elements—list items, type definitions, methods, test cases, bullet points, and the like—place them where they belong in a natural, logical order rather than simply appending to the end.
- **Write for an outside reader**: Write comments and documentation so that someone not involved in the change can understand them. Add the context needed to grasp the intent, but keep it concise and leave out information relevant only to the current working context.
- **Don't record why something was changed**: Code and documentation describe the current state, not how it got there. Never write the reason for a modification into them—neither comments like `// changed from X to Y` nor prose like "previously this was ...". Readers rarely care whether a part was modified, so this is noise to them. The exception is an artifact whose *purpose* is to record what happened—commit logs, changelogs, ADRs, audit logs. Test: does this file exist to record that something occurred? If yes, the rationale belongs there; if it exists to describe how things are now, it does not. Writing _Why not_ remains fine where a reader would otherwise stumble over the choice—see the HWWWn principle under Development Principles.
- **Keep the conversation out of the artifact**: The exchange that produced the work is invisible to its readers. Never name the instruction behind a change ("as requested", "per review feedback"), and never add a qualifier just because the point came up in conversation. Test: remove it—if the meaning does not change, it was written for the exchange, not the reader.

## Development Principles

Follow the project's conventions first, while keeping these principles in mind:

- **Fail Fast**: Detect and report errors as early as possible. Validate inputs at boundaries and throw exceptions immediately rather than propagating invalid state.
- **SRP (Single Responsibility Principle)**: Each module, class, or function should have one reason to change. If you need "and" to describe what it does, consider splitting it.
- **Don't Mix Simple and Easy**: Keep simplicity (fewer concepts) and easiness (fewer steps) separate. Mixing them in the same place obscures intent and makes code harder to reason about.
- **Match each artifact to its intent ([HWWWn](https://scrapbox.io/tanaken0515/HWWWn_%EF%BC%88%E3%81%AF%E3%82%8F%E3%82%8F%E3%82%8F%E3%82%93%EF%BC%89%E3%81%AE%E5%8E%9F%E5%89%87))**: Express the right kind of intent in the right place—**code** expresses _How_ (what it does), **test code** expresses _What_ (the behavior guaranteed), **commit logs** express _Why_ (the reason for the change), and **code comments** express _Why not_ (why alternatives were rejected, and the constraints behind the choice).
- **Judge designs against a single dominant axis (Decision Quality)**: For any non-trivial design or architecture decision, name the one evaluation axis that matters most now, keep the rest as minimum-level secondary conditions, and check whether the current choice is falling into a known design-judgment failure pattern. The `design-judgment` skill holds the evaluation axes and the failure-pattern catalog—invoke it when the situation calls for one.

## Development Practices

These apply at the boundaries of a change—what to confirm before starting, and what to include when committing.

- **Verify the specification in use**: Check the current specification for the version in use before relying on it—specifications change. Trigger on observable signals: the version postdates your knowledge cutoff, the repository pins a version you have not confirmed, or a call fails in a way the documented behavior does not explain.
- **Research unconfirmed technologies**: Invoke the `best-practices-researcher` agent before implementing against a technology whose current practices you have not confirmed. Treat it as unconfirmed unless this session has established how the version in use is meant to be used.
- **Commit with Conventional Commits**: Follow [Conventional Commits](https://www.conventionalcommits.org/) format for commit messages, using the language that matches the project's convention.
- **Update affected documentation**: When making changes that affect documented behavior, update the relevant documentation (e.g., CLAUDE.md, README) in the same commit.

## Working with External Systems

These apply to any system outside the local working copy—hosted services (e.g., GitHub, Slack), APIs, databases, and deployed environments.

- Before updating data on an external system, always read the current state first. Even if the same data was updated earlier in the session, someone else may have changed it since then, and writing without checking risks overwriting their work.
- When posting content (e.g., comments, messages) under the operator's account, close it with an attribution naming the model that wrote it, in this canonical form:

  `🤖 Written by <model name>.`

  Take the model name from your own runtime rather than inferring it; where it is unavailable, write `unspecified` in its place. Put the attribution on its own line as plain text, with no decoration of any kind—no blockquote, no horizontal rule, no `<sub>` or other markup, and no restyling to match the destination.

## Tool Preferences

- **File search**: Prefer a dedicated file-search tool when the session offers one; otherwise use `fd`.
- **Content search**: Prefer a dedicated content-search tool when the session offers one; otherwise use `rg`.

## Troubleshooting

- **Sandbox restrictions**: When a command fails with a sandbox signature—"Operation not permitted", or indirect failures like GPG/SSH signing errors or socket access issues—retry with the sandbox disabled before attempting any other workaround. Never modify the command itself (e.g., adding flags to skip features) to work around a failure.
- **Permission denials are not sandbox restrictions**: "Permission to use X has been denied" means a permission rule or the user rejected the call. Disabling the sandbox will not help and must not be attempted. Switch to an allowed tool or ask, and do not retry the same call.
- **Interactive aliases**: Destructive file commands (`mv`, `cp`, `rm`) may be aliased to their `-i` (interactive) variants in zsh, which prompt for confirmation and block non-interactive execution. Pass `-f` when running them (e.g., `mv -f`, `cp -f`, `rm -f`).
