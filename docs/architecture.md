# Architecture

The application entry point is `src/hello.ts`. TypeScript compiles the source
from `src/` into `build/`, where `build/hello.js` is the runnable JavaScript
entry point. npm scripts provide the build, test, and start commands.

The addition example is implemented separately in `src/math.ts` and tested
with Vitest from `tests/math.test.ts`.
