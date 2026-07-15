---
name: design-judgment
description: >-
  Check design and architecture decisions against Decision Quality and a catalog
  of recurring design-judgment failure patterns. Use when choosing an
  architecture, selecting a library or framework, deciding an implementation
  approach, weighing a trade-off, or reviewing whether a change is "done" — i.e.
  whenever a non-trivial design judgment is being made, not just when explicitly
  asked. The point is to notice which failure pattern the current decision may be
  falling into, because an agent does not carry a built-in judgment axis.
---

# Design Judgment

Source: [Decision Quality と設計判断失敗パターン (kawasima)](https://scrapbox.io/kawasima/Decision_Quality_%E3%81%A8%E8%A8%AD%E8%A8%88%E5%88%A4%E6%96%AD%E5%A4%B1%E6%95%97%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)

Frame based on Decision Quality (DQ): a decision's overall quality is capped by
its weakest of six elements — Frame, Alternatives, Information, Values, Sound
Reasoning, Commitment to Action. Separate the *decision* from its *outcome*: a
sound decision can still turn out badly, and vice versa. This skill turns the DQ
lens into a concrete self-check for design work.

Most recurring design-judgment failures come from mishandling two DQ elements:
**Frame** and **Values**. Model Values as eight **evaluation axes**, and model a
Frame error as a **dominant-axis mismatch** (`intended dominant axis ≠ adopted
dominant axis`). The other four DQ elements show up as secondary symptoms.

## How to use this

When making a design judgment:

1. **Name the dominant axis.** Pick the single axis that matters most for *this*
   decision (`dominant criterion`). Force it to one. Then decide the **secondary
   conditions** — axes you won't optimize for but must keep at a minimum level.
2. **Check for a dominant-axis mismatch.** Ask: what does the situation actually
   call for, versus what am I optimizing for? (Incident response but starting an
   ideal long-term redesign; core-system replacement but picking on short-term
   ease; a security issue but judging on UX alone; a PoC but demanding
   production-grade quality; a production feature but building at PoC speed.)
3. **Scan the failure patterns below.** Each lists the axis bias it comes from
   (`↑` over-weighted, `↓` under-weighted, `unassessable` = information to judge
   the axis is missing). Notice which pattern the current decision resembles.
4. **If a pattern fits, either fix the framing or justify it explicitly** using
   that pattern's "when it's deliberate" conditions — and record the required
   caveats (deadline, rollback condition, follow-up ticket, etc.).

An agent tends to emit plausible alternatives and pros/cons but does not notice
*which failure pattern it is currently in*. Holding that awareness is the whole
job of this skill.

## Evaluation axes (Values)

Cross-domain vocabulary for design criteria. `dominant axis` = the one most
weighted now; `secondary condition` = a minimum bar to keep.

- **Purpose fit** — does it serve the actual goal? (Value-Focused Thinking)
- **Constraint fit** — does it meet functional / non-functional requirements?
- **Feasibility (technical)** — can it work at all, technically?
- **Feasibility (organizational)** — can *this* org's skills and staffing run,
  maintain, and evolve it? SIer work often overlooks this, or overrates it and
  biases decisions downward.
- **Quality impact** — the -ilities (maintainability, operability, evolvability,
  …) per ISO/IEC 25010.
- **Time effect** — short-term vs long-term; technical debt and real options.
  Read short and long as separate time phases (the same axis can be `↑` short
  and `↓` long).
- **Risk / uncertainty** — uncertainty and risk evaluation.
- **Consistency** — architectural consistency (record decisions via ADR).
- **Agreeability** — Commitment to Action; can stakeholders commit to it?

## Failure patterns

Each pattern: the axis bias, typical instances, and when choosing it is
legitimately deliberate.

### Reinventing the wheel (車輪の再発明)
Deviating into a custom implementation when a standard solution exists.
Bias: Purpose fit↑, Consistency↓, Feasibility(tech)↓, Quality(maintainability)↓.
Examples: rolling custom token auth instead of a standard auth library; pushing
DB-constraint-expressible rules into app-side `if`s; always returning HTTP 200
with a custom error code; a `while(true)+sleep` scheduler instead of
`@Scheduled`/Quartz.
Deliberate when: the standard fails a primary constraint (perf/security/contract)
shown by measurement or a known limitation; or the differentiation clearly
outweighs the deviation cost.

### Cracking a nut with a sledgehammer (牛刀をもって鶏を割く)
Bias: Purpose fit↑, Feasibility(tech)↓, Time(short)↓, Quality(operability)↓,
Agreeability↓.
Examples: 4-way microservices for a 30-user internal admin screen; event
sourcing for a 4-state flow; Kafka + consumer groups for 500 CSV rows/day; a
generic workflow engine for a single-step approval; Spark + K8s CronJob for a
monthly batch; a rule engine for "required / length / regex" checks.
Deliberate when: a PoC whose *purpose* is trying that stack; the roadmap
commits to reaching that scale within 1–2 years; or the org already runs that
platform so the operational increment is small.

### Design beyond your means (身の丈に合わない設計)
Technically desirable, but ignores the operating org's skills, staffing, and
on-call. Feasibility(tech) met, Feasibility(org) unmet.
Bias: Feasibility(tech)↑, Feasibility(org)↓, Quality(operability)↓, Risk↓.
Examples: multi-region needing night on-call for a team with none; production
K8s/Kafka with no operators; forcing trunk-based daily releases on a weekly-
release team; multi-master/sharding with no DBA; SLO/error-budget with no SRE
to measure it; a CD pipeline onto a manual approval process.
Deliberate when: a skill-acquisition plan and migration schedule are agreed
(state the training window and external-support deadline); or vendor/external
SRE ops are planned with an in-sourcing date.

### Burned by soup, blowing on cold dishes (羹に懲りて膾を吹く)
Underrating the org's skills and picking a technically inferior option;
"we can't maintain that" rejecting standard solutions or apt abstractions.
Bias: Feasibility(org)↓, Risk↑, Quality(maintainability)↑, Quality(evolvability)↓,
Time(long)↓, Consistency↓.
Examples: banning Stream/Lambda for plain for-loops; banning `Optional` and
pushing `null` checks to callers; staying on JS where TS fits; banning
`rebase`/`squash`; refusing CI as "un-maintainable" and keeping manual release.
Deliberate when: a time-boxed stopgap with no feasible skill-acquisition plan
(state deadline and migration condition); or a short-lived system where training
cost doesn't pay off. Note this deliberately takes on debt and denies a
skill-growth opportunity.

### Ad-hoc patching (場当たり対応)
Code compiles short-term, so the judgment step is skipped.
Bias: Time(short)↑, Consistency↓, Quality↓, Time(long)↓.
Examples: swallowing an error to advance the screen; adding logic to a
Controller against existing separation; screen-side-only checks for domain
rules; a bare `if (x != null)` to dodge an NPE; changing the test expectation to
match the implementation.
Deliberate when: incident first-response where stopping the blast radius is top
priority — always leave apply-time, rollback condition, and a permanent-fix
ticket. Otherwise there is no good reason.

### Jumping to conclusions (早合点)
Confusing "command ran" / "test went green" / "200 returned" with the goal being
met (execution hallucination).
Bias: Purpose fit unassessable, Consistency↓, Risk↓.
Examples: treating `200 OK` as "it worked" while the side effect never happened;
"saved" when the INSERT was silently rejected; "success" when the external side
never accepted it; a batch "completed" over 0 rows; "logging done" from a lone
`console.log`; a migration that "succeeded" but skipped a missing table.
Deliberate when: none — verify the *business success condition*, not the return
value. If only smoke-testing, state that it's unverified and ticket the real
condition.

### Jumping the gun (見切り発車)
Starting to implement before the spec is settled (external absence), or with no
implementation strategy (internal absence). Both defer judgment until something
runs.
Bias: Purpose fit / Constraint fit / Quality unassessable, Time(short)↑,
Agreeability↓.
Examples: generating screen/API/DB on a vague requirement; building "something
that works" with no acceptance criteria; validation with undefined business
rules; a Redis cache layer before knowing the target volume/latency.
Deliberate when: a throwaway spike for spec exploration (note delete-by date and
owner); or it's pre-agreed that requirements can't settle without running it
(redo the real implementation on a separate branch).

### Premature abstraction (早すぎる抽象化)
Bias: Quality(changeability)↑, Purpose fit↓, Feasibility(tech)↓, Time(short)↓.
Examples: a Strategy pattern with one implementation; a generic form renderer
for one screen; a config table + admin screen with no plan to add settings; a
custom DSL for two search fields; a generic CSV import framework for one format.
Deliberate when: none — abstract after the change point is observed twice (Rule
of Three). Exception: abstraction itself is the learning goal — keep it as a
spike, out of production code.
Warning sign: the words "flexibility" / "extensibility" — usually overrated
changeability.

### Retrofitting constraints (制約の後付け)
Missing that "the constraint *is* the core." Permissions, history, audit,
idempotency, and state transitions belong in the data model and use cases from
the start, not bolted on.
Bias: Constraint fit↓, Risk↓, Quality↓.
Examples: build CRUD then add permissions; build updates then add audit logs;
build delete then realize a history requirement; build sync then add
resend/idempotency; build address update then realize past-invoice reissue.
Deliberate when: none for new design — embed constraints from the start. Adding
to already-running code is a different problem: add a constraint-satisfying path
and deprecate the old one as a staged migration with a stated end condition.

### Deference to the past (過去への忖度)
Picking a maximally conservative, complex solution without checking who really
uses the compatibility requirement and how far it must hold. The time-mirror
sibling of "counting unhatched extension points."
Bias: Constraint fit↑, Purpose fit↓, Feasibility(tech)↓, Quality(maintainability)↓,
Time(short)↓.
Examples: running old and new endpoints in parallel forever; accreting
`is_deleted`/`is_archived`/`is_suspended` instead of dropping columns; a
`version`-branching parser that bloats each release; keeping deprecated config
keys with a bridge; padding around staying on an old framework version.
Deliberate when: a public/contract API with external users you can't force to
migrate; or a legal/audit duty to retain past formats. Either way state the
*scope kept*, *deadline*, and *retirement plan* — never an open-ended guarantee.
Note: an agent takes "don't break existing code" as a strong constraint; told to
"keep existing tests passing" it picks the most complex all-passing solution
without questioning the tests' intent.

### Completion in name only (名ばかりの完了)
Acceptance criteria exist but aren't decomposed into judgeable granularity —
"displays correctly", "logs appropriately" — so neither implementer nor reviewer
can decide it's done. (Jumping the gun = criteria absent; this = criteria present
but unverifiable.)
Bias: Agreeability↓, Purpose fit unassessable, Quality unassessable.
Examples: "displays correctly"; "error when necessary"; "fast within normal
range"; "same as current"; "logs appropriately"; "easy for users".
Deliberate when: none — decompose completion into concrete input, state,
expected result, and exception conditions before starting.

