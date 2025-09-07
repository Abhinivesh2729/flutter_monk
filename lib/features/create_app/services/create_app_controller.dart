import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'flutter_service.dart';
import 'package_service.dart';
import 'dialog_service.dart';

class CreateAppController {
  static Future<void> createProject({
    required BuildContext context,
    required String appName,
    required String packageName,
    required String projectLocation,
    required List<String> selectedPlatforms,
    required List<String> selectedPackages,
    required Function(String) onStatusUpdate,
  }) async {
    try {
      // Check Flutter installation and get path
      final flutterPath = await FlutterService.findFlutterPath();
      if (flutterPath == null) {
        DialogService.showErrorDialog(
          context,
          'Flutter not found',
          'Flutter is not installed or not available. Please install Flutter and try again.\n\nTried paths:\n- /usr/local/bin/flutter\n- /opt/homebrew/bin/flutter\n- ~/flutter/bin/flutter',
        );
        return;
      }

      // Prepare parameters
      final projectName = appName.toLowerCase().replaceAll(
        RegExp(r'[^a-z0-9_]'),
        '_',
      );
      final organization = FlutterService.extractOrganization(packageName);
      final platforms = FlutterService.getSelectedPlatforms(selectedPlatforms);
      final finalProjectLocation = projectLocation.isEmpty
          ? FlutterService.getDefaultProjectLocation()
          : projectLocation;
      final fullProjectPath = path.join(finalProjectLocation, projectName);

      // Create the flutter project
      final projectCreated = await FlutterService.createProject(
        flutterPath: flutterPath,
        projectName: projectName,
        organization: organization,
        platforms: platforms,
        fullProjectPath: fullProjectPath,
      );

      if (projectCreated) {
        // Project created successfully, now install packages if any selected
        if (selectedPackages.isNotEmpty) {
          onStatusUpdate('Installing packages...');

          final installationResult = await PackageService.installPackages(
            flutterPath: flutterPath,
            projectPath: fullProjectPath,
            packages: selectedPackages,
          );

          if (installationResult.hasErrors) {
            DialogService.showWarningDialog(
              context,
              'Package Installation Warning',
              'Project created successfully, but some packages failed to install:\n${installationResult.failedPackages.join(', ')}\n\nYou can install them manually later.',
            );
          }

          DialogService.showSuccessDialog(
            context,
            fullProjectPath,
            installationResult.installedPackages,
          );
        } else {
          DialogService.showSuccessDialog(context, fullProjectPath, []);
        }
      } else {
        DialogService.showErrorDialog(
          context,
          'Project Creation Failed',
          'Failed to create project. Please check the logs for more details.',
        );
      }
    } catch (e) {
      DialogService.showErrorDialog(context, 'Error', 'An error occurred: $e');
    }
  }

  static String updatePackageName(String appName) {
    final cleanAppName = appName
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');

    if (cleanAppName.isEmpty) {
      return 'com.example.app';
    }

    // Ensure package name doesn't start with a number
    final validAppName = RegExp(r'^[0-9]').hasMatch(cleanAppName)
        ? 'app_$cleanAppName'
        : cleanAppName;

    return 'com.example.$validAppName';
  }
}
