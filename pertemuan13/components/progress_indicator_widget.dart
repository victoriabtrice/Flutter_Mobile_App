import 'package:flutter/material.dart';
import 'package:flutter_application_13/pertemuan13/pertemuan13_provider.dart';
import 'package:provider/provider.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Pertemuan13Provider>(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(100, 90)),
        onPressed: () {
          prov.sliderValue.round() == 0
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text('Perhatian'),
                        content: Text(
                            'Durasi memanggang Anda tidak boleh bernilai 0.'));
                  })
              : prov.mulaiMemanggang(prov.sliderValue.round());
        },
        child: prov.sedangMemanggang == true
            ? TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: prov.sliderValue.round()),
                builder: (context, double value, _) =>
                    CircularProgressIndicator(
                  value: value,
                ),
              )
            : const Text('Panggang'));
  }
}
