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

### SKILL.md Format

```markdown
---
name: my-skill
description: What this skill does and when to use it. Be specific.
---

# My Skill

## Setup

Run once before first use:
```bash
cd /path/to/skill && npm install
```

## Usage

```bash
./scripts/process.sh <input>
```
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Max 64 chars. Lowercase a-z, 0-9, hyphens. |
| `description` | Yes | Max 1024 chars. What the skill does and when to use it. |
| `license` | No | License name or reference to bundled file. |
| `compatibility` | No | Max 500 chars. Environment requirements. |
| `metadata` | No | Arbitrary key-value mapping. |
| `allowed-tools` | No | Space-delimited list of pre-approved tools (experimental). |
| `disable-model-invocation` | No | When `true`, skill is hidden from the system prompt. Users must use `/skill:name`. |

## Getting Started

### 1. Create a new skill

```bash
mkdir my-skill
```

Create `my-skill/SKILL.md` with frontmatter and instructions. The `description` tells pi when to load the skill. The `## Usage` section tells the agent what steps to follow:

```markdown
---
name: my-skill
description: Extract and summarize text from PDF files. Use when the user asks to process PDF documents.
---

# My Skill

## Setup

Run once to make scripts executable:

```bash
chmod +x scripts/*.sh
```

## Usage

1. Run the extraction script with the input file.
2. The script outputs plain text to stdout.
3. Summarize the extracted text for the user.

```bash
./scripts/extract.sh <input.pdf>
```
```

### 2. Test in a project

Skills placed in `.pi/skills/` inside a project are automatically discovered after the project is trusted.

```bash
mkdir -p .pi/skills
ln -s /path/to/my-skill .pi/skills/
```

### 3. Install globally

Skills in `~/.pi/agent/skills/` are available to pi in any project.

```bash
mkdir -p ~/.pi/agent/skills
ln -s /path/to/my-skill ~/.pi/agent/skills/
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
