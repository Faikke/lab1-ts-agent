# Architecture

The application entry point is `src/hello.ts`. TypeScript compiles the source
from `src/` into `build/`, where `build/hello.js` is the runnable JavaScript
entry point. npm scripts provide the build, test, and start commands.

The addition example is implemented separately in `src/math.ts` and tested
with Vitest from `tests/math.test.ts`.

## Problems addressed by the agent

The Build Engineer automates the repeated setup work needed to turn a minimal
TypeScript Hello World into a verifiable project: it creates a consistent
scaffold, aligns npm scripts, TypeScript output and Vitest tests, and provides
the same build/test sequence for Windows, Linux and macOS. Its final check
confirms the expected runtime output and that generated `build/` output and
installed `node_modules/` dependencies are not tracked by Git. Setup steps are
idempotent so rerunning them does not replace existing content or add duplicate
configuration.

## Skills and commands

The agent manifest is `.github/agents/build-engineer.agent.md`. It delegates
specialized work to these skills:

- `project-scaffold` accepts a project name and an optional greeting language
  (English by default) and prepares `src/hello.ts`, README sections and missing
  documentation files.
- `build-and-test` configures the npm `build`, `test` and `start` scripts,
  TypeScript output to `build/`, the `add` function and Vitest's
  `BasicAddition` test.
- `github-actions` provides `ci.sh`, `ci.bat` and a minimal GitHub Actions
  workflow with an Ubuntu/Windows/macOS matrix.

The corresponding prompts are the operational commands:

- `/git-init` verifies or initializes the repository, adds the required
  `.gitignore` rules and reports Git status.
- `/create-project` invokes `project-scaffold`.
- `/create-build` invokes `build-and-test`.
- `/create-actions` invokes `github-actions`.
- `/check` is read-only: it verifies required files and configuration, runs
  build/test/runtime checks when dependencies are installed, and checks the
  workflow matrix and Git ignore state.
- `/init` orchestrates the preceding commands in the order
  `/git-init` → `/create-project` → `/create-build` → `/create-actions` →
  `/check`.

## Data flow and error handling

`/init` takes the project name from the request/context and an optional
greeting language; when omitted, the scaffold uses English and prints exactly
`Hello World`. `/git-init` first establishes repository/ignore state.
`/create-project` passes the name and language to `project-scaffold`, which
provides the source and documentation structure. `build-and-test` consumes
that structure and writes npm scripts, TypeScript configuration, the math
source and test, and a lockfile. `github-actions` consumes the npm scripts and
lockfile to create platform scripts and the workflow; the workflow delegates
the actual `npm ci`, build and test commands to those scripts.

Each stage preserves compatible existing files and passes its resulting
project state to the next stage through the shared working tree. `/check`
validates the assembled result without repairing it. If `node_modules/` is
missing, it reports the blocker and recommends `npm ci`; it does not install
dependencies itself. `/init` is fail-fast: on the first failed stage it stops,
does not invoke later commands, and reports the failed command, completed
stages and checks that were not run. It reports success only after `/check`
passes.
