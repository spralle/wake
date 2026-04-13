## Chain of Command

Flow:

Builder (Lead/Orchestrate) -> Architect (Plan) -> Engineer (Build) -> Auditor (Test) -> Diplomat (Deploy)

Supporting roles:

- Explorer (Research/Discovery) supports Builder and Architect with fast codebase investigation.
- Janitor handles maintenance and technical debt.
- Watchman monitors for stalled flow and execution loops.
- YOLO handles small, self-contained, low-risk tasks directly.

Explorer usage policy (conditional, not default):

- Use Explorer only when discovery is the bottleneck.
- Invoke Explorer only if one or more are true:
  - Target files/owners are unclear after quick direct search.
  - The change likely spans multiple packages/domains.
  - Risk/dependency mapping is needed before implementation.
- If Architect already has high-confidence file targets and dependencies, skip Explorer.
- Engineer should only do minimal gap-filling searches required to implement.

## Handoff Protocol

- Issue IDs are the source of truth at every handoff.
- Every stage transition must update the issue before work is passed onward.
- Required handoff statuses:
  - Engineer sets `implemented` when coding is complete and ready for audit.
  - Auditor sets `verified` on pass or `changes_requested` on fail.
  - Diplomat sets `in_review` for PR workflow, then closes the issue on merge/deploy.
- Handoff artifacts must include issue IDs in notes, PR descriptions, and release communication.

## Code Principles Enforcement

- All agents MUST follow the project's code principles for implementation and audit decisions.
- Engineer MUST self-check the code principles PR checklist before marking work as implemented.
- Auditor MUST verify the same checklist and explicitly report any approved exceptions or violations.

## Git Conventions

- Use `feature/*` branches for feature, task, and chore work.
- Keep commits focused and atomic.
- Write commit messages that explain *why*, not *what*.

## Changesets

When a project uses [changesets](https://github.com/changesets/changesets) for versioning:

- Engineer MUST include a changeset file (`.changeset/*.md`) whenever a publishable package changes.
- Engineer MUST NOT add a changeset when changes are limited to non-publishable surfaces (docs-only, CI/workflow-only, tests-only with no runtime impact, or internal-only changes).
- Engineer bump guidance:
  - `patch`: backward-compatible bug fixes, small internal improvements, dependency updates with no API change.
  - `minor`: backward-compatible new features or additive API surface.
  - `major`: breaking API/behavior changes requiring consumer action.
- Auditor MUST verify that a changeset exists for publishable package changes and that the bump type matches the actual impact.
- Auditor MUST verify no-changeset cases are correctly justified when no publishable package surface changed.

## Session Completion

When ending a work session, complete ALL steps:

1. File issues for remaining work.
2. Run quality gates if code changed (tests, linters, builds).
3. Update issue status — close finished work, update in-progress items.
4. Push to remote — work is NOT complete until `git push` succeeds.
5. Verify all changes committed AND pushed.
6. Hand off — provide context for next session.
