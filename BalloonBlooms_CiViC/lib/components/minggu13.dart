import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/custom_provider.dart';

class SnackBudget extends StatefulWidget {
  const SnackBudget({super.key});

  @override
  State<SnackBudget> createState() => _SnackBudgetState();
}

class _SnackBudgetState extends State<SnackBudget> {
  @override
  Widget build(BuildContext context) {
    final provCustom = Provider.of<CustomProvider>(context);
    
    return Column(
      children: provCustom.accessories.entries.map((acc) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            value: acc.value, 
            title: acc.value? Text('${acc.key}  (Rp. ${provCustom.budget[acc.key]~/1000}.000,-)', style: const TextStyle(fontWeight: FontWeight.bold),) : Text(acc.key), 
            subtitle: acc.value? Row(
              children: [
                const Text('Budget'),
                Tooltip(
                  message: 'Rp. ${provCustom.budget[acc.key]~/1000}.000,-',
                  child: Slider(
                    min: 10000, max: 250000,
                    value: provCustom.budget[acc.key].toDouble(), 
                    onChanged: (val) => provCustom.changeBudget(acc.key, (val~/1000)*1000)
                  ),
                ),
              ],
            ) : null,
            onChanged: (val) => provCustom.accessories = acc.key
          ),
        );
      }).toList()
    );
  }
}

class UpdateLoad extends StatefulWidget {
  const UpdateLoad({super.key});

  @override
  State<UpdateLoad> createState() => _UpdateLoadState();
}

class _UpdateLoadState extends State<UpdateLoad> {
  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator();
  }
}