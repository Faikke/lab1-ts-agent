# Repository Instructions

## Build, test, and lint

The project is configured with npm scripts, TypeScript, Vitest, and cross-platform CI. The commands below are defined by `package.json`, `.github/skills/build-and-test/SKILL.md`, and `.github/skills/github-actions/SKILL.md`:

- Install locked dependencies: `npm ci`
- Build: `npm run build`
- Run all tests: `npm test`
- Run only the addition test: `npx vitest run tests/math.test.ts -t BasicAddition`
- Run the compiled Hello World program: `node build/hello.js`
- Run the package start script: `npm start`
- Run the cross-platform CI sequence locally: `bash ./ci.sh` on Bash, or `.\ci.bat` in PowerShell/cmd.

No lint command is currently defined. Do not invent or report one as configured.

## Architecture

This repository separates the project-generation workflow into three layers:

- `.github/agents/build-engineer.agent.md` defines the Build Engineer role, safety boundaries, commands, and completion criteria.
- `.github/skills/` holds the reusable implementation procedures: `project-scaffold` creates the Hello World scaffold, `build-and-test` configures npm/TypeScript/Vitest, and `github-actions` configures CI scripts and workflow.
- `.github/prompts/` exposes focused operations. `/init` orchestrates `/git-init`, `/create-project`, `/create-build`, `/create-actions`, then `/check` in that exact fail-fast order.

The generated app is intentionally small: `src/hello.ts` compiles to `build/hello.js`; `src/math.ts` exports `add`, exercised by `tests/math.test.ts` using Vitest. TypeScript uses `rootDir: "src"` and `outDir: "build"` so the compiled entry point is at the path expected by `node build/hello.js` and `npm start`.

Cross-platform checks are centralized in the root `ci.sh` and `ci.bat` scripts. Each runs `npm ci`, `npm run build`, and `npm test` in that order and stops on failure. `.github/workflows/ci.yml` is deliberately thin: one job with an Ubuntu/Windows/macOS matrix, checkout, setup-node, and the platform-appropriate script invocation. Keep build and test commands in the scripts rather than duplicating them in the workflow.

## Key conventions

- Treat the agent, skills, and prompts as the project workflow specification. When implementation files are added, keep their behavior consistent with those definitions and `docs/ai-log.md`, which records prior decisions and resolved gaps.
- Generation steps are idempotent: inspect targets first, preserve compatible content, add only missing files/settings, and never create duplicate scripts, dependencies, tests, workflow jobs, or ignore rules. `docs/architecture.md` and `docs/usage.md` are created only when absent.
- The scaffold defaults to English; without an explicit language, `src/hello.ts` must print exactly `Hello World`.
- Keep `build/` and `node_modules/` ignored and out of Git. `npm ci` depends on a lockfile consistent with `package.json`.
- `/check` is read-only: it does not repair or create files. It checks that `node_modules/` exists before running npm commands; if missing, report the blocker and recommend `npm ci`. Do not claim a check succeeded unless build, tests, runtime output, workflow matrix, and Git-ignore checks all pass.
- Preserve existing changes. Do not delete files, force-push or rewrite Git history, handle secrets by exposing or committing them, or change branch protection. Require explicit confirmation before other dangerous or irreversible operations.
