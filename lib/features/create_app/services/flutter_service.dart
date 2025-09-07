import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;

class FlutterService {
  static Future<String?> findFlutterPath() async {
    // Common Flutter installation paths
    final List<String> commonPaths = [
      '/Users/apple/flutter/bin/flutter', // User's detected path
      '/usr/local/bin/flutter',
      '/opt/homebrew/bin/flutter',
      '${Platform.environment['HOME']}/flutter/bin/flutter',
      '${Platform.environment['HOME']}/fvm/default/bin/flutter',
    ];

    // First try the PATH
    try {
      final result = await Process.run('which', ['flutter']);
      if (result.exitCode == 0) {
        final path = result.stdout.toString().trim();
        if (path.isNotEmpty) return path;
      }
    } catch (e) {
      log("which command failed: $e");
    }

    // Then try common paths
    for (final path in commonPaths) {
      try {
        final file = File(path);
        if (await file.exists()) {
          final result = await Process.run(path, ['--version']);
          if (result.exitCode == 0) {
            log("Found Flutter at: $path");
            return path;
          }
        }
      } catch (e) {
        log("Failed to check path $path: $e");
        continue;
      }
    }

    return null;
  }

  static Future<bool> createProject({
    required String flutterPath,
    required String projectName,
    required String organization,
    required List<String> platforms,
    required String fullProjectPath,
  }) async {
    try {
      log("Creating project with Flutter at: $flutterPath");
      log("Project name: $projectName");
      log("Organization: $organization");
      log("Platforms: ${platforms.join(',')}");
      log("Project path: $fullProjectPath");

      final result = await Process.run(flutterPath, [
        'create',
        '--project-name',
        projectName,
        '--org',
        organization,
        '--platforms',
        platforms.join(','),
        fullProjectPath,
      ]);

      return result.exitCode == 0;
    } catch (e) {
      log("Project creation error: $e");
      return false;
    }
  }

  static String extractOrganization(String packageName) {
    final parts = packageName.split('.');
    if (parts.length >= 2) {
      return '${parts[0]}.${parts[1]}';
    }
    return 'com.example';
  }

  static List<String> getSelectedPlatforms(List<String> selectedPlatforms) {
    if (selectedPlatforms.isEmpty) {
      return ['windows', 'macos', 'linux', 'web', 'ios', 'android'];
    }
    return selectedPlatforms.map((p) => p.toLowerCase()).toList();
  }

  static String getDefaultProjectLocation() {
    try {
      final String documentsPath;
      if (Platform.isWindows) {
        documentsPath = Platform.environment['USERPROFILE'] ?? '';
        return path.join(documentsPath, 'Documents');
      } else if (Platform.isMacOS || Platform.isLinux) {
        documentsPath = Platform.environment['HOME'] ?? '';
        return path.join(documentsPath, 'Documents');
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
