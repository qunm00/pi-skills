---
name: git
description: >-
  Perform Git operations — commit, branch, merge, rebase, stash, diff, log,
  resolve conflicts, manage remotes, and enforce commit conventions. Use
  whenever the user asks to stage, commit, push, pull, create or switch
  branches, squash commits, undo changes, resolve merge conflicts, or
  perform any Git version control task. Also use when the user asks about
  repository state, commit history, or code review workflows involving Git.
license: MIT
---

# Git Skill

Provides structured workflows for common Git operations. All commands should be run from the repository root.

## Commit Conventions

This skill follows [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

Types: `feat`, `fix`, `chore`, `docs`, `style`, `refactor`, `perf`, `test`, `ci`, `build`, `revert`

## Usage

When the user asks to perform a Git operation:

1. **Understand the request** — determine what the user wants: commit, branch, push, pull, undo, merge, rebase, stash, etc.
2. **Check the current state** — run `git status` to see the working tree and index before taking action.
3. **Confirm destructive operations** — for operations that discard history (`git reset --hard`, `git push --force`, `git branch -D`), explain the impact and confirm with the user before proceeding.
4. **Execute the commands** — use the workflows below. Prefer `--force-with-lease` over `--force`. Prefer `git pull --rebase` over `git pull`.
5. **Verify the result** — run `git log --oneline --graph --all --decorate -5` or `git status` to confirm success.
6. **Use the helper script** — `./scripts/git-day.sh start|sync|publish|finish|squash|log` for common branch workflows.

## Common Workflows

### 1. Check Repository Status

```bash
git status
```

Show a compact, colored log:

```bash
git log --oneline --graph --all --decorate -20
```

Show diff of unstaged changes:

```bash
git diff
```

Show diff of staged changes:

```bash
git diff --cached
```

### 2. Stage and Commit

Stage specific files:

```bash
git add <file1> <file2>
```

Stage all changes:

```bash
git add -A
```

Commit with a conventional message:

```bash
git commit -m "feat(scope): description"
```

Amend the last commit (if not pushed):

```bash
git commit --amend -m "new message"
```

### 3. Branches

List local branches:

```bash
git branch
```

List all branches (including remote):

```bash
git branch -a
```

Create and switch to a new branch:

```bash
git checkout -b <branch-name>
```

Switch to an existing branch:

```bash
git checkout <branch-name>
```

Delete a local branch (fully merged):

```bash
git branch -d <branch-name>
```

Delete a local branch (force):

```bash
git branch -D <branch-name>
```

Delete a remote branch:

```bash
git push origin --delete <branch-name>
```

### 4. Pull and Push

Pull latest with rebase (recommended):

```bash
git pull --rebase
```

Pull latest with merge:

```bash
git pull
```

Push to remote:

```bash
git push
```

Push and set upstream:

```bash
git push -u origin <branch-name>
```

Force push (use with caution):

```bash
git push --force-with-lease
```

### 5. Merge

Merge a branch into the current branch:

```bash
git merge <branch-name>
```

Merge with no fast-forward (preserves branch history):

```bash
git merge --no-ff <branch-name>
```

Abort a merge with conflicts:

```bash
git merge --abort
```

### 6. Rebase

Interactive rebase (squash, reword, reorder commits):

```bash
git rebase -i HEAD~<n>
```

Rebase current branch onto another:

```bash
git rebase <base-branch>
```

Continue rebase after resolving conflicts:

```bash
git rebase --continue
```

Skip a commit during rebase:

```bash
git rebase --skip
```

Abort rebase:

```bash
git rebase --abort
```

### 7. Stash

Stash working directory changes:

```bash
git stash push -m "description"
```

List stashes:

```bash
git stash list
```

Apply the latest stash:

```bash
git stash pop
```

Apply a specific stash:

```bash
git stash apply stash@{<n>}
```

Drop a stash:

```bash
git stash drop stash@{<n>}
```

### 8. Undo / Reset

Unstage a file (keep changes):

```bash
git restore --staged <file>
```

Restore a file to last committed state (discard changes):

```bash
git restore <file>
```

Soft reset (keep changes staged):

```bash
git reset --soft HEAD~1
```

Mixed reset (keep changes unstaged — default):

```bash
git reset HEAD~1
```

Hard reset (discard all changes — irreversible):

```bash
git reset --hard <commit-hash>
```

Revert a commit with a new commit (safe for shared branches):

```bash
git revert <commit-hash>
```

### 9. Log and History

Show commit log with stats:

```bash
git log --oneline --stat -10
```

Search commits by message:

```bash
git log --oneline --grep="keyword"
```

Show commits touching a file:

```bash
git log --oneline -- <file>
```

Show a specific commit:

```bash
git show <commit-hash>
```

Show who changed what in a file (blame):

```bash
git blame <file>
```

### 10. Remotes

List remotes:

```bash
git remote -v
```

Add a remote:

```bash
git remote add <name> <url>
```

Remove a remote:

```bash
git remote remove <name>
```

Update remote URL:

```bash
git remote set-url <name> <new-url>
```

Fetch from all remotes:

```bash
git fetch --all
```

### 11. Tags

List tags:

```bash
git tag
```

Create an annotated tag:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
```

Push tags to remote:

```bash
git push origin --tags
```

Delete a local tag:

```bash
git tag -d v1.0.0
```

Delete a remote tag:

```bash
git push origin --delete v1.0.0
```

### 12. Resolve Merge Conflicts

When `git merge` or `git rebase` reports conflicts:

1. View conflicted files:

   ```bash
   git diff --name-only --diff-filter=U
   ```

2. List all conflicted files with status:

   ```bash
   git status
   ```

3. Open each conflicted file and resolve markers (`<<<<<<<`, `=======`, `>>>>>>>`).

4. After resolving each file, mark it as resolved:

   ```bash
   git add <resolved-file>
   ```

5. Complete the merge or rebase:

   ```bash
   git merge --continue   # if merging
   # or
   git rebase --continue  # if rebasing
   ```

6. Use external merge tools:

   ```bash
   git mergetool
   ```

### 13. Cherry-Pick

Apply a specific commit to the current branch:

```bash
git cherry-pick <commit-hash>
```

Cherry-pick a range of commits:

```bash
git cherry-pick <start-hash>..<end-hash>
```

### 14. Submodules

Add a submodule:

```bash
git submodule add <url> <path>
```

Update all submodules:

```bash
git submodule update --init --recursive
```

### 15. Worktrees

Create a new worktree (check out a branch in a separate directory):

```bash
git worktree add <path> <branch>
```

List worktrees:

```bash
git worktree list
```

Remove a worktree:

```bash
git worktree remove <path>
```

## Undo Scenarios

| Scenario | Command |
|----------|---------|
| Unstage file, keep changes | `git restore --staged <file>` |
| Discard unstaged changes | `git restore <file>` |
| Undo last commit, keep changes | `git reset --soft HEAD~1` |
| Undo last commit, discard changes | `git reset --hard HEAD~1` |
| Undo a pushed commit safely | `git revert <hash>` |
| Fix last commit message | `git commit --amend -m "new msg"` |
| Add forgotten files to last commit | `git add <file>` then `git commit --amend --no-edit` |

## Best Practices

- **Commit early, commit often.** Small, focused commits are easier to review and revert.
- **Write descriptive commit messages.** Use the conventional commits format.
- **Pull with rebase.** Prefer `git pull --rebase` over `git pull` to avoid merge commits.
- **Force push with care.** Always use `--force-with-lease` instead of `--force`.
- **One branch per feature/fix.** Keep branches short-lived and focused.
- **Delete stale branches.** Clean up merged branches locally and on remote.
- **Review before you push.** Use `git diff --cached` and `git log` to verify your changes.
- **Don't commit secrets.** Use `.gitignore` and consider `git-secrets` or similar tools.
