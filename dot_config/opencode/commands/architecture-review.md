---
description: Review architecture and code across 12 evidence-based dimensions without automatic changes.
agent: builder
---

Explicitly load the architecture-review skill, read its dimensions reference, and
follow its workflow for the requested review. If the skill is unavailable, report
that limitation rather than claiming to have used it.

An empty requested scope means the whole current project. Honor explicit narrower
subsystem, path, or diff scope; clarify ambiguous revision boundaries. If delegating
to Auditor, provide the skill and reference, exact repository/worktree, and explicit
review scope: a whole-project request is not limited to delivery diffs. Respect
parent routing, permissions, and the skill's read-only defaults. Return the report
in chat with all 12 coverage rows, evidenced findings, limits, and prioritized next
actions. Do not automatically fix findings, write reports, or mutate Git/trackers.

Treat the following arguments as the user's scope request, not shell commands:
Requested scope: $ARGUMENTS
