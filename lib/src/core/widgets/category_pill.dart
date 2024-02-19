import 'package:flutter/material.dart';

class CategoryPill extends StatelessWidget {
  const CategoryPill({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
