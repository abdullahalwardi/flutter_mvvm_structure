# debug-flow

Trace and debug issues across the data flow pipeline.

**Skill:** `.cursor/skills/debug-data-flow/SKILL.md`

## Steps

1. Identify whether the domain has a repository (posts, user, attachment, notifications) or not.
2. Trace execution along the correct path:
   - **With repository:** `UI → Provider → Repository → Client`
   - **Default (no repository):** `UI → Provider → Client`
3. Identify where incorrect state/data originates.
4. Verify model mapping (API model → UI state).
5. Check provider state transitions (AsyncLoading → AsyncData / AsyncError).
6. Suggest minimal fix at the true origin point.
7. Validate fix with **architecture-guardian**.
