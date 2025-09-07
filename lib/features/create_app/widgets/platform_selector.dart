import 'package:flutter/material.dart';

class PlatformSelector extends StatelessWidget {
  final List<String> platforms;
  final List<String> selectedPlatforms;
  final Function(String) onToggle;

  const PlatformSelector({
    super.key,
    required this.platforms,
    required this.selectedPlatforms,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Platforms',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: platforms.map((platform) {
            final selected = selectedPlatforms.contains(platform);
            return ChoiceChip(
              label: Text(
                platform,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white70,
                ),
              ),
              selected: selected,
              selectedColor: Colors.blue[800],
              backgroundColor: const Color(0xFF19335A),
              onSelected: (_) => onToggle(platform),
            );
          }).toList(),
        ),
      ],
    );
  }
}
