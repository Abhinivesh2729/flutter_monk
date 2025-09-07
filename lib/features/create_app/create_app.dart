import 'package:flutter/material.dart';
import 'package:flutter_monk/themes/app_theme.dart';
import 'package:flutter_monk/features/create_app/widgets/create_app_card.dart';
import 'package:flutter_monk/features/create_app/widgets/create_app_form.dart';
import 'package:flutter_monk/features/create_app/services/flutter_service.dart';
import 'package:flutter_monk/features/create_app/services/create_app_controller.dart';

class CreateAppScreen extends StatefulWidget {
  const CreateAppScreen({super.key});

  @override
  State<CreateAppScreen> createState() => _CreateAppScreenState();
}

class _CreateAppScreenState extends State<CreateAppScreen> {
  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _packageNameController = TextEditingController();
  final TextEditingController _projectLocationController =
      TextEditingController();

  final List<String> _platforms = [
    'Windows',
    'macOS',
    'Linux',
    'Web',
    'iOS',
    'Android',
  ];
  final List<String> _selectedPlatforms = [];
  final List<String> _initialPackages = [
    'http',
    'intl',
    'provider',
    'shimmer',
    'dio',
    'url_launcher',
  ];
  final List<String> _selectedPackages = [];

  bool _advancedOpen = true;
  bool _isCreating = false;
  String _creationStatus = 'Creating Flutter project...';

  @override
  void initState() {
    super.initState();
    _appNameController.addListener(_updatePackageName);
    _setDefaultProjectLocation();
  }

  @override
  void dispose() {
    _appNameController.dispose();
    _packageNameController.dispose();
    _projectLocationController.dispose();
    super.dispose();
  }

  void _setDefaultProjectLocation() {
    _projectLocationController.text =
        FlutterService.getDefaultProjectLocation();
  }

  void _updatePackageName() {
    _packageNameController.text = CreateAppController.updatePackageName(
      _appNameController.text,
    );
  }

  void _togglePlatform(String platform) {
    setState(() {
      _selectedPlatforms.contains(platform)
          ? _selectedPlatforms.remove(platform)
          : _selectedPlatforms.add(platform);
    });
  }

  void _togglePackage(String pkg) {
    setState(() {
      _selectedPackages.contains(pkg)
          ? _selectedPackages.remove(pkg)
          : _selectedPackages.add(pkg);
    });
  }

  void _onLocationPicked() {
    setState(() {});
  }

  Future<void> _onCreatePressed() async {
    final appName = _appNameController.text.trim();
    if (appName.isEmpty) return;

    setState(() {
      _isCreating = true;
      _creationStatus = 'Creating Flutter project...';
    });

    try {
      await CreateAppController.createProject(
        context: context,
        appName: appName,
        packageName: _packageNameController.text,
        projectLocation: _projectLocationController.text,
        selectedPlatforms: _selectedPlatforms,
        selectedPackages: _selectedPackages,
        onStatusUpdate: (status) {
          setState(() {
            _creationStatus = status;
          });
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth * 0.7;
            if (width < 400) width = constraints.maxWidth * 0.95;
            if (width > 800) width = 800;

            return CreateAppCard(
              width: width,
              child: _isCreating
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: Colors.white),
                          const SizedBox(height: 16),
                          Text(
                            _creationStatus,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : CreateAppForm(
                      appNameController: _appNameController,
                      packageNameController: _packageNameController,
                      projectLocationController: _projectLocationController,
                      platforms: _platforms,
                      selectedPlatforms: _selectedPlatforms,
                      initialPackages: _initialPackages,
                      selectedPackages: _selectedPackages,
                      advancedOpen: _advancedOpen,
                      onPlatformToggle: _togglePlatform,
                      onPackageToggle: _togglePackage,
                      onAdvancedToggle: (v) =>
                          setState(() => _advancedOpen = v),
                      onLocationPicked: _onLocationPicked,
                      onCreatePressed: _appNameController.text.trim().isEmpty
                          ? null
                          : _onCreatePressed,
                    ),
            );
          },
        ),
      ),
    );
  }
}
