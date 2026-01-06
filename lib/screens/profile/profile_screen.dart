import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../utils/dialogs.dart';
import '../../utils/formatters.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.primaryGreen,
              child: Text(
                Formatters.initials(user?.displayName ?? user?.email ?? 'U'),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              user?.displayName ?? 'Usuário',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(
              user?.email ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            const SizedBox(height: 32),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.person,
                      label: 'Nome',
                      value: user?.displayName ?? 'Não informado',
                    ),

                    const Divider(height: 24),

                    _buildInfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: user?.email ?? 'Não informado',
                    ),

                    const Divider(height: 24),

                    _buildInfoRow(
                      icon: Icons.verified_user,
                      label: 'Email verificado',
                      value: user?.emailVerified == true ? 'Sim' : 'Não',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.edit,
                      color: AppTheme.primaryGreen,
                    ),
                    title: const Text('Editar nome'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _handleEditName(context),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(
                      Icons.lock,
                      color: AppTheme.primaryGreen,
                    ),
                    title: const Text('Alterar senha'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _handleChangePassword(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  if (await AppDialogs.confirmLogout(context)) {
                    if (!context.mounted) return;
                    context.read<AuthProvider>().logout();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                icon: const Icon(Icons.exit_to_app, color: Colors.red),
                label: const Text('Sair da conta'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryGreen, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleEditName(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    final currentName = authProvider.user?.displayName ?? '';

    final newName = await AppDialogs.editName(
      context,
      currentName: currentName,
    );

    if (newName != null && newName != currentName) {
      if (!context.mounted) return;

      final success = await AppDialogs.showLoading(
        context,
        message: 'Atualizando nome...',
        operation: () => authProvider.updateName(newName),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Nome atualizado com sucesso!'
                : authProvider.errorMessage ?? 'Erro ao atualizar nome',
          ),
          backgroundColor: success ? AppTheme.primaryGreen : Colors.red,
        ),
      );
    }
  }

  Future<void> _handleChangePassword(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();

    final result = await AppDialogs.changePassword(context);

    if (result != null) {
      if (!context.mounted) return;

      final success = await AppDialogs.showLoading(
        context,
        message: 'Alterando senha...',
        operation: () => authProvider.updatePassword(
          currentPassword: result['currentPassword']!,
          newPassword: result['newPassword']!,
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Senha alterada com sucesso!'
                : authProvider.errorMessage ?? 'Erro ao alterar senha',
          ),
          backgroundColor: success ? AppTheme.primaryGreen : Colors.red,
        ),
      );
    }
  }
}
