---
name: React Stack CLI V1
overview: Build a minimal CLI tool that scaffolds production-ready React projects with a fixed default stack (TanStack Query, Zustand, Zod, svgr, uuid, Tailwind CSS v4, shadcn/ui canary) and a clean feature-based folder structure.
todos:
  - id: cli-skeleton
    content: Set up CLI package with TypeScript, commander, bin entry point
    status: pending
  - id: template-files
    content: Create all template files in src/templates/default/
    status: pending
  - id: copy-logic
    content: Implement template copy and token replacement logic
    status: pending
  - id: install-deps
    content: Add npm install execution with --skip-install flag
    status: pending
  - id: shadcn-setup
    content: Integrate shadcn@canary init and component addition
    status: pending
  - id: final-output
    content: Print success message with next steps
    status: pending
  - id: documentation
    content: Write CLI README and generated app README template
    status: pending
isProject: false
---

# React Stack CLI - V1 Implementation Plan

## 1. CLI Project Architecture

### Package Structure (Monorepo-lite)

```
react-stack-cli/
├── bin/
│   └── react-stack.js          # CLI entry point (shebang)
├── src/
│   ├── index.ts                # Main CLI logic
│   ├── commands/
│   │   └── create.ts           # The "create" command handler
│   ├── scaffolder/
│   │   ├── index.ts            # Orchestrates scaffolding steps
│   │   ├── copy-template.ts    # Copies template files
│   │   ├── process-package.ts  # Modifies package.json dynamically
│   │   └── run-shadcn.ts       # Executes shadcn init + add
│   ├── utils/
│   │   ├── logger.ts           # Colored console output
│   │   ├── spawn.ts            # Promisified child_process
│   │   └── paths.ts            # Path resolution helpers
│   └── templates/              # Static template files (copied verbatim)
│       └── default/            # The default React app template
├── package.json
├── tsconfig.json
└── README.md
```

### Entry Point Responsibilities

- **bin/react-stack.js**: Node shebang, imports compiled `dist/index.js`
- **src/index.ts**: Parses CLI args, routes to `create` command
- **src/commands/create.ts**: Validates target dir, orchestrates scaffolder
- **src/scaffolder/index.ts**: Runs steps in sequence: copy, process, install, shadcn

---

## 2. Step-by-Step Build Plan (Ordered Milestones)

### Milestone 1: CLI Skeleton

- Initialize npm package with `type: "module"`
- Set up TypeScript with ESM output
- Create `bin/react-stack.js` entry point
- Add argument parsing (use `commander` or lightweight args parsing)
- Implement `--help`, `--version`, basic `create <project-name>` command

### Milestone 2: Template Files

- Create the `src/templates/default/` directory
- Build all static template files (see Section 4 below)
- Ensure template has placeholder tokens for dynamic values (e.g., `{{PROJECT_NAME}}`)

### Milestone 3: Copy and Process Logic

- Implement `copy-template.ts` to recursively copy template dir to target
- Implement `process-package.ts` to replace tokens in `package.json` and other files
- Handle existing directory detection (prompt or fail)

### Milestone 4: Dependency Installation

- Implement `spawn.ts` helper for running shell commands
- Run `npm install` (or detect pnpm/yarn) in target directory
- Add `--skip-install` flag to bypass installation

### Milestone 5: shadcn/ui Integration

- Run `npx shadcn@canary init --yes --defaults` after deps install
- Run `npx shadcn@canary add button` (or a starter set) to verify setup
- Handle Tailwind CSS v4 compatibility (shadcn canary supports it)

### Milestone 6: Final Output

- Print success message with "next steps"
- Include commands: `cd <project>`, `npm run dev`, etc.

---

## 3. Folder Structures

### CLI Repository Structure

