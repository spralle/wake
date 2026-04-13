# Copilot Instructions

## Code Style
- Prefer explicit types over inference when the type is not obvious from context.
- Use named exports, not default exports.
- Keep functions under 50 lines and files under 400 lines.
- Prefer early returns and guard clauses over deep nesting.
- Use `const` by default. Use `let` only when reassignment is necessary.

## TypeScript
- Never use explicit `any`. Use `unknown` with type narrowing.
- Prefer discriminated unions at domain boundaries.
- Use type guards instead of type assertions.

## Comments
- Only add comments for intent, invariants, or non-obvious tradeoffs.
- Do not add comments that restate what the code does.

## Testing
- Add tests proportional to risk and blast radius.
- Prefer unit tests for business logic, integration tests for boundaries.

## Error Handling
- Use typed error classes or result types at boundaries.
- Never swallow errors silently.
