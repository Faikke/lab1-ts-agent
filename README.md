# lab1-ts-agent

**Лабораторна робота № 1.** Проєктування AI-агента для автоматизації розробки та CI/CD.

- **ПІБ:** Олійник Ростислав Петрович 
- **Група:** КІ-405
- **Варіант:** 6 (TypeScript, npm scripts, Vitest)

## Опис

Мінімальний кросплатформний TypeScript Hello World, створений за допомогою AI-агента Build Engineer (GitHub Copilot). Проєкт збирається в `build/`, має юніт-тест `BasicAddition` (Vitest) і CI на Windows, Linux та macOS через GitHub Actions.

## Запуск проєкту

```sh
npm ci
npm run build
npm test
npm start
```

Програма виводить `Hello World` (запуск напряму: `node build/hello.js`).

## Запуск AI-агента

1. Відкрити репозиторій у VS Code з GitHub Copilot (режим Agent).
2. У чаті Copilot запустити prompt `init.prompt.md` з `.github/prompts`. Це оркестратор: `git-init` → `create-project` → `create-build` → `create-actions` → `check`.
3. Окремі команди: `/git-init`, `/create-project`, `/create-build`, `/create-actions`, `/check`.

Детальніше: `docs/usage.md`, архітектура: `docs/architecture.md`, журнал взаємодії з AI: `docs/ai-log.md`.