```
react-stack-cli/
├── bin/
│   └── react-stack.js
├── dist/                       # Compiled output (gitignored)
├── src/
│   ├── index.ts
│   ├── commands/
│   │   └── create.ts
│   ├── scaffolder/
│   │   ├── index.ts
│   │   ├── copy-template.ts
│   │   ├── process-package.ts
│   │   └── run-shadcn.ts
│   ├── utils/
│   │   ├── logger.ts
│   │   ├── spawn.ts
│   │   └── paths.ts
│   └── templates/
│       └── default/
│           ├── public/
│           ├── src/
│           └── ... (all template files)
├── package.json
├── tsconfig.json
└── README.md
```

### Generated React App Structure (Feature-Based Layout)

```
<project-name>/
├── public/
│   └── vite.svg
├── src/
│   ├── main.tsx                    # App entry point with providers
│   ├── App.tsx                     # Root component
│   ├── index.css                   # Tailwind imports + shadcn vars
│   ├── components/
│   │   └── ui/                     # shadcn components (auto-added)
│   ├── features/                   # Feature-based modules
│   │   └── example/
│   │       ├── components/
│   │       ├── hooks/
│   │       └── index.ts
│   ├── hooks/                      # Shared custom hooks
│   │   └── index.ts
│   ├── lib/
│   │   ├── utils.ts                # cn() utility (shadcn adds this)
│   │   ├── query-client.ts         # TanStack Query client config
│   │   └── api.ts                  # Base API helpers (optional stub)
│   ├── stores/                     # Zustand stores
│   │   └── example-store.ts
│   ├── schemas/                    # Zod schemas
│   │   └── example.schema.ts
│   ├── types/                      # Shared TypeScript types
│   │   └── index.ts
│   └── providers/
│       └── app-providers.tsx       # Wraps QueryClientProvider
├── components.json                 # shadcn config
├── index.html
├── package.json
├── tsconfig.json
├── tsconfig.app.json
├── tsconfig.node.json
├── vite.config.ts
├── eslint.config.js
└── README.md
```

---

## 4. Dependency Lists

### CLI Tool Dependencies

**dependencies:**

- `commander` - CLI argument parsing
- `chalk` - Colored terminal output
- `fs-extra` - Enhanced file system operations
- `ora` - Spinner for async operations

**devDependencies:**

- `typescript`
- `@types/node`
- `@types/fs-extra`
- `tsup` - Fast TypeScript bundler for CLI

### Generated App Dependencies

**dependencies:**

- `react` ^19.x
- `react-dom` ^19.x
- `@tanstack/react-query` ^5.x
- `zustand` ^5.x
- `zod` ^3.x
- `uuid` ^11.x (v4 function)
- `tailwindcss` ^4.x
- `@tailwindcss/vite`
- `clsx` (for shadcn cn utility)
- `tailwind-merge` (for shadcn cn utility)
- `lucide-react` (shadcn icon library)

**devDependencies:**

- `vite` (or `rolldown-vite` if preferred)
- `@vitejs/plugin-react`
- `vite-plugin-svgr`
- `typescript` ~5.9.x
- `@types/react`
- `@types/react-dom`
- `@types/uuid`
- `@types/node`
- `eslint` + React plugins
- `babel-plugin-react-compiler` (optional, for React 19)

---

## 5. Implementation Sequence

### Step 1: Template File Copy Strategy

1. Store all template files in `src/templates/default/`
2. Use `.template` extension for files needing token replacement (e.g., `package.json.template`)
3. Copy files recursively, stripping `.template` extension
4. Replace tokens: `{{PROJECT_NAME}}`, `{{VERSION}}`

### Step 2: Post-Processing Steps

1. **Rename project**: Replace `{{PROJECT_NAME}}` in `package.json`, `index.html` title
2. **Generate IDs**: If needed (none in V1)
3. **Write components.json**: shadcn config with correct paths

### Step 3: Install Dependencies

```bash
# Run in target directory
npm install
```

### Step 4: Run shadcn Setup

