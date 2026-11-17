# ClaudeCodingSkills

Skills for [Claude Code](https://claude.com/claude-code) that make Claude write code and documentation the way we
want it: clean, immutable where possible, designed with Domain-Driven Design (DDD), and documented in plain English.

The repository is a Claude Code **plugin marketplace** named `claude-coding-skills`. Each plugin covers one topic and
contains one or more skills. A skill is a set of instructions that Claude loads when a task matches it. You install
only the plugins a project needs.

## Plugins

### `english-docs` – Technical documentation in English

| Skill | Use |
|---|---|
| `technical-writing` | Writing and revising READMEs, manuals, API documentation and code comments |

- US English in plain language, because many readers are not native English speakers
- IT jargon is fine; jargon of the software's domain is avoided or explained
- Abbreviations are explained at their first use
- Code comments explain the intention, not what the code does

### `ddd` – Domain-Driven Design

| Skill | Use |
|---|---|
| `tactical-design` | Modeling a domain with aggregates, entities, value objects, domain events, repositories, factories, services and modules |

- Based on Eric Evans, *Domain-Driven Design: Tackling Complexity in the Heart of Software*
- Model classes (value objects, entities, aggregates) are immutable: a change returns a new instance with the same
  identity
- A model class that must be mutable says in its API documentation that it is not thread-safe, why, and how to use
  it safely

### `oo-design` – Object-oriented design and general coding

| Skill | Use |
|---|---|
| `coding-principles` | Writing, changing and refactoring code |
| `solid` | Designing classes and interfaces, assessing a design |
| `review-checklist` | Reviewing a change, a file or a module with a fixed checklist and severity ranking |

- Single Level of Abstraction (SLA), Single Responsibility Principle (SRP), Don't Repeat Yourself (DRY), Keep It
  Simple (KISS), You Aren't Gonna Need It (YAGNI) and more
- Mutable fields are private; non-private fields are final/readonly/const and reference immutable objects only
- The SOLID principles, applied to reduce the cost of change, not as an end in themselves

### `git-workflow` – Git commits

| Skill | Use |
|---|---|
| `commit-messages` | Creating commits and writing or reviewing commit messages |

- Every commit message starts with a type prefix as defined by [Conventional Commits](https://www.conventionalcommits.org),
  e.g. `feat:`, `fix:`, `docs:`, `test:` or `chore:`
- Every commit is signed off by the current git user (`git commit -s`)
- A hook checks each commit Claude creates and asks Claude to amend it if it breaks these rules. The hook needs
  `bash` and `git`, which Claude Code on Windows provides through Git for Windows.

## Installation

Add the marketplace and install the plugins you need in Claude Code:

```
/plugin marketplace add RickRainerLudwig/ClaudeCodingSkills
/plugin install english-docs@claude-coding-skills
/plugin install ddd@claude-coding-skills
/plugin install oo-design@claude-coding-skills
/plugin install git-workflow@claude-coding-skills
```

To get updates later, run `/plugin marketplace update claude-coding-skills`.

### Enable plugins for a project

To make Claude Code offer the plugins to everyone working on a project, add them to the project's
`.claude/settings.json` and commit it:

```json
{
  "extraKnownMarketplaces": {
    "claude-coding-skills": {
      "source": { "source": "github", "repo": "RickRainerLudwig/ClaudeCodingSkills" }
    }
  },
  "enabledPlugins": {
    "english-docs@claude-coding-skills": true,
    "oo-design@claude-coding-skills": true
  }
}
```

### Rules that must always apply

Claude loads a skill only when it decides that the skill fits the task. For rules that must apply to every task,
also put a short version into `~/.claude/CLAUDE.md` (all projects) or the project's `CLAUDE.md`, which Claude always
reads. The skills then provide the details.

## Repository structure

```
.claude-plugin/marketplace.json          the marketplace and its list of plugins
plugins/<plugin>/
├── .claude-plugin/plugin.json           name, description and version of the plugin
├── skills/<skill>/SKILL.md              one folder per skill
├── hooks/                               optional hooks that run on tool calls
└── evals/<case>/                        test cases for the plugin
    ├── prompt.md
    └── graders/*.md
```

## Development

### Use the local clone

While working on the skills, use the local clone instead of GitHub:

```
/plugin marketplace add <path to your clone>
```

Installed plugins are copies. After a change, run `/plugin marketplace update claude-coding-skills`, update the
plugin and start a new session. To try a single plugin without installing it, start Claude Code with
`claude --plugin-dir plugins/<plugin>`.

### Add a skill

1. Create `plugins/<plugin>/skills/<skill>/SKILL.md` with the front matter `name` and `description`.
2. Write the `description` carefully: Claude uses it to decide when to load the skill. Name the situations, not only
   the topic, e.g. "Use when designing aggregates or deciding between entity and value object".
3. Keep `SKILL.md` short. Put long material such as catalogs or examples into separate files next to it, e.g.
   `references/*.md`, and refer to them from `SKILL.md`. Claude reads them only when needed.
4. Add the skill to the plugin's table in this README, and raise `version` in the plugin's `plugin.json`.

A new topic gets its own plugin in `plugins/` and an entry in `.claude-plugin/marketplace.json`.

### Validate

```
claude plugin validate .                    # marketplace
claude plugin validate plugins/<plugin>     # one plugin with its skills
```

### Evals

Each plugin has test cases (evals) in `plugins/<plugin>/evals/`. Each case is a prompt with graders: an AI model
checks the answer against the criteria in `graders/*.md`. Every case runs with and without the plugin, so the result
shows what the plugin adds:

```
cd plugins/<plugin>
claude plugin eval . --runs 1 --no-publish
```

`--runs 1` is a quick, cheap check; leave it out for more reliable results (three runs per case). Results are written
to `evals/results/`, which is not committed. A good case is one that Claude fails without the plugin. If a case
passes either way, it does not show the value of the skill and should be made harder.

## License

[Apache License 2.0](LICENSE)
