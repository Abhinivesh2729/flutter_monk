import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_monk/themes/app_theme.dart';
import 'package:flutter_monk/features/home/home.dart';

class DialogService {
  static void showSuccessDialog(
    BuildContext context,
    String projectPath,
    List<String> installedPackages,
  ) {
    String message = 'Project created successfully at:\n$projectPath';

    if (installedPackages.isNotEmpty) {
      message +=
          '\n\nPackages installed:\n${installedPackages.map((pkg) => '• $pkg').join('\n')}';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text('Success!', style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await Process.run("code", [projectPath]);
              } catch (e) {
                log(e.toString());
              }
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text('Open in VS Code'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showWarningDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: Text(title, style: const TextStyle(color: Colors.orange)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
