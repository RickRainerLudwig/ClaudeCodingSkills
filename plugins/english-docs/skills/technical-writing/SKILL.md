---
name: technical-writing
description: Write or revise technical documentation in English, such as READMEs, user and developer manuals, architecture documents, API documentation, code comments and website texts. Use when creating or rewriting such texts, or when asked to improve their style, clarity or structure.
---

# Technical Writing

## Language and readers

- Use US English (spelling, vocabulary, date and number formats), also when existing texts use another variant.
- Write in plain language. Many readers of the documentation and source code are not native English speakers:
  prefer common words over rare ones ("use" instead of "utilize", "start" instead of "commence"), avoid idioms,
  phrasal verbs with unclear meaning, and wordplay.
- IT jargon is fine, as the readers are developers: "repository", "build", "dependency injection" need no
  explanation.
- Avoid jargon of the domain the software is for (e.g. finance, medicine, logistics), as developers do not
  necessarily know it. If a domain term is needed, explain it at its first use, or link to a glossary.
- Explain every abbreviation at its first use, e.g. "Domain-Driven Design (DDD)", in each document. Well-known
  IT abbreviations such as API, URL or HTML are exempt.

## Style

- Write for the reader: state who the text is for and what they can do after reading it.
- Lead with the most important information. One topic per paragraph, the key statement first.
- Use short sentences and active voice: "The build creates the package", not "The package is created by the build".
- Use the imperative for instructions: "Run `npm install`", not "You should run `npm install`".
- Use one term per concept, consistently. Do not vary terms for elegance; readers assume a new word means a new
  thing.
- Prefer concrete statements over vague ones: "The build takes about 2 minutes", not "The build is fast".
- Avoid filler ("basically", "simply", "just", "in order to").

## Structure

- Use headings that tell the reader what the section contains; task-oriented headings ("Install the plugin")
  work best for instructions.
- Use numbered lists for steps in a fixed order, bullet lists for unordered items, tables for comparisons.
- Put commands, file names, identifiers and values in code formatting.
- Give an example for each non-obvious concept.

## Source code documentation

Code comments and API documentation describe the intention, not what the code does: the code itself already
shows what it does. Explain why the code exists, what it is meant to achieve, and why it is done this way.

- Bad: `// Retry the request three times.`
- Good: `// The payment service drops some requests under load. Three attempts cover this without hiding real
  outages.`

For classes and methods, document the purpose, the contract (preconditions, results, errors) and non-obvious
decisions, not a step-by-step description of the implementation. A comment that only repeats the code is removed.

## Checklist before finishing

- Does every section serve the stated reader and purpose?
- Is it US English throughout, and are terms used consistently?
- Would a non-native speaker understand every sentence on first reading?
- Is every domain term and every abbreviation explained at its first use?
- Do code comments explain the intention instead of repeating what the code does?
- Are all instructions complete and in the right order?
- Is there any sentence that can be removed without losing information?