### Boundary-crossing implementation (越境実装)
Bias: Consistency↓, Quality(maintainability)↓, Risk↓.
Examples: an order cap check in the Controller instead of the domain; an
"admin sees delete" check inside a Blade/JSX template; a screen-driven
`ORDER BY CASE …` in SQL; a "notify Slack and stop" embedded in a night batch;
an `OrderDto` carrying both JPA `@Column` and view `@JsonFormat`.
Deliberate when: the existing structure has a bug and fixing the real
responsibility isn't affordable now (allow the crossing as a stopgap with
rollback condition + follow-up ticket); or a framework limitation forbids the
proper location (leave the reason as a comment).

### Correct in principle, deaf to local custom (郷に従わぬ正論)
Bias: Consistency↓, Purpose fit↓, Feasibility(tech)↓.
Examples: unifying to `RuntimeException` where existing code distinguishes
checked business exceptions; logging everything at `info` against a set policy;
`@Transactional` on a Controller against a service-layer convention; calling
`java.time` directly where a project date utility is the rule; JUnit 5
`@ExtendWith` in a JUnit 4 `@Rule` codebase; dropping a generic Spring Boot
example into an EAP/Jakarta EE constraint.
Deliberate when: the existing convention is obsolete and a convention change can
pass review (propose the update and the new code together); or the convention has
a safety/security problem (align new code and note migration + old-code handling).
Note: this comes from filling gaps with "generic web dev" knowledge — it won't
shrink unless the agent is forced to read the project's existing code.

