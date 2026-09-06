#!/bin/bash
set -e

echo "==> Installing dependencies..."
npm install

echo "==> Setting up Git hooks (if any)..."
# Uncomment below if you use husky or similar
# npx husky install

echo "==> Dev container setup complete!"
echo "    Run 'npm run dev' to start the Vite dev server."
