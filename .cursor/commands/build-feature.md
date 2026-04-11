# build-feature

Description:
Build a complete feature from API to UI following project architecture

Instructions:

Use feature-builder to scaffold feature structure in /lib/src/<feature>/
Use data-layer-engineer to:
add Retrofit client in lib/data/services/clients/<controller>_client.dart
define models (Freezed)
implement lib/data/repositories/<controller>_repository.dart
Integrate repository with lib/data/providers/<controller>_provider.dart
Connect UI to those providers (ref.watch / notifier)
Ensure proper state handling (loading, success, error)
Use architecture-guardian to validate structure
Use refactor-agent to clean and align code
Do not skip any architectural layer