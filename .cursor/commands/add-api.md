# add-api

Description:
Integrate a new API endpoint into an existing feature

Instructions:

Use data-layer-engineer to add methods on lib/data/services/clients/<controller>_client.dart
Create/update models in data/models/
Update lib/data/repositories/<controller>_repository.dart with mapping logic
Update lib/data/providers/<controller>_provider.dart to consume repository
Expose clean state to UI
Ensure UI does not directly depend on API models
Validate with architecture-guardian