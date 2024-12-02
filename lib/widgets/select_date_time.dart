import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'common_text_field.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: 'Date',
            hintText: Helpers.dateFormatter(date),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectDate(context, ref),
              icon: const FaIcon(FontAwesomeIcons.calendar),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: CommonTextField(
            title: 'Time',
            hintText: Helpers.timeToString(time),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: const FaIcon(FontAwesomeIcons.clock),
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context, WidgetRef ref) async {
    // Customizing the date picker dialog with orange theme
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: ref.read(dateProvider), // current date from provider
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange, // Calendar header color
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button text color
            colorScheme: ColorScheme.light(primary: Colors.orange), // Day selection color
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
    }
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    // Customizing the time picker dialog with orange theme
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: ref.read(timeProvider), // current time from provider
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange, // Time picker header color
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // Time selection color
              secondary: Colors.orange, // Selected time color
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Button text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }
}
