# ClaudeCodingSkills
Collection of Claude Code skills for development.

## Structure

This repository is a Claude Code plugin marketplace:

- `.claude-plugin/marketplace.json` — the marketplace `claude-coding-skills` and its plugins
- `plugins/<plugin>/.claude-plugin/plugin.json` — a plugin
- `plugins/<plugin>/skills/<skill>/SKILL.md` — the skills of a plugin

## Installation

```
/plugin marketplace add RickRainerLudwig/ClaudeCodingSkills
/plugin install <plugin>@claude-coding-skills
```

| Plugin         | Topic                                                    | Skills              |
|----------------|----------------------------------------------------------|---------------------|
| `english-docs` | Writing and proofreading technical documentation         | `technical-writing` |
| `ddd`          | Domain-Driven Design                                     | `tactical-design`   |
| `oo-design`    | Object-oriented design and general coding                | `coding-principles`, `solid`, `code-review` |

A project can enable the plugins it needs in its `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "claude-coding-skills": { "source": { "source": "github", "repo": "RickRainerLudwig/ClaudeCodingSkills" } }
  },
  "enabledPlugins": { "ddd@claude-coding-skills": true }
}
```

For development, add the local clone instead (e.g. `/plugin marketplace add C:/Users/email/ClaudeCodingSkills`), or
load a plugin directly: `claude --plugin-dir plugins/ddd`. After changes, run
`/plugin marketplace update claude-coding-skills` and update the plugin.

Validate the manifests with `claude plugin validate .` (marketplace) or `claude plugin validate plugins/<plugin>`.

## Evals

Each plugin has eval cases in `plugins/<plugin>/evals/<case>/` (`prompt.md` and LLM graders in `graders/*.md`).
They run every case with and without the plugin and report the difference:

```
cd plugins/<plugin>
claude plugin eval . --runs 1 --no-publish
```

Results go to `evals/results/` (not committed).
