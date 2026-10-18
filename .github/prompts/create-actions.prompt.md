---
description: "Create cross-platform CI scripts and a minimal three-OS GitHub Actions workflow using the github-actions skill."
agent: "Build Engineer"
---

# Create Actions

## Передумови

- Працюй у корені проєкту після налаштування npm scripts `build` і `test`, а також lockfile.
- Перевір наявні скрипти й workflow до змін.
- Не видаляй і не перезаписуй файли та не додавай дублікати job чи кроків.

## Дії

1. Виклич skill `github-actions`.
2. Створи або безпечно доповни `ci.sh` і `ci.bat`; обидва мають запускати `npm ci`, `npm run build`, `npm test` саме в такому порядку та завершуватись на першій помилці.
3. Створи або безпечно доповни `.github/workflows/ci.yml` однією job із matrix `ubuntu-latest`, `windows-latest`, `macos-latest` і лише кроками checkout, setup-node та запуск відповідного платформного скрипту.
4. Не розміщуй команди встановлення, збірки чи тестів безпосередньо у workflow.

## Очікувані файли

- `ci.sh`
- `ci.bat`
- `.github/workflows/ci.yml`

## Команди перевірки

- PowerShell: `Get-Content ci.bat`
- Перевір `ci.sh` командою `Get-Content ci.sh` або `bash -n ci.sh`, якщо Bash доступний.
- Перевір наявність трьох ОС та рівно необхідних кроків workflow: `Get-Content .github\workflows\ci.yml`
- Запусти `.\ci.bat` у Windows або `bash ./ci.sh` у Bash; не заявляй про перевірку інших ОС без запуску CI на них.

## Повідомлення про помилку

Якщо скрипт або workflow не можна безпечно узгодити з наявними файлами, зупинись, не перезаписуй їх і повідом про конфлікт. Для помилки команди вкажи її назву, код/вивід помилки та неперевірені платформи.
