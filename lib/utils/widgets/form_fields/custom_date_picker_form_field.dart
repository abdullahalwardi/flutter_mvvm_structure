import 'package:flutter/material.dart';
import 'package:app/common_lib.dart';

class CustomDatePickerFormField extends StatelessWidget {
  const CustomDatePickerFormField(
      {super.key, required this.selectedDateNotifier, this.pickTime = false});

  final ValueNotifier<DateTime?> selectedDateNotifier;
  final bool pickTime;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedDateNotifier,
        builder: (context, selectedDate, child) {
          return GestureDetector(
            onTap: () async {
              selectedDateNotifier.value = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(
                  DateTime.now().year - 100,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
                lastDate: DateTime.now(),
              );
              if (pickTime) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedDateNotifier.value != null) {
                  selectedDateNotifier.value = DateTime(
                    selectedDateNotifier.value!.year,
                    selectedDateNotifier.value!.month,
                    selectedDateNotifier.value!.day,
                    time?.hour ?? selectedDateNotifier.value!.hour,
                    time?.minute ?? selectedDateNotifier.value!.minute,
                  );
                }
              }
            },
            child: Container(
              width: context.width,
              height: 60,
              padding: const EdgeInsets.all(Insets.medium),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Insets.extraSmall),
                border: Border.all(
                  color: context.colorScheme.primary,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Gap(Insets.medium),
                  Text(
                    selectedDate == null
                        ? context.l10n.pickDate
                        : selectedDate.format(),
                    style: TextStyle(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Icon(
                    Icons.calendar_today,
                    color: context.colorScheme.primary,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
