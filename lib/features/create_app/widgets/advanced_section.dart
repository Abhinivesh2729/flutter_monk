import 'package:flutter/material.dart';
import 'package:flutter_monk/features/create_app/widgets/package_selector.dart';
import 'package:flutter_monk/features/create_app/widgets/project_location_picker.dart';

class AdvancedSection extends StatelessWidget {
  final bool isExpanded;
  final Function(bool) onExpansionChanged;
  final List<String> packages;
  final List<String> selectedPackages;
  final Function(String) onPackageToggle;
  final TextEditingController projectLocationController;
  final VoidCallback onLocationPicked;

  const AdvancedSection({
    super.key,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.packages,
    required this.selectedPackages,
    required this.onPackageToggle,
    required this.projectLocationController,
    required this.onLocationPicked,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged,
      title: Text(
        'Advanced',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: const Color(0xFF142F4C),
      collapsedBackgroundColor: const Color(0xFF142F4C),
      children: [
        PackageSelector(
          packages: packages,
          selectedPackages: selectedPackages,
          onToggle: onPackageToggle,
        ),
        const SizedBox(height: 8),
        ProjectLocationPicker(
          controller: projectLocationController,
          onLocationPicked: onLocationPicked,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
