# The 12 review dimensions

Use these as investigation prompts, not mandatory technologies or design choices.
For each dimension inspect relevant implementations, callers, tests, and config;
cite evidence and limits in the coverage matrix. Adapt to the language/stack:
browser/native UI, CLI, library, backend, worker, embedded, or infrastructure.
Mark irrelevant subchecks as such without marking the whole dimension inapplicable
unless its entire concern is outside scope. Cross-reference shared findings.
Prioritize the workflow's reachability/completeness checks for important new
features. These risks apply regardless of authorship. Use its inactive-code
dispositions and evidence limits, not search absence or textual claims as proof.

## 1. Architectural boundaries and dependency direction

- Compare architecture docs/ADRs with imports, package exports, service wiring,
  entrypoints, runtime dispatch, and deployment topology.
- Trace dependencies across domain/application/adapters or the project's chosen
  model: cycles, forbidden coupling, leaking internals, ownership and test seams.
- Examine cross-service protocols, trust boundaries, synchronous/asynchronous
  flows, shared libraries, and whether boundaries serve actual change patterns.
- Check whether build-time isolation matches runtime isolation; do not prescribe
  microservices, layering, or dependency injection without an evidenced need.
- Trace bidirectionally from runtime entrypoints to implementation and back to
  callers, registration, exports, rendering, and consumers: routes, UI callbacks,
  plugins, and services. Check dead/unreachable/orphaned/unregistered/unexported/
  unrendered/unconsumed code and obsolete implementations. Account for generated,
  dynamic, reflection, and public API entrypoints; search absence is not proof.
- Detect parallel implementation drift: does the authoritative production path
  still use the old implementation while a new duplicate exists only in isolation?

## 2. Cohesion, maintainability, and complexity

- Assess file/module responsibility, coupling, duplication with divergence risk,
  control-flow complexity, naming, discoverability, and change locality.
- Apply project file/function/nesting limits and approved exceptions; explain
  impact rather than treating a style preference as a correctness defect.
- Identify hidden temporal coupling, implicit global context, oversized interfaces,
  dead paths, brittle abstractions, and comments/docs that misstate invariants.
- Consider language idioms and whether extraction would clarify responsibility
  or merely add indirection; avoid gratuitous rewrites.
- Apply SOLID contextually: SRP (responsibility/change reasons), OCP (safe extension
  versus repeated invasive edits), LSP (substitutes preserve behavioral contracts),
  ISP (consumers need not depend on unrelated capabilities), DIP (policy is not
  unnecessarily coupled to concrete infrastructure). Use language-appropriate
  modules/functions as well as objects; do not mandate OO, interfaces, or layers.
- Apply DRY to knowledge duplication and divergence risk, not every repeated line.
  Look for unnecessary scaffolding, unused extension points, copied utilities,
  and obsolete implementations; abstraction needs current evidence, not promises.

## 3. Behavioral correctness, UI, and accessibility

- Trace requirements through happy/edge/failure paths, input limits, ordering,
  numeric/time/encoding semantics, empty states, and platform differences.
- Where UI exists, inspect interaction state, validation feedback, loading/error
  behavior, routing, responsive layout, localization, and hydration consistency.
- Check accessible names/native semantics, labels, keyboard navigation, focus
  management, announcements, contrast/motion where evidence is available.
- Distinguish actual user failures from cosmetic preferences; static inspection
  alone cannot establish visual or assistive-technology behavior.
- For every important new feature check Reachability -> behavior -> failure
  handling -> production-path tests. Detect false completeness: stubs, no-op
  handlers, hardcoded success, mock/temporary adapters, or rendered controls whose
  callbacks never reach real behavior. Distinguish legitimate fixtures from shipped
  placeholders and verify the selected path; static evidence is allowed with limits.

## 4. APIs, contracts, and type safety

- Review public exports, request/response/event schemas, protocol guarantees,
  serialization, runtime validation at trust boundaries, and version compatibility.
- Check nullability, exhaustiveness, casts/unsafe escapes, generic soundness,
  error contracts, and generated declarations versus actual runtime behavior.
- Examine consumers, SDKs/CLI flags, pagination, idempotency contracts, and breaking
  changes; adapt compile-time checks to typed or dynamic language semantics.
- Separate trusted internal invariants from untrusted input; do not require
  redundant parsing or ban all casts without tracing their assumptions.
- Verify potentially hallucinated APIs, config keys, and version assumptions against
  installed versions, manifests/lockfiles, actual exports/types, and available
  authoritative docs. Ask before network access; disclose offline/version limits.
- Inspect unsafe casts, `any`, and silenced type errors for their reasons and impact,
  especially escapes that conceal missing integration or incompatible contracts.

## 5. Data modeling, state, and integrity

- Map schemas, constraints, relationships, identifiers, ownership, invariants,
  transactions, persistence, retention/deletion, and serialization round trips.
- Examine state transitions, derived state, caches/invalidation, source of truth,
  subscriptions/snapshots, optimistic updates, and stale or inconsistent reads.
- Review migrations and historical compatibility as text; consider backfill,
  rollback, partial writes, duplicate delivery, and recovery from corrupt input.
- Check precision, units, timezone, and schema drift; assess shared/mutable state
  according to the runtime's memory and consistency model.
- Trace cross-layer field propagation: validation -> domain -> persistence ->
  response -> UI, including defaults, naming, optionality, read/write symmetry,
  and dropped fields. Passing isolated schema tests does not prove integration.
