import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthPickerDialog extends StatefulWidget {
  final int initialMonth;

  const MonthPickerDialog({super.key, required this.initialMonth});

  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<MonthPickerDialog> {
  late int _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Select Month',
            style: TextStyle(
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.bold,
            )),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: List.generate(
            12,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMonth = index + 1;
                });
                Navigator.of(context).pop(_selectedMonth);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  monthName(index + 1),
                  style: TextStyle(
                    fontSize: Get.width * 0.04,
                    fontWeight: _selectedMonth == index + 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel',
              style: TextStyle(
                fontSize: Get.width * 0.03,
                fontWeight: FontWeight.normal,
              )),
        ),
      ],
    );
  }
}

String monthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
