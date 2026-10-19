# Usage

Install the locked dependencies and run the compiled Hello World program:

```sh
npm ci
npm run build
npm start
```

Run the build and test suite with:

```sh
npm run build
npm test
```

The program prints `Hello World`.

## Run the agent

1. Open this repository in VS Code with GitHub Copilot enabled.
2. Open Copilot Chat and select **Agent** mode.
3. Run the `init.prompt.md` prompt from `.github/prompts/` (shown as `/init` in the prompt picker/chat).
4. Let the orchestrator run `/git-init`, `/create-project`, `/create-build`, `/create-actions`, and `/check` in order. It stops at the first error and reports the outcome.

To run the local CI verification, use the script for your shell:

```powershell
.\ci.bat
```

```sh
bash ./ci.sh
```

Both scripts install the locked dependencies with `npm ci`, then run the build and tests. To check the program output directly after building, run `node build/hello.js`; it should print exactly `Hello World`.
