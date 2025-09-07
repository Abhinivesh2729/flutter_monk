import 'package:flutter/material.dart';
import 'package:flutter_monk/themes/app_theme.dart';
import 'package:flutter_monk/features/create_app/widgets/platform_selector.dart';
import 'package:flutter_monk/features/create_app/widgets/advanced_section.dart';

class CreateAppForm extends StatelessWidget {
  final TextEditingController appNameController;
  final TextEditingController packageNameController;
  final TextEditingController projectLocationController;
  final List<String> platforms;
  final List<String> selectedPlatforms;
  final List<String> initialPackages;
  final List<String> selectedPackages;
  final bool advancedOpen;
  final Function(String) onPlatformToggle;
  final Function(String) onPackageToggle;
  final Function(bool) onAdvancedToggle;
  final VoidCallback onLocationPicked;
  final VoidCallback? onCreatePressed;

  const CreateAppForm({
    super.key,
    required this.appNameController,
    required this.packageNameController,
    required this.projectLocationController,
    required this.platforms,
    required this.selectedPlatforms,
    required this.initialPackages,
    required this.selectedPackages,
    required this.advancedOpen,
    required this.onPlatformToggle,
    required this.onPackageToggle,
    required this.onAdvancedToggle,
    required this.onLocationPicked,
    this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Create New App', style: AppTheme.headlineStyle),
        const SizedBox(height: 24),
        TextField(
          controller: appNameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(labelText: 'App name'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: packageNameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(labelText: 'Package name'),
        ),
        const SizedBox(height: 16),
        PlatformSelector(
          platforms: platforms,
          selectedPlatforms: selectedPlatforms,
          onToggle: onPlatformToggle,
        ),
        const SizedBox(height: 16),
        AdvancedSection(
          isExpanded: advancedOpen,
          onExpansionChanged: onAdvancedToggle,
          packages: initialPackages,
          selectedPackages: selectedPackages,
          onPackageToggle: onPackageToggle,
          projectLocationController: projectLocationController,
          onLocationPicked: onLocationPicked,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: onCreatePressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900],
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Create'),
        ),
      ],
    );
  }
}
