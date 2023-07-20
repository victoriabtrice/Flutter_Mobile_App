import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/custom_provider.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    final provCustom = Provider.of<CustomProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provCustom.dateTime,
              readOnly: true,
              decoration: InputDecoration(
                hintText: '${DateFormat('dd/MM/yyyy').format(provCustom.date)} ${DateFormat('HH:mm').format(DateTime.now())}',
                labelText: 'Received Date',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            )
          ),
          const SizedBox(width: 5,),
          IconButton(
            onPressed: () async {
              var res = await showDatePicker(
                context: context, 
                initialDate: provCustom.date, 
                firstDate: DateTime.now().add(const Duration(days: 5)), 
                lastDate: DateTime.now().add(const Duration(days: 30))
              );
              if (res != null) {
                provCustom.date = res; 
                provCustom.dateTime = '${DateFormat('dd/MM/yyyy').format(res)} ${provCustom.time.text}';
              }
            }, 
            splashRadius: 18,
            tooltip: 'Select Date',
            icon: const Icon(Icons.date_range_rounded)
          ),
          IconButton(
            onPressed: () async {
              var res = await showTimePicker(
                context: context, 
                initialTime: provCustom.time2,
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              );
              if (res != null) {
                final now = provCustom.date;
                if (res.hour >= 7 && res.hour <= 21) { // jam buka dari 7 pagi sd 10 malam
                  final newTime = DateTime(now.year, now.month, now.day, res.hour, res.minute);
                  provCustom.time = DateFormat('HH:mm').format(newTime);
                  provCustom.time2 = TimeOfDay(hour: res.hour, minute: res.minute);
                  provCustom.dateTime = DateFormat('dd/MM/yyyy HH:mm').format(newTime);
                }
              }
            }, 
            splashRadius: 18,
            tooltip: 'Select Time',
            icon: const Icon(Icons.timer_rounded)
          )
        ],
      )
    );
  }
}