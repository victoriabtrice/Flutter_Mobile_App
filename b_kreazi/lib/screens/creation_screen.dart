import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/creation_provider.dart';
import 'package:b_kreazi/components/creation_card.dart';

class Creation extends StatefulWidget {
  const Creation({super.key, required this.title, required this.search});

  final String title;
  final String search;

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  @override
  Widget build(BuildContext context) {
    final provCreation = Provider.of<CreationProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: provCreation.allCreations.where((creation) => creation['Name'].toLowerCase().contains(widget.search) || creation['Burger'].keys.toString().toLowerCase().contains(widget.search)).isEmpty?
        Center(
          child: Text('Kreazi "${widget.search}" tidak ditemukan', style: const TextStyle(fontSize: 16),),
        )
      :
        CreationCard(product: provCreation.allCreations.where((creation) => creation['Name'].toLowerCase().contains(widget.search) || creation['Burger'].keys.toString().toLowerCase().contains(widget.search)).toList(), provider: provCreation),
    );
  }
}