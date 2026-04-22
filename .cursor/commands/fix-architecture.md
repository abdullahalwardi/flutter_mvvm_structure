# fix-architecture

Detect and fix architecture violations across the codebase.

**Skill:** `.cursor/skills/refactor-to-architecture/SKILL.md`  
**Rule file:** `.cursor/rules/architecture-layering.mdc`

## Steps

1. Use **architecture-guardian** to scan for violations.
2. Identify:
   - UI calling a client or datasource directly.
   - API models imported in `lib/src/` widget files.
   - Provider bypassing an existing repository (posts, user, attachment, notifications domains).
   - `viewmodels/`, `presentation/`, or `screens/` folders under `lib/src/<feature>/`.
   - Cross-feature imports.
   - Duplicated implementations.
3. Use **refactor-agent** to correct issues.
4. Preserve behaviour while enforcing structure.
5. Do not introduce new patterns or abstraction layers.
