import 'dart:io';

import 'package:app/common_lib.dart';
import 'package:app/data/services/local_services.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageFormField extends StatelessWidget {
  const ImageFormField({
    super.key,
    required this.dimension,
    required this.text,
    required this.image,
    required this.onChanged,
  });

  ImageFormField.notifier(
    ValueNotifier<CroppedFile?> notifier, {
    super.key,
    required this.dimension,
    required this.text,
  })  : image = notifier.value,
        onChanged = notifier.update;

  final CroppedFile? image;
  final ValueChanged<CroppedFile> onChanged;
  final double dimension;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: Time.small,
      child: image == null
          ? FormField(
              initialValue: image,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) return context.l10n.validatorRequired;
                return null;
              },
              builder: (field) {
                return InkWell(
                  onTap: () {
                    cropImage(context).then((value) {
                      if (value != null) onChanged(value);
                    });
                  },
                  child: ColumnPadded(
                    gap: 4,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: dimension,
                        height: dimension,
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.outline),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        text,
                        style: theme.textTheme.titleLarge,
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            field.errorText!,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            )
          : InkWell(
              onTap: () {
                cropImage(context).then((value) {
                  if (value != null) onChanged(value);
                });
              },
              child: Column(
                children: [
                  Container(
                    width: dimension,
                    height: dimension,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(dimension),
                      child: Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    text,
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
    );
  }
}


