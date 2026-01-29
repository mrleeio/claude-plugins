# Conventional Commits v1.0.0 Specification

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Specification

1. Commits MUST be prefixed with a type, which consists of a noun, `feat`, `fix`, etc., followed by the OPTIONAL scope, OPTIONAL `!`, and REQUIRED terminal colon and space.

2. The type `feat` MUST be used when a commit adds a new feature to your application or library.

3. The type `fix` MUST be used when a commit represents a bug fix for your application.

4. A scope MAY be provided after a type. A scope MUST consist of a noun describing a section of the codebase surrounded by parenthesis, e.g., `fix(parser):`

5. A description MUST immediately follow the colon and space after the type/scope prefix. The description is a short summary of the code changes, e.g., `fix: array parsing issue when multiple spaces were contained in string`.

6. A longer commit body MAY be provided after the short description, providing additional contextual information about the code changes. The body MUST begin one blank line after the description.

7. A commit body is free-form and MAY consist of any number of newline separated paragraphs.

8. One or more footers MAY be provided one blank line after the body. Each footer MUST consist of a word token, followed by either a `:<space>` or `<space>#` separator, followed by a string value (this is inspired by the git trailer convention).

9. A footer's token MUST use `-` in place of whitespace characters, e.g., `Acked-by` (this helps differentiate the footer section from a multi-paragraph body). An exception is made for `BREAKING CHANGE`, which MAY also be used as a token.

10. A footer's value MAY contain spaces and newlines, and parsing MUST terminate when the next valid footer token/separator pair is observed.

11. Breaking changes MUST be indicated in the type/scope prefix of a commit, or as an entry in the footer.

12. If included as a footer, a breaking change MUST consist of the uppercase text `BREAKING CHANGE`, followed by a colon, space, and description, e.g., `BREAKING CHANGE: environment variables now take precedence over config files`.

13. If included in the type/scope prefix, breaking changes MUST be indicated by a `!` immediately before the `:`. If `!` is used, `BREAKING CHANGE:` MAY be omitted from the footer section, and the commit description SHALL be used to describe the breaking change.

14. Types other than `feat` and `fix` MAY be used in your commit messages, e.g., `docs: update ref docs`.

15. The units of information that make up Conventional Commits MUST NOT be treated as case sensitive by implementors, with the exception of `BREAKING CHANGE` which MUST be uppercase.

16. `BREAKING-CHANGE` MUST be synonymous with `BREAKING CHANGE`, when used as a token in a footer.

## Commit Types

| Type | Description | SemVer Impact |
|------|-------------|---------------|
| `feat` | New feature for the user | MINOR |
| `fix` | Bug fix for the user | PATCH |
| `docs` | Documentation only changes | - |
| `style` | Formatting, whitespace, semicolons (no code change) | - |
| `refactor` | Code restructuring without behavior change | - |
| `perf` | Performance improvements | PATCH |
| `test` | Adding or updating tests | - |
| `build` | Build system or external dependencies | - |
| `ci` | CI configuration and scripts | - |
| `chore` | Maintenance tasks, tooling | - |
| `revert` | Reverting a previous commit | varies |

**Breaking changes** (indicated with `!` or `BREAKING CHANGE` footer) trigger a MAJOR version bump.

## Breaking Change Patterns

### Using `!` in Type Prefix

```
feat!: Remove deprecated API endpoints

The /v1/users endpoint has been removed. Use /v2/users instead.
```

```
fix(auth)!: Change token format to JWT
```

### Using Footer

```
feat: Allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

### Combined

```
refactor!: Drop support for Node 6

BREAKING CHANGE: Use JavaScript features not available in Node 6.
```

## Examples

### feat

```
feat: Add user avatar upload functionality
```

```
feat(auth): Implement OAuth2 login flow
```

### fix

```
fix: Prevent racing of requests
```

```
fix(api): Handle null response from external service
```

### docs

```
docs: Update installation instructions for Windows
```

### style

```
style: Format code with Prettier
```

### refactor

```
refactor: Extract validation logic into separate module
```

### perf

```
perf: Lazy load images below the fold
```

### test

```
test: Add missing unit tests for user service
```

### build

```
build: Update webpack to version 5
```

### ci

```
ci: Add GitHub Actions workflow for tests
```

### chore

```
chore: Update dependencies to latest versions
```

### revert

```
revert: feat: Add user avatar upload functionality

This reverts commit abc1234.
```

## Multi-line Commit with Body and Footer

```
fix(api): Handle rate limiting errors gracefully

When the external API returns a 429 status, the client now implements
exponential backoff with a maximum of 3 retries. This prevents the
application from failing completely during rate limit periods.

Closes #123
Reviewed-by: Alice
```

## Scope Examples

Scopes are project-specific nouns that describe the affected section:

- `feat(parser):` - Parser module
- `fix(auth):` - Authentication system
- `docs(readme):` - README file
- `style(button):` - Button component
- `refactor(api):` - API layer
- `test(utils):` - Utility functions
