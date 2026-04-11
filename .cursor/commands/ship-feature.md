# ship-feature

Description:
Build a complete feature from API to UI, optionally following Figma design, while maintaining strict architecture and adapting mismatches between UI flow and API structure

Instructions:

0. INPUT PARSING
Accept inputs in one of the following forms:
`swagger:` (http://149.28.26.212:7711/swagger/index.html )
`figma:` (https://www.figma.com/design/AdNCnnTdxH33kvCAsAPUcu/World-Merchant-App?node-id=8-14385&p=f&t=95tu5pfxYJZZsNsN-0 )
`notes:` (optional context)
From Swagger:
Extract endpoints, request/response schemas
Identify required fields and constraints
From Figma:
Extract screens, flow sequence, user interactions
Identify UI states (loading, error, empty, success)
Build an internal mapping:
UI actions -> API calls
UI states -> provider state (lib/data/providers)
If mismatch detected:
Mark for reconciliation in provider (data/providers) or Repository layer

INPUT UNDERSTANDING
Accept:
feature name
API endpoint(s)
optional Figma design reference
Identify UI flow from Figma if provided
Identify API structure and constraints
FEATURE SCAFFOLDING
Use feature-builder to create /lib/src/<feature>/ (flat: <feature>_page.dart + components/)
Add or extend `/lib/data/providers/<swagger_controller>_provider.dart` (domain file; multiple notifiers OK—avoid per-page provider files)
Optional: models/ under the feature only if UI needs a dedicated type
DATA LAYER IMPLEMENTATION
Use data-layer-engineer to:
add Retrofit client methods in lib/data/services/clients/<controller>_client.dart
define request/response models in data/models/
implement lib/data/repositories/<controller>_repository.dart
Normalize API responses and errors
UI ↔ API RECONCILIATION (CRITICAL)
If Figma flow ≠ API structure:
DO NOT change UI to match API
Adapt in lib/data/providers or Repository layer
Transform API models → UI models
Combine/split API calls if needed to match UX
Ensure UI receives clean, UI-ready state
PROVIDER LOGIC
Implement business logic in lib/data/providers (Riverpod codegen)
Handle:
loading
success
error
Expose immutable state via Riverpod
6. UI IMPLEMENTATION (STRICT FIGMA MODE)

* Recreate Figma layout structure exactly
* Match spacing, alignment, and hierarchy precisely
* Use theme tokens for colors, typography, spacing
* Break UI into reusable widgets based on Figma components
* Do not approximate or simplify layouts
* Implement all UI states shown in Figma (loading, error, empty, success)
* If Figma conflicts with existing components, adapt components—not the design

6.1 LOCALIZATION ENFORCEMENT

* Replace all UI text with localization keys
* Add new keys to `l10n/` if missing
* Use generated localization accessors
* Ensure no hardcoded strings remain in UI
* Keep key names descriptive and consistent

6.2 THEME ENFORCEMENT (STRICT)

* Always use AppTheme tokens
* If design value not found:

  1. Map to closest existing token
  2. Else extend AppTheme with new semantic token
  3. Hardcode only as last resort with TODO comment
* Do not create inline TextStyle or Color unless explicitly justified

6.3 DATA DISPLAY RULES

* Do not display raw IDs in UI
* Replace IDs with user-friendly values via provider (data/providers) or Repository
* Ensure all displayed data is UI-ready

6.4 ENUM MANAGEMENT

* Define all enums in `data/models/enums.dart`
* Reuse existing enums when possible
* Do not create feature-level enums

6.5 MONEY FORMATTING

* Format all monetary values using `splitMoney` from local services
* Do not display raw numbers for currency
* Ensure UI receives formatted values only

6.6 DIRECTIONALITY (RTL/LTR)

* Set UI direction based on current locale only
* Do not infer direction from text language
* Ensure Arabic = RTL, English = LTR
* Do not override Directionality at widget level unless explicitly required
* Mixed-language content must respect parent layout direction

INTEGRATION
Connect UI → providers (data) → Repository
Ensure no layer violations
VALIDATION
Use architecture-guardian to verify:
no skipped layers
no API models in UI
no direct client or repository calls from UI; providers do not call clients directly
CLEANUP
Use refactor-agent to:
remove duplication
align naming
ensure consistency

RULES:

UI/UX (Figma) has priority over API structure
Architecture must NEVER be violated
All mismatches must be solved in lib/data/providers or Repository
Do NOT introduce new patterns or layers

# After UI + providers + Repository generation
/call-skill generate-tests feature=<feature_name>