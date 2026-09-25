# AGENTS.md

Coding guidelines for this repository. This file supersedes the global
`~/.claude/CLAUDE.md` wherever the two disagree. It is written for both Nils and
any agent working here.

This is a *learning* project. Nils is working through Knuth's *The Art of
Computer Programming*, Volumes 1 to 4B. Getting through the books fast is not the
goal. The goal is to understand what each section teaches well enough to explain
it back. That is why things a library already does get hand-written here.

## Project

Exercise answers and Odin implementations for TAOCP, worked through linearly
from Vol 1 to Vol 4B. Math answers are Markdown with LaTeX; algorithms are Odin
translations of Knuth's MIX programs and step-by-step descriptions. See
`PLAN.md` for the milestones (one per chapter) and the decisions already made,
and `PROGRESS.md` for what Nils has learned so far.

## Layout

* `knuth/<section>/` holds answers to Knuth's own exercises, one Odin package
  per section. The file format is described in `knuth/README.md`.
* `exercises/<Mn>-<topic>/` holds lessons chapters: drills, probes and builds
  written for a topic, each linking the Knuth exercises it uses.
* `docs/notes/` holds the notes that `learning` issues end in.

## Public repository: Knuth's text stays in the books

The repository is public, and TAOCP is copyrighted.

* Exercises are referenced by section, number and rating, for example
  `§1.2.1 ex. 3 [M20]`. Their statements are never transcribed.
* Knuth's answers are never transcribed either. A "what I missed" note is
  written in Nils's own words.
* Knuth's algorithms are implemented from their step descriptions. The
  implementation is ours, and a comment cites the algorithm, for example
  `Algorithm 1.1E`.

## Exercise workflow

* Exercises are chosen per section when the section starts, and listed as
  checkboxes in that chapter's milestone issue.
* **The attempt is committed before the answer in the back of the book is
  read.** Then the answer is read and a "what I missed" section is added in a
  second commit. The diff between the two is the honest record of the attempt.
* An agent never solves a Knuth exercise or fills in an attempt. Helping is
  narrowing the problem, pointing at the paragraph that matters, and explaining
  a mechanism when Nils asks. See the lessons skill, "Helping without solving".

## Teaching

* Before writing code in a topic Nils has not yet reached `implemented` in
  `PROGRESS.md`, explain the fundamentals first: what the data looks like, why
  this representation, what the machine actually does.
* At `implemented` or above, just implement it, and point out only what is
  surprising.
* Never hand over code that Nils cannot explain back. If a step needs a trick, the
  trick gets explained.
* Update `PROGRESS.md` when a topic's level changes.

## Comments

* Every file starts with a comment saying what the file does and why it exists.
  For an exercise answer, that includes the exercise reference.
* Comments explain what happens **outside** the code: decisions and the reasons
  for them, postponed work, known problems, references to the book (section,
  algorithm, equation number) and to papers.
* Comments do not restate what the code plainly says, and they never record
  history ("changed X to Y", "previously did Z"). Git holds history.
* Phase comments inside long procedures are encouraged. For a Knuth algorithm,
  one phase per step (`// M1. Initialize.`) keeps the code checkable against
  the book.

## Structure

* Data layout is the primary structuring mechanic. Design the data first, then
  the code that transforms it. Knuth's node layouts (fields, links, tags) are
  the starting point, not something to abstract away.
* Long procedures split into phases by comments are **not** a code smell.
* A function is extracted when it is genuinely reused or genuinely independent,
  not to hit a line count.
* No shared library package until a second section needs the same code. Then
  pull out what the two actually share.
* No inheritance hierarchies, no interfaces for a single implementation.

## Naming

* Name things for what they do in the domain, right now. Knuth's names (`LLINK`,
  `RLINK`, `AVAIL`) are the domain here and may be kept, in Odin case.
* No names based on implementation history or hypothetical future uses.

## Performance

* Performance is a feature, and every performance decision is justified either by
  a measurement or by an explicitly named trade-off. How cost is measured is
  open in #10 and recorded in `PLAN.md` once decided.
* "This is faster" without a number is not an argument. Where Knuth gives an
  exact cost formula, the measurement is compared against it.

## Libraries

Libraries exist to save us work on topics we have deliberately chosen not to
spend time on. Using one is allowed only when we understand the topic it covers.
In this project nearly everything is the topic, so the table is strict.

Before adopting any library, the agent provides a short reading pointer (the TAOCP
section, a paper, or a reference implementation) for the underlying topic. Nils
reads enough to get the gist, and then decides. The decision and its reason are
recorded in `PLAN.md`.

### Standard library tiers

**Tier 1 — plumbing, free to use:** `fmt`, `testing`, `os`, `strings`, `strconv`,
`time`, `log`, `mem.Tracking_Allocator`.

**Tier 1 exception, until M3:** `core:math/rand` may generate *test inputs*, with
the seed fixed and recorded in the test. Agreed with Nils on 2026-09-25, because
Chapter 3 teaches random number generation and nothing before it should wait for
that. Once M3 is done, tests use our own generator instead.

**Tier 2 — topic fundamentals, hand-written first:** everything in
`core:container/*` (queues, priority queues, AVL and red-black trees,
intrusive lists), `core:slice` sorting and searching, `core:math/big`,
`core:math/bits`, `core:math/rand` outside test inputs, `core:hash`, and the
allocators in `core:mem` other than the tracking allocator. The stdlib version
may be adopted *after* the hand-written one works, with a measured or explained
reason and a line in `PROGRESS.md` under Learning notes.

**Tier 3 — not used in answer code:** `vendor:*` and any third-party package.

**Anything not listed:** stop and ask Nils. Record the answer here.

## Testing

* Tests are written before the implementation.
* The unit under test is the algorithm as a whole, not its helper procedures.
* Expected values come from somewhere independent of the code under test:
  * a brute-force enumeration for small `n` checked against the closed form or
    the fast algorithm
  * a value table in the book
  * OEIS
  * Knuth's answer, once the attempt is committed
  Each test cites its source.
* Tests are deterministic and reproducible. Seeds are fixed and recorded.
* Test output must be clean. Expected error output is captured and asserted, not
  ignored.
* Never delete a failing test. Raise it with Nils.
* `./build.sh test` runs every package that has a `*_test.odin`.

## Version control

* Commit often, in small steps, with the reason for the change in the message.
* Work happens on a branch per milestone (`m1-basic-concepts`).
* An attempt and its "what I missed" note are separate commits.
* Never skip or disable a hook.

## Working agreement

* Nils has a Bachelor's degree in computer science and comes from web, cloud and
  backend development. Degree-level material is familiar but has to be revived
  to Knuth's standard. Abstraction-first instincts get challenged with concrete
  reasons, not waved through.
* Push back on bad ideas. Say plainly when something is not known instead of
  inventing technical details. That includes section numbers, exercise numbers
  and ratings: check the book or ask.
* Ask rather than assume when a decision is Nils's to make.

## Learning tasks

Reading beyond TAOCP itself is tracked as separate GitHub issues labelled
`learning`, not as side notes inside milestone issues. Examples are Odin
fundamentals and a companion text for a math-heavy section. Each one names its
sources and ends in a note under `docs/notes/`. A `learning` issue blocking a
milestone is closed before that milestone starts.