- Check backward compatibility of persisted data, old clients/readers, mixed-version
  deployments, and rollback; inspect historical shapes without running migrations.

## 6. Security and privacy

- Trace authentication, authorization/tenant isolation, trust boundaries, injection,
  path traversal, deserialization, SSRF, browser origin/session protections, and
  unsafe native operations where applicable.
- Inspect secret handling, crypto usage, least privilege, sensitive logs/telemetry,
  data minimization, consent, retention, and deletion obligations.
- Evaluate threat model, exploit prerequisites, exposure, and defense ownership;
  distinguish reachable vulnerabilities from unconfirmed suspicious patterns.
- Never expose credentials or run exploit probes against live services; report
  redacted locations and safe confirmation options.

## 7. Resilience, error handling, and concurrency

- Follow error propagation/ownership, cancellation, deadlines, retries/backoff,
  partial failure, fallback semantics, and whether failures are silently swallowed.
- Inspect race conditions, locks/atomicity, reentrancy, ordering, task supervision,
  async cleanup, duplicate processing, and idempotency implementations.
- Check resource exhaustion defenses, backpressure, isolation, recovery/restart,
  and external-service outages against documented reliability expectations.
- Adapt to event loops, threads, processes, and distributed delivery; do not
  prescribe retries/error boundaries that amplify failure or hide broken state.
- Detect error camouflage: broad catches, silent fallbacks, swallowed promises,
  and success-shaped responses hiding failed work. Trace caller-visible outcomes
  and distinguish intentional degradation from concealed correctness failures.

## 8. Performance, scalability, and resource lifecycle

- Examine algorithmic costs, query/index patterns, N+1 behavior, allocations,
  serialization, bundle/startup costs, hot paths, and workload growth assumptions.
- Trace bounded queues/caches, memory retention, file/socket/connection lifetimes,
  listeners/subscriptions, timers, workers, and shutdown/unmount/disposal paths.
- Check caching/reference invariants, rendering costs, streaming/batching, and
  contention; justify memoization or optimization with meaningful cost/evidence.
- Separate measured regressions from estimates; propose safe benchmarks with
  representative inputs rather than claiming unmeasured scalability guarantees.
- Verify lifecycle ownership, cleanup and cancellation on success, failure, retry,
  shutdown, and unmount; identify who disposes each resource and unfinished task.

## 9. Testing and verification

- Compare critical flows/invariants to unit, integration, contract, property,
  end-to-end, accessibility, and failure/recovery tests as relevant.
- Review assertion quality, fixtures, isolation, determinism, clock/network mocks,
  coverage blind spots, real adapter boundaries, and flake masking.
- Inspect CI gates, lint/typecheck/build compatibility matrices, test commands,
  hooks, side effects, and whether delivered artifacts match tested sources.
- Run only approved safe existing gates; record exact outcomes and unavailable
  checks. Coverage percentage or green CI alone is not proof of correctness.
- Detect tautological assertions, overmocked tests, helper-only coverage, and tests
  that bypass production dispatch/registration/adapters. For important new features
  link reachability, substantive behavior, and failure handling to production-path
  tests; say when source inspection verifies wiring but execution remains untested.
- Inspect test weakening, skipped tests, deleted assertions, lint overrides, and
  suppressed checks for documented reasons and lost protection; do not infer safety
  from a newly green gate or assume every justified suppression is a defect.

## 10. Dependencies and supply chain

- Inspect manifests/lockfiles, direct/transitive dependency purpose, pinning,
  provenance, supported versions, license obligations, and update policy.
- Review install/build scripts, downloaded executables, generated/vendor code,
  plugin trust, registry configuration, artifact integrity, and reproducibility.
- Distinguish runtime/dev/build exposure and reachability of known advisories
  using available evidence; state advisory freshness and offline catalog limits.
- Do not install packages or run network vulnerability scans without authorization;
  missing audit access is a coverage limitation, not a clean bill of health.
- Flag unused dependencies or dependency-heavy scaffolding against actual build,
  generated, dynamic, and runtime use; recommend confirmation before removal.

## 11. Observability and operations

- Trace logs, metrics, traces, correlation IDs, health/readiness signals, alerts,
  and whether operators can diagnose critical failures without exposing data.
- Check signal cardinality/cost, useful error context, sampling, instrumentation
  failure behavior, and consistency with reliability objectives if defined.
- Review runbooks, support/debug paths, backup/restore evidence, incident recovery,
  operational ownership, and local tooling appropriate to libraries/CLIs.
- Do not assume every project needs a telemetry platform; identify actual gaps in
  diagnosability. Do not call production endpoints to establish health.

## 12. Deployment, configuration, and evolution

- Inspect config sources/precedence, defaults, validation, environment separation,
  feature flags, secret injection, build/package outputs, and runtime compatibility.
- Trace release automation, infrastructure policy, rollout/rollback, upgrade order,
  schema/protocol evolution, and forward/backward compatibility during mixed versions.
- Check reproducible builds, artifact contents/exports, documentation drift,
  deprecation strategy, and supported platform/runtime/version matrices.
- Consider maintenance/extension paths and migration risks relative to actual
  requirements; inspect scripts without deploying, applying config, or migrating.
- Trace config values through consumers to observable effects, not just declarations
  or parsing; verify feature flags select the intended implementation. Reconcile
  misleading docs and agent completion claims with reachable, shipped paths and
  real test evidence, distinguishing verified facts from inferred behavior.
