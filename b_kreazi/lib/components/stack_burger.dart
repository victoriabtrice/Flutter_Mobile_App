import 'package:flutter/material.dart';

class StackBurger extends StatefulWidget {
  const StackBurger({super.key, required this.source, required this.padding, this.width=150});

  final Map source; 
  final double padding;
  final double width;

  @override
  State<StackBurger> createState() => _StackBurgerState();
}

class _StackBurgerState extends State<StackBurger> {
  @override
  Widget build(BuildContext context) {
    int index = widget.source['TtlQty']-1;
    return Stack( 
      alignment: AlignmentDirectional.topCenter,
      children: [
        for (var component in widget.source['Burger'].entries.toList().reversed)
          for (var item = 0; item < component.value['qty']; item++)
            Padding(
              padding: EdgeInsets.only(
                top: (index--)*widget.padding
              ),
              child: Image.asset(
                'assets/${component.key}.png', 
                width: widget.width == 150? null : widget.width,
              ),
            ),
      ],
    );
  }
}