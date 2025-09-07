import 'package:flutter/material.dart';

class PackageSelector extends StatelessWidget {
  final List<String> packages;
  final List<String> selectedPackages;
  final Function(String) onToggle;

  const PackageSelector({
    super.key,
    required this.packages,
    required this.selectedPackages,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Initial packages',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: packages.map((pkg) {
            final selected = selectedPackages.contains(pkg);
            return ChoiceChip(
              label: Text(
                pkg,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white70,
                ),
              ),
              selected: selected,
              selectedColor: Colors.blue[800],
              backgroundColor: const Color(0xFF19335A),
              onSelected: (_) => onToggle(pkg),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