### Re-implementing without looking next door (隣を見ない再実装)
Creating a new thing that duplicates an existing function/class/utility without
reading it (Comprehension Debt).
Bias: Consistency↓, Quality(maintainability)↓, Agreeability↓.
Examples: `formatDate`/`dateToString`/`toIsoDate` growing in parallel beside a
shared date util; raw SQL in a Service against a Repository convention;
re-writing shared validation locally on a new screen; per-Controller authz where
it's centralized in a Decorator/Interceptor; raw `BigDecimal` beside an existing
`Money` class; re-defining a constant that lives in `Constants.java`.
Deliberate when: the existing implementation has a hard constraint
(perf/compat/frozen call sites) making a local variant cheaper (note its
retirement plan); or its responsibility has sprawled and the new part is an
intentional split (say so in a comment).
Note: **before writing, search for an existing thing with the same role.** An
agent reads only around the pointed-at spot; without this, near-duplicate
functions multiply.

### Dependencies on sand (砂上の依存)
Generating calls to non-existent libraries / functions / argument signatures /
methods (package hallucination) — from stale training data or confusing similar
libraries.
Bias: Feasibility(tech)↓, Risk↓, Constraint fit↓.
Examples: importing a non-existent package (slopsquatting risk); calling a
removed method like `df.append(other)`; passing a plausible-but-unreal arg like
`retry=3`; mixing similar libraries' APIs (`lodash`/`underscore`,
`moment`/`dayjs`); an invented in-house util inferred from naming; accessing a
non-existent typed property and forcing it through with `@ts-ignore`.
Deliberate when: none — for new libraries/APIs, confirm existence against primary
sources (official docs / source) and confirm by running. Assume nothing works
until doc-reference and execution both check out.

### Counting unhatched extension points (取らぬ狸の拡張点)
Adjacent to premature abstraction; distinguish by:
premature abstraction = the change point has *never been observed once*; this =
the future change is *only spoken of*, with no time, owner, or benefit attached.
Bias driver differs too: premature abstraction is overrated *changeability*;
this is overrated *Time(long)*.
Bias: Time(long)↑, Time(short)↓, Feasibility(tech)↓, Risk↓.
Examples: an abstract DAO for "maybe multiple DBs someday"; a generic
notification base for "maybe SMS/LINE later"; Drools for "maybe more rules";
routing every label through message resources for "maybe i18n later"; a payment-
provider abstraction for "maybe another provider" — none tied to who realizes it
when.
Deliberate when: the roadmap ties a change to a time and owner (allow extension
points only for committed future changes); or the cost of inserting the change
point later is structurally extreme (public API, persisted-data schema) so
reserving room up front is rational. Otherwise abstract when the change is
observed.
