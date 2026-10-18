---
description: "Configure the TypeScript npm build, start script, and Vitest BasicAddition test using the build-and-test skill."
agent: "Build Engineer"
---

# Create Build

## Передумови

- Працюй у корені проєкту після створення базового scaffold.
- Перевір `package.json`, lockfile, TypeScript source та тести перед редагуванням.
- Не видаляй і не перезаписуй наявні файли; зберігай сторонні налаштування та уникай дублікатів.

## Дії

1. Виклич skill `build-and-test`.
2. Налаштуй scripts `build`, `test`, `start`, TypeScript `outDir` у `build/`, `src/math.ts` з `add` і тест `BasicAddition` у Vitest.
3. Узгодь lockfile для `npm ci`, якщо потрібно, не видаляючи його та не замінюючи `npm ci` іншим способом.
4. Виконай перевірки й повідом точні результати.

## Очікувані файли

- `package.json`
- `package-lock.json`
- `tsconfig.json`
- `src/math.ts`
- `tests/math.test.ts`
- Збірка створює `build/hello.js`, а `npm start` запускає його.

## Команди перевірки

- `npm run build`
- `npm test`
- `node build/hello.js`
- `npm start`

## Повідомлення про помилку

Якщо залежності, lockfile або наявні scripts конфліктують із потрібною конфігурацією, не перезаписуй їх і не приховуй помилку. Зупинись, повідом команду та її результат, назви конфліктні файли й зазнач, які перевірки не виконались.
