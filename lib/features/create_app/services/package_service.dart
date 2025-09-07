import 'dart:developer';
import 'dart:io';

class PackageInstallationResult {
  final List<String> installedPackages;
  final List<String> failedPackages;
  final bool hasErrors;

  PackageInstallationResult({
    required this.installedPackages,
    required this.failedPackages,
    required this.hasErrors,
  });
}

class PackageService {
  static Future<PackageInstallationResult> installPackages({
    required String flutterPath,
    required String projectPath,
    required List<String> packages,
  }) async {
    if (packages.isEmpty) {
      return PackageInstallationResult(
        installedPackages: [],
        failedPackages: [],
        hasErrors: false,
      );
    }

    final installedPackages = <String>[];
    final failedPackages = <String>[];

    try {
      log("Installing packages: ${packages.join(', ')}");

      // Install all packages in one command
      final result = await Process.run(flutterPath, [
        'pub',
        'add',
        ...packages,
      ], workingDirectory: projectPath);

      log("Package installation result: ${result.exitCode}");
      log("Package installation stdout: ${result.stdout}");

      if (result.exitCode == 0) {
        // All packages installed successfully
        installedPackages.addAll(packages);
        log("All packages installed successfully");
      } else {
        // Some or all packages failed
        log("Package installation failed: ${result.stderr}");
        failedPackages.addAll(packages);
      }
    } catch (e) {
      log("Package installation error: $e");
      failedPackages.addAll(packages);
    }

    return PackageInstallationResult(
      installedPackages: installedPackages,
      failedPackages: failedPackages,
      hasErrors: failedPackages.isNotEmpty,
    );
  }
}
