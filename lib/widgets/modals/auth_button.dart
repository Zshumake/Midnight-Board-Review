import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/firebase_sync_service.dart';
import '../../utils/theme.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final sync = context.watch<FirebaseSyncService>();

    if (sync.isSignedInWithGoogle) {
      return _SignedInChip(
        email: sync.userEmail ?? 'Signed in',
        onSignOut: () => sync.signOut(),
      );
    }

    return _SignInButton(
      onTap: () async {
        final success = await sync.signInWithGoogle();
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signed in! Progress syncs across devices.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SignInButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_outline_rounded,
                size: 16, color: AppColors.textMuted),
            const SizedBox(width: 6),
            Text(
              'Sign in',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignedInChip extends StatelessWidget {
  final String email;
  final VoidCallback onSignOut;
  const _SignedInChip({required this.email, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Account'),
            content: Text('Signed in as $email.\nProgress syncs across devices.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  onSignOut();
                  Navigator.pop(ctx);
                },
                child: Text('Sign out',
                    style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.accentAmber.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: AppColors.accentAmber.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_done_rounded,
                size: 14, color: AppColors.accentAmber),
            const SizedBox(width: 5),
            Text(
              'Synced',
              style: TextStyle(
                color: AppColors.accentAmber,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
