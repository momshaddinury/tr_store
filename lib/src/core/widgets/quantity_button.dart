import 'package:flutter/material.dart';

class QuantityButton extends StatefulWidget {
  const QuantityButton({
    super.key,
    this.vertical = true,
    this.quantity = 1,
    required this.onChanged,
  });

  final bool vertical;
  final int quantity;
  final Function(int) onChanged;

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.vertical
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _decrementButton(),
                _quantity(context),
                _incrementButton(),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _decrementButton(),
                _quantity(context),
                _incrementButton(),
              ],
            ),
    );
  }

  IconButton _decrementButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          quantity = quantity > 1 ? quantity - 1 : 1;
          widget.onChanged(quantity);
        });
      },
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      icon: Icon(
        Icons.remove,
        color: quantity > 1
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).disabledColor,
      ),
    );
  }

  Text _quantity(BuildContext context) {
    return Text(
      quantity.toString(),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).primaryColor,
          ),
    );
  }

  IconButton _incrementButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          quantity++;
          widget.onChanged(quantity);
        });
      },
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      icon: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
