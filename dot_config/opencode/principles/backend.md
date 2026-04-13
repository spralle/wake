# Backend Code Principles

Extends the universal and language-specific principles with backend/API rules.

## Principles

- **Structured error responses**: Use typed error types with codes, messages, and optional detail payloads. Never leak stack traces or internal state to clients.
- **Structured logging**: Use structured (JSON) logging with context fields (request ID, user, operation). Avoid unstructured string concatenation in log messages.
- **Input validation at the boundary**: Validate and parse all external input at API boundaries. Trust validated data internally — do not re-validate in business logic.
- **Idempotency**: Mutating operations should be idempotent where possible. Document operations that are not idempotent.
- **Secrets hygiene**: Never log, return, serialize, or hardcode secrets. Use environment variables or secret managers. Reject PRs that contain secrets.
- **Dependency injection**: Prefer constructor/parameter injection for external dependencies (database, HTTP clients, config). Avoid global singletons that complicate testing.
- **Graceful shutdown**: Services must handle termination signals cleanly — drain connections, flush buffers, complete in-flight requests where feasible.

## Backend PR Checklist (extends universal + language)

- [ ] Error responses are structured with codes and messages.
- [ ] Logging is structured with context fields.
- [ ] External input is validated at the boundary.
- [ ] No secrets in code, logs, or error responses.
- [ ] Services handle graceful shutdown.
