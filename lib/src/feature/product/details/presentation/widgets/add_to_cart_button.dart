import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    this.onPressed,
    this.disabled = false,
  });

  final VoidCallback? onPressed;
  final bool disabled;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    print(widget.disabled);
    return Expanded(
      flex: 2,
      child: SizedBox(
        height: 50,
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            backgroundColor: widget.disabled
                ? Theme.of(context).disabledColor
                : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Add to Cart',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
