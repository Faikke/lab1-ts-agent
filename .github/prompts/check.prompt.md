---
description: "Read-only validation of the Build Engineer project scaffold, skills, build, tests, runtime, CI matrix, and Git ignore state."
agent: "Build Engineer"
---

# Check

## Передумови

- Працюй у корені проєкту.
- Ця команда є перевіркою без редагування вихідних файлів, конфігурації, Git index чи налаштувань. Не створюй і не виправляй файли, не запускай `git init` та не видаляй нічого.
- Оскільки `npm run build` може створювати або оновлювати `build/`, спершу перевір робочий стан і виконуй build лише якщо його побічний результат обмежений ігнорованою директорією `build/`. Не запускай перевірку, якщо вона змінюватиме відстежувані файли; повідом про це як про блокер. Не очищуй build-артефакти.

## Дії

1. Перевір структуру: `src/hello.ts`, `src/math.ts`, `tests/math.test.ts`, `README.md`, `docs/architecture.md`, `docs/usage.md`, `.gitignore`, `package.json`, `package-lock.json`, `tsconfig.json`, `ci.sh`, `ci.bat`, `.github/workflows/ci.yml`.
2. Перевір manifest `.github/agents/build-engineer.agent.md` та skills `.github/skills/project-scaffold/SKILL.md`, `.github/skills/build-and-test/SKILL.md`, `.github/skills/github-actions/SKILL.md`.
3. Перевір, що `package.json` містить `build`, `test` і `start`; TypeScript збирає у `build/`; workflow має matrix для Ubuntu, Windows і macOS.
4. Перевір, що `.gitignore` виключає `build/` і `node_modules/`, а `git ls-files` не повертає відстежуваних файлів із цих директорій.
5. Перед будь-якою командою npm перевір, що директорія `node_modules/` існує. Якщо її немає, повідом про блокер, порадь виконати `npm ci` і зупини перевірки, не змінюючи файлів. Якщо існує, виконай `npm run build`, `npm test`, `node build/hello.js`; звір, що runtime виводить точно `Hello World`.
6. Переконайся, що жодна перевірка не змінювала відстежувані файли, і надай результат кожного кроку окремо. Якщо робоче дерево було змінене до запуску, не приписуй попередні зміни перевірці.

## Очікувані файли

- Ця команда не створює і не редагує файли.
- Перевіряються зазначені вище source, docs, manifest, skills, npm-конфігурації, CI-скрипти та workflow.
- `build/` може містити лише ігнорований результат потрібного build; не додавай його до Git.

## Команди перевірки

- PowerShell: `Test-Path src\hello.ts; Test-Path src\math.ts; Test-Path tests\math.test.ts; Test-Path README.md; Test-Path docs\architecture.md; Test-Path docs\usage.md; Test-Path .github\agents\build-engineer.agent.md; Test-Path .github\skills\project-scaffold\SKILL.md; Test-Path .github\skills\build-and-test\SKILL.md; Test-Path .github\skills\github-actions\SKILL.md`
- PowerShell: `Test-Path node_modules` — виконай до `npm run build`; якщо результат `False`, зупинись і повідом блокер із рекомендацією `npm ci`.
- `npm run build`
- `npm test`
- `node build/hello.js`
- Git Bash: `git check-ignore build/ node_modules/`
- `git ls-files -- build/ node_modules/` — очікуй порожній результат; ця форма працює без shell-specific `grep`.
- Перевір workflow: `Get-Content .github\workflows\ci.yml`
- Перед і після команд порівняй `git status --short` та не приховуй наявних змін.

## Повідомлення про помилку

Якщо `node_modules/` відсутня, повідом: «Блокер: директорія `node_modules/` відсутня. Виконайте `npm ci`, потім повторіть `/check`». Не запускай npm-команди та не змінюй файли в цьому випадку. Для будь-якого іншого відсутнього файлу, помилки команди чи невідповідності повідом точну перевірку, її результат і наступний рекомендований prompt (`/git-init`, `/create-project`, `/create-build` або `/create-actions`). Не виправляй стан у цій команді, не продовжуй оголошувати успіх і чітко познач блокер, якщо build порушив би read-only умову.
