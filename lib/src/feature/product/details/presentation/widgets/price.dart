import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: SizedBox(
        height: 50,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            '\$$price',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
