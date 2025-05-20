import 'package:flutter/material.dart';

enum FilterType { none, grayscale, sepia, ups }

extension FilterTypeExtension on FilterType {
  String get name {
    switch (this) {
      case FilterType.none:
        return "Original";
      case FilterType.grayscale:
        return "Laplacian";
      case FilterType.sepia:
        return "SobelX";
      case FilterType.ups:
        return "GaussianBlur";
    }
  }
}

class FilterSelector extends StatelessWidget {
  final FilterType selected;
  final Function(FilterType) onSelect;

  const FilterSelector({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: FilterType.values.map((filter) {
        return GestureDetector(
          onTap: () => onSelect(filter),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: filter == selected ? Colors.blueAccent : Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              filter.name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }
}
