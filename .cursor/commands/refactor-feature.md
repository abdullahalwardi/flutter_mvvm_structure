# refactor-feature

Refactor a specific feature to align with project standards.

**Skill:** `.cursor/skills/refactor-to-architecture/SKILL.md`

## Steps

1. Analyse feature structure in `lib/src/<feature>/`.
2. Move business logic out of UI into `lib/data/providers/` if needed.
3. Ensure proper separation of layers (UI → Provider → Client/Repository).
4. Extract reusable UI into `lib/src/<feature>/components/`.
5. Align naming conventions (files, classes, providers).
6. Remove duplication.
7. Validate with **architecture-guardian**.
