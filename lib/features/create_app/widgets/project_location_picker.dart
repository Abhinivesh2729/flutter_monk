import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ProjectLocationPicker extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onLocationPicked;

  const ProjectLocationPicker({
    super.key,
    required this.controller,
    required this.onLocationPicked,
  });

  Future<void> _pickProjectLocation() async {
    String? selectedDir = await FilePicker.platform.getDirectoryPath();
    if (selectedDir != null) {
      controller.text = selectedDir;
      onLocationPicked();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            readOnly: true,
            decoration: const InputDecoration(labelText: 'Project location'),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _pickProjectLocation,
          child: const Text('Choose'),
        ),
      ],
    );
  }
}
