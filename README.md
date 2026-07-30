# Pi Skills

A collection of [pi coding agent](https://github.com/earendil-works/pi) skills — self-contained capability packages that extend what the agent can do.

## What Are Pi Skills?

Skills are specialized modules that pi loads on-demand when a task matches their description. Each skill provides:

- **Setup instructions** — dependencies and configuration steps
- **Workflows and scripts** — helper executables and automation
- **Reference documentation** — detailed guides for complex tasks

When you ask pi to do something that matches a skill's description, pi loads the skill and follows its instructions, using relative paths to reference scripts and assets within the skill directory.

> **Security:** Skills can instruct the agent to perform any action and may include executable code. Review skill content before use.

## Skill Structure

Every skill lives in its own directory with a `SKILL.md` file at the root:

```
my-skill/
├── SKILL.md              # Required: frontmatter + instructions
├── scripts/              # Helper scripts
│   └── process.sh
├── references/           # Detailed docs loaded on-demand
│   └── api-reference.md
└── assets/
    └── template.json
```

## Discovery

Pi loads skills from these locations:

- **Global:** `~/.pi/agent/skills/`, `~/.agents/skills/`
- **Project** (after trust): `.pi/skills/`, `.agents/skills/` (current dir and ancestors up to git root)
- **Packages:** `skills/` directories or `pi.skills` entries in `package.json`
- **Settings:** `skills` array in `settings.json`
- **CLI:** `--skill <path>` (repeatable)

Directories containing `SKILL.md` are discovered recursively. In `~/.pi/agent/skills/` and `.pi/skills/`, standalone `.md` files at the root are also discovered as skills.

## References

- [Agent Skills Standard](https://agentskills.io/specification) — The open specification pi implements
- [Pi Documentation](https://github.com/earendil-works/pi) — Full pi coding agent docs
- [Anthropic Skills](https://github.com/anthropics/skills) — Community skill examples (document processing, web dev)
- [Pi Skills](https://github.com/badlogic/pi-skills) — More skill examples (web search, browser automation, Google APIs)

## License

This repository is a template for creating pi skills. Skills within it may have their own licenses specified in their frontmatter.
