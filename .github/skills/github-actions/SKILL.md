---
name: github-actions
description: 'Create cross-platform GitHub Actions CI for TypeScript projects using ci.sh and ci.bat. Use when adding or updating the Windows, Linux, and macOS workflow.'
---

# GitHub Actions

## Коли застосовувати

- Коли потрібно налаштувати CI для збірки й тестів на Ubuntu, Windows і macOS.
- Коли потрібно створити платформні `ci.sh` та `ci.bat` і workflow, що викликає відповідний скрипт.
- Застосовуй після налаштування npm scripts та lockfile.

## Вхідні дані

- npm-проєкт із `package-lock.json` та scripts `build` і `test`.
- Платформи: `ubuntu-latest`, `windows-latest`, `macos-latest`.

Приклад:

```text
install: npm ci
build: npm run build
test: npm test
matrix: ubuntu-latest, windows-latest, macos-latest
```

## Вихідні файли

- `ci.sh` — послідовно виконує `npm ci`, `npm run build`, `npm test` і завершується з помилкою, якщо будь-яка команда не пройшла.
- `ci.bat` — виконує ті самі команди в тому самому порядку та повертає ненульовий код при першій помилці.
- `.github/workflows/ci.yml` — запускається на `push` у гілки `feature/**`, `main`, `develop` і `master`, а також на `pull_request`; має одну job із matrix на Ubuntu, Windows і macOS та кроки checkout, setup-node і окремі умовні кроки для запуску `ci.sh` (Unix) або `ci.bat` (Windows). Використовуй `if: runner.os ...` лише для умов кроків; не використовуй контекст `runner` у значенні `shell`. Workflow не містить команд встановлення, збірки чи тестування — вони живуть у платформних скриптах.

Перевір цільові файли перед створенням. Не перезаписуй наявні скрипти чи workflow та не додавай дублікати кроків/job. Збережи сумісний наявний вміст і доповнюй тільки відсутні вимоги. Якщо наявну структуру не можна узгодити без втрати даних або дублювання, зупинись і повідом про конфлікт.

## Перевірки

- Переконайся, що workflow має рівно одну job із matrix Ubuntu/Windows/macOS.
- Переконайся, що тригер `push` включає `feature/**`, `main`, `develop` і `master`, а `pull_request` збережено.
- Переконайся, що після checkout і setup-node є два окремі кроки: `if: runner.os != 'Windows'` з `run: ./ci.sh` і `shell: bash`, та `if: runner.os == 'Windows'` з `run: ci.bat` і `shell: cmd`.
- Не використовуй вирази з контекстом `runner` у полі `shell`; умови runner задавай через `if` кроку.
- Перевір, що Unix-like runners запускають `ci.sh`, а Windows запускає `ci.bat`.
- Перевір порядок команд в обох скриптах: `npm ci`, `npm run build`, `npm test`; переконайся, що помилка команди зупиняє скрипт.
- Запусти відповідний скрипт на доступній локальній платформі; чітко зазнач, що інші платформи перевіряються GitHub Actions, а не локальним запуском.

## Типовий сценарій помилки та що робити

Якщо CI падає на `npm ci`, перевір наявність і узгодженість `package-lock.json` та виправ її через build-and-test skill; не додавай залежності чи build/test-команди безпосередньо до workflow. Якщо платформний скрипт приховує помилку або продовжує виконання після неї, виправ код виходу скрипту й повтори перевірку. Не оголошуй CI успішним, доки всі кроки не завершились успішно.