```bash
# Initialize shadcn with defaults (non-interactive)
npx shadcn@canary init --yes --defaults

# Optionally add a starter component to verify
npx shadcn@canary add button --yes
```

### Step 5: Final Cleanup

- Remove any temp files
- Ensure `.gitignore` is present
- Print success message

---

## 6. Documentation Plan

### CLI README.md Content

- What the CLI does
- Installation: `npm install -g react-stack-cli` or `npx react-stack`
- Usage: `react-stack create my-app`
- Flags: `--skip-install`
- What's included in generated projects
- Links to stack documentation

### Generated App README.md Content

- Project overview
- Getting started: `npm install`, `npm run dev`
- Folder structure explanation
- Stack overview with links:
  - TanStack Query for data fetching
  - Zustand for state management
  - Zod for validation
  - Tailwind CSS + shadcn/ui for styling
- Adding new features guide
- Build and deploy instructions

---

## 7. V2 Roadmap (Brief)

**Goal**: Introduce optional stack selection and early agent-assisted additions.

- **Interactive mode**: Prompts for optional packages (react-router, react-hook-form, etc.)
- **Flags for stack variants**: `--with-router`, `--with-forms`
- **Agent integration stub**: Allow LLM-based code generation to add features
- **Multiple styling options**: CSS Modules, styled-components as alternatives
- **Testing setup option**: Vitest + Testing Library

---

## 8. V3 Roadmap (Brief)

**Goal**: Dynamic theming, multi-template support, and richer agent workflows.

- **Dynamic theming**: Multiple color themes, light/dark mode toggle, theme switcher component
- **Template marketplace**: Community-contributed templates
- **Full agent workflows**: Natural language feature requests ("add auth with Clerk")
- **Monorepo support**: Generate apps within Turborepo/Nx workspaces
- **Backend integration**: Optional API scaffolding (tRPC, Express stubs)
- **Config presets**: Save and share project configurations

---

## Key Files to Create

### Template `package.json.template`

```json
{
  "name": "{{PROJECT_NAME}}",
  "private": true,
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "lint": "eslint .",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^19.2.0",
    "react-dom": "^19.2.0",
    "@tanstack/react-query": "^5.84.1",
    "zustand": "^5.0.8",
    "zod": "^3.25.3",
    "uuid": "^11.1.0",
    "tailwindcss": "^4.1.18",
    "@tailwindcss/vite": "^4.1.18",
    "clsx": "^2.1.1",
    "tailwind-merge": "^3.3.0",
    "lucide-react": "^0.513.0"
  },
  "devDependencies": {
    "vite": "^6.3.5",
    "@vitejs/plugin-react": "^5.1.1",
    "vite-plugin-svgr": "^4.5.0",
    "typescript": "~5.9.3",
    "@types/react": "^19.2.5",
    "@types/react-dom": "^19.2.3",
    "@types/uuid": "^10.0.0",
    "@types/node": "^24.10.1",
    "eslint": "^9.39.1",
    "@eslint/js": "^9.39.1",
    "eslint-plugin-react-hooks": "^7.0.1",
    "eslint-plugin-react-refresh": "^0.4.24",
    "globals": "^16.5.0",
    "typescript-eslint": "^8.46.4"
  }
}
```

### Template `src/providers/app-providers.tsx`

```tsx
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useState, type ReactNode } from "react";

function makeQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 60 * 1000,
        refetchOnWindowFocus: false,
      },
    },
  });
}

export function AppProviders({ children }: { children: ReactNode }) {
  const [queryClient] = useState(() => makeQueryClient());

  return (
    <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
  );
}
```

### Template `src/stores/example-store.ts`

```typescript
import { create } from "zustand";

interface ExampleState {
  count: number;
  increment: () => void;
  decrement: () => void;
}

export const useExampleStore = create<ExampleState>()((set) => ({
  count: 0,
  increment: () => set((state) => ({ count: state.count + 1 })),
  decrement: () => set((state) => ({ count: state.count - 1 })),
}));
```
