# knuth/

Answers to Knuth's own exercises, one directory per section. The rules are in
`AGENTS.md`; this file only describes the layout.

```
knuth/
  1.2.1/                  one Odin package per section, `package s1_2_1`
    003.md                exercise 3: the written answer
    003.odin              exercise 3: code, if the exercise asks for a program
    003_test.odin         its test, written first
    algorithm_e.odin      an algorithm from the section text, not an exercise
```

Exercise numbers are three digits so that files sort correctly: some sections
have hundreds of exercises.

## Answer file

Statements and Knuth's answers are never transcribed (the repository is
public). The heading carries the reference and the rating as printed.

```markdown
# §1.2.1 ex. 3 [M20]

## Attempt

Your own work. Math in `$…$` / `$$…$$`. Committed before the answer is read.

## What I missed

Added in a second commit, after reading the answer in the back of the book.
In your own words: what the answer does that the attempt did not, and why.
"Nothing" is a valid entry.
```
