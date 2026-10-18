#!/usr/bin/env sh
set -eu

npm ci
npm run build
npm test
