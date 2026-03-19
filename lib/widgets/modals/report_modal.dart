import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/episodes_data.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class ReportModal extends StatefulWidget {
  const ReportModal({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim, secondAnim, child) {
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, anim, secondAnim) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 420,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: const ReportModal(),
        ),
      ),
    );
  }

  @override
  State<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  String _issueType = 'Audio Issue';
  String? _selectedEpisode;
  final _descController = TextEditingController();

  static const _issueTypes = [
    'Audio Issue',
    'Content Error',
    'App Bug',
    'Feature Request',
    'Other',
  ];

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(Radii.xl),
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: AppShadows.elevated,
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report an Issue',
                  style: AppTypography.headlineSm(context)),
              const SizedBox(height: Spacing.xl),

              // Issue type
              DropdownButtonFormField<String>(
                initialValue: _issueType,
                dropdownColor: AppColors.bgElevated,
                items: _issueTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _issueType = v!),
                decoration: const InputDecoration(labelText: 'Issue Type'),
              ),
              const SizedBox(height: Spacing.md),

              // Episode
              DropdownButtonFormField<String>(
                initialValue: _selectedEpisode,
                dropdownColor: AppColors.bgElevated,
                isExpanded: true,
                items: [
                  const DropdownMenuItem(
                      value: null,
                      child: Text('Select episode (optional)')),
                  ...allEpisodes.map((e) => DropdownMenuItem(
                        value: e.title,
                        child: Text(e.title,
                            overflow: TextOverflow.ellipsis, maxLines: 1),
                      )),
                ],
                onChanged: (v) => setState(() => _selectedEpisode = v),
                decoration: const InputDecoration(labelText: 'Episode'),
              ),
              const SizedBox(height: Spacing.md),

              // Description
              TextField(
                controller: _descController,
                maxLines: 3,
                style: const TextStyle(color: AppColors.textMain),
                decoration:
                    const InputDecoration(labelText: 'Describe the issue'),
              ),
              const SizedBox(height: Spacing.xl),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: Spacing.sm),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _submit,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Spacing.xl, vertical: Spacing.md),
                        decoration: BoxDecoration(
                          gradient: AppColors.amberGradient,
                          borderRadius: BorderRadius.circular(Radii.sm),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentAmber
                                  .withValues(alpha: 0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text('Send Report',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final subject =
        Uri.encodeComponent('Midnight Board Review: $_issueType');
    final body = Uri.encodeComponent(
      'Issue Type: $_issueType\n'
      'Episode: ${_selectedEpisode ?? "N/A"}\n\n'
      '${_descController.text}',
    );
    final uri =
        Uri.parse('mailto:$reportEmail?subject=$subject&body=$body');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
    if (mounted) Navigator.pop(context);
  }
}
