# PLAN.md

What we are working through, in what order, and which decisions are already
settled. Written 2026-09-25 after a design interview. Coding guidelines live in
`AGENTS.md`; learning state lives in `PROGRESS.md`.

## Goal

Work through *The Art of Computer Programming*, Volumes 1, 2, 3, 4A and 4B.
Each section's exercises are chosen and answered, and the algorithms are
implemented in Odin. Four learning targets:

1. **Algorithm analysis.** Exact and average-case analysis with sums,
   recurrences, generating functions and asymptotics: the M-rated work.
2. **Data structures.** Lists, trees, storage allocation, hashing and
   search structures, hand-written in Odin and measured.
3. **Combinatorial search.** Vol 4A and 4B: bitwise tricks, BDDs,
   generation of combinatorial patterns, backtracking, dancing links, SAT.
4. **Machine-level thinking.** How an algorithm's cost maps onto a real
   machine: Knuth's MIX time and mems against what x86-64 actually does, plus
   the arithmetic and random-number chapters of Vol 2. How cost is measured is
   open in #10.

## Settled decisions

* **Language: Odin** (`dev-2026-09` installed). It is the same language as the
  chess project, and it is data-oriented without hiding the machine. Stdlib use
  is restricted by the tier table in `AGENTS.md`, because nearly every
  container in it is a TAOCP topic.
* **MIX is read, not run.** Knuth's MIX programs are read and translated into
  Odin. Exercises that are only about writing MIX code are skipped. A MIX
  emulator is not a milestone: the target is the algorithms and their costs,
  not the 1960s machine.
* **Linear order, Vol 1 to 4B.** Later volumes cite §1.2 and Chapter 2
  constantly. Starting anywhere else means backfilling those sections in
  fragments.
* **One milestone per chapter.** Chapter 7 spans two books, so it is split into
  M7 (Vol 4A, up to §7.2.1) and M8 (Vol 4B, §7.2.2). Each book then maps to at
  least one milestone, and M8 includes 4B's own opening mathematical
  preliminaries.
* **Exercises are picked per section**, with no global rating cutoff. Sections
  differ too much for one rule; a cutoff of 25 would skip the heart of §1.2.
  The chosen list goes into the milestone issue as checkboxes.
* **Attempt before answer.** The attempt is committed before the answer in the
  back of the book is read, then a "what I missed" note follows in a second
  commit. The diff between them keeps the record honest.
* **Math answers are Markdown with `$…$` LaTeX**, which GitHub renders. There
  is no local typesetting toolchain to maintain.
* **Public repository.** Knuth's exercise statements and answers are never
  transcribed, only referenced by section and number. See `AGENTS.md`.
* **Layout: `knuth/` for Knuth's exercises, `exercises/` for lessons
  chapters.** The book's structure and the teaching structure are different
  axes. A lessons chapter links the Knuth exercises it uses instead of owning
  them.
* **Build: `build.sh` calling `odin` directly, tests with `core:testing`.** No
  Nix. There is no platform code here, and the only dependency is the Odin
  compiler.

## Postponements — deliberate, revisit explicitly

* **No shared "taocp" library package.** A list or tree written for §2.2 is
  shaped by §2.2's exercises. Extract shared code when a second section
  genuinely needs the same thing, not before.
* **No MIX or MMIX emulator.** Reopen if the answer to #10 turns out to need
  exact MIX timings that counting cannot provide.
* **No Vol 4 pre-fascicles or Vol 4C material.** The scope is the five books
  in the set. Reopen after M8.
* **No global exercise-rating policy.** Reopen if per-section selection turns
  into skipping everything above 20.

## Open decisions

Tracked as issues. The Gates column says what must not start before the
decision is settled.

| Decision | Issue | Gates |
|---|---|---|
| Cost model: instrumented counts vs machine measurement | [#10](../../issues/10) | M1 from §1.2.10 on |

## Milestones

Exercise choices and step detail live in the GitHub issues, which are the
working list. This file keeps the decisions and the reasons for them, which
issues are bad at holding.

| | Milestone | Issue | Gated by |
|---|---|---|---|
| M0 | Setup | [#1](../../issues/1) | |
| M1 | Ch 1 Basic Concepts (Vol 1) | [#2](../../issues/2) | #11; #10 from §1.2.10 |
| M2 | Ch 2 Information Structures (Vol 1) | [#3](../../issues/3) | M1 |
| M3 | Ch 3 Random Numbers (Vol 2) | [#4](../../issues/4) | M2 |
| M4 | Ch 4 Arithmetic (Vol 2) | [#5](../../issues/5) | M3 |
| M5 | Ch 5 Sorting (Vol 3) | [#6](../../issues/6) | M4 |
| M6 | Ch 6 Searching (Vol 3) | [#7](../../issues/7) | M5 |
| M7 | Ch 7 part 1, to §7.2.1 (Vol 4A) | [#8](../../issues/8) | M6 |
| M8 | Ch 7 part 2, §7.2.2 (Vol 4B) | [#9](../../issues/9) | M7 |

Order: numeric, as settled above.

Issue labels: `milestone` for a chapter, `decision` for open design questions,
`learning` for reading outside TAOCP that must be done first. A `learning`
issue blocking a milestone is closed before that milestone starts.

A milestone's sections and exercise choices are written out when the
milestone starts, not before. Choices written today for M5 would be
invalidated by what M1 to M4 teach us. M1 already lists its sections because it
is next.
