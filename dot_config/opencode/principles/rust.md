# Rust Code Principles

Extends the universal principles with Rust-specific rules.

## Principles

- **Ownership clarity**: Prefer owned types at API boundaries. Use references for internal operations where lifetimes are clear.
- **Error handling**: Use `thiserror` for library error types, `anyhow` for application-level errors. No `.unwrap()` in production code unless the invariant is proven and documented.
- **Clippy compliance**: `cargo clippy -- -D warnings` must pass. Treat Clippy lints as errors, not suggestions.
- **Unsafe blocks**: Minimize unsafe code. Each `unsafe` block requires a `// SAFETY:` comment explaining what invariants are upheld and why.
- **Pattern matching**: Prefer exhaustive `match` over `if let` chains when handling enums. Let the compiler catch missing variants.
- **Dependency hygiene**: Minimize external dependencies. Prefer std-library solutions when the difference in complexity is small.
- **Documentation**: Public API items must have doc comments. Use `#[must_use]` for functions whose return values should not be ignored.

## Rust PR Checklist (extends universal)

- [ ] `cargo clippy -- -D warnings` passes.
- [ ] No `.unwrap()` in production code without proven invariant.
- [ ] Every `unsafe` block has a `// SAFETY:` comment.
- [ ] Public API items have doc comments.
- [ ] `cargo test` passes.
