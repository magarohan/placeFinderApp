import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
import '../../view_model/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final authService = AuthService();
    _nameController = TextEditingController(
      text: authService.currentUser?.displayName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate(ProfileViewModel viewModel) async {
    final success = await viewModel.updateProfile(_nameController.text.trim());
    if (success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated!')));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage ?? 'Update failed'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        return StreamBuilder<DocumentSnapshot>(
          stream: viewModel.userStream,
          builder: (context, snapshot) {
            final userData = snapshot.data?.data() as Map<String, dynamic>?;
            final displayName =
                userData?['displayName'] ??
                AuthService().currentUser?.displayName;
            final email =
                userData?['email'] ?? AuthService().currentUser?.email;

            return Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),
                centerTitle: true,
                actions: [
                  if (!viewModel.isEditing)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => viewModel.setEditing(true),
                    )
                  else ...[
                    if (viewModel.isSaving)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () => _handleUpdate(viewModel),
                      ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        viewModel.setEditing(false);
                        _nameController.text = displayName ?? '';
                      },
                    ),
                  ],
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blueAccent.withValues(alpha: 0.1),
                      child: Text(
                        viewModel.getInitials(displayName),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (viewModel.isEditing)
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Display Name',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                      )
                    else ...[
                      Text(
                        displayName ?? 'No name set',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email ?? 'No email found',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await viewModel.logout();
                          // ignore: use_build_context_synchronously
                          if (mounted) Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
