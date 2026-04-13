import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/core/constants/app_strings.dart';
import 'package:personal_life_manager/providers/settings_provider.dart';

/// Settings screen matching Figma — profile card, grouped setting rows with icon containers + toggles.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ─────────────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 56, 24, 24),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // ── Profile Card ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppColors.balanceGradient,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text('👤', style: TextStyle(fontSize: 28)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'DayTrack User',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Preferences ───────────────────────────────────────────
              _SectionLabel(title: 'Preferences'),
              _SettingRow(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                hasToggle: true,
                toggleValue: true,
                onToggleChanged: (_) {},
              ),
              _SettingRow(
                icon: Icons.palette_outlined,
                label: 'Appearance',
                hasChevron: true,
              ),
              _SettingRow(
                icon: Icons.language_rounded,
                label: 'Language',
                trailingText: 'English',
                hasChevron: true,
              ),
              const SizedBox(height: 16),

              // ── Security ──────────────────────────────────────────────
              _SectionLabel(title: 'Security'),
              _SettingRow(
                icon: Icons.lock_outline_rounded,
                label: AppStrings.enablePin,
                hasToggle: true,
                toggleValue: settings.isLockEnabled,
                onToggleChanged: (enabled) {
                  if (enabled) {
                    _showSetPinDialog(context, settings);
                  } else {
                    settings.disableLock();
                  }
                },
              ),
              if (settings.isLockEnabled)
                _SettingRow(
                  icon: Icons.lock_outline_rounded,
                  label: AppStrings.changePin,
                  hasChevron: true,
                  onTap: () => _showChangePinDialog(context, settings),
                ),
              const SizedBox(height: 16),

              // ── Spending Limits ───────────────────────────────────────
              _SectionLabel(title: AppStrings.spendingLimits),
              _SettingRow(
                icon: Icons.account_balance_wallet_outlined,
                label: AppStrings.dailyLimit,
                trailingText: settings.spendingLimit.dailyLimit > 0
                    ? '₹${settings.spendingLimit.dailyLimit.toStringAsFixed(0)}'
                    : 'Not set',
                hasChevron: true,
                onTap: () => _showLimitEditor(
                    context, 'Daily Limit', settings.spendingLimit.dailyLimit,
                    (val) => settings.setDailyLimit(val)),
              ),
              _SettingRow(
                icon: Icons.calendar_month_rounded,
                label: AppStrings.monthlyLimit,
                trailingText: settings.spendingLimit.monthlyLimit > 0
                    ? '₹${settings.spendingLimit.monthlyLimit.toStringAsFixed(0)}'
                    : 'Not set',
                hasChevron: true,
                onTap: () => _showLimitEditor(
                    context, 'Monthly Limit', settings.spendingLimit.monthlyLimit,
                    (val) => settings.setMonthlyLimit(val)),
              ),
              const SizedBox(height: 16),

              // ── Support ───────────────────────────────────────────────
              _SectionLabel(title: 'Support'),
              _SettingRow(
                icon: Icons.help_outline_rounded,
                label: 'Help Center',
                hasChevron: true,
              ),
              const SizedBox(height: 32),

              // Version
              const Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSetPinDialog(BuildContext context, SettingsProvider settings) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set PIN'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscureText: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(hintText: 'Enter 4-digit PIN'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.cancel)),
          ElevatedButton(
            onPressed: () {
              if (controller.text.length == 4) {
                settings.enableLock(controller.text);
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }

  void _showChangePinDialog(BuildContext context, SettingsProvider settings) {
    final oldC = TextEditingController();
    final newC = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldC, maxLength: 4, obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(hintText: 'Current PIN'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: newC, maxLength: 4, obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(hintText: 'New PIN'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.cancel)),
          ElevatedButton(
            onPressed: () async {
              if (oldC.text.length == 4 && newC.text.length == 4) {
                final ok = await settings.changePin(oldC.text, newC.text);
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(ok ? 'PIN changed' : 'Incorrect PIN'),
                  ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }

  void _showLimitEditor(BuildContext context, String label, double current,
      ValueChanged<double> onChanged) {
    final controller = TextEditingController(
        text: current > 0 ? current.toStringAsFixed(0) : '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Set $label'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            prefixText: '₹ ',
            hintText: 'Enter amount',
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.cancel)),
          ElevatedButton(
            onPressed: () {
              onChanged(double.tryParse(controller.text) ?? 0);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }
}

/// Section label.
class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 24, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

/// Individual setting row with icon container, label, toggle/chevron.
class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasToggle;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggleChanged;
  final bool hasChevron;
  final String? trailingText;
  final bool isDanger;
  final VoidCallback? onTap;

  const _SettingRow({
    required this.icon,
    required this.label,
    this.hasToggle = false,
    this.toggleValue,
    this.onToggleChanged,
    this.hasChevron = false,
    this.trailingText,
    this.isDanger = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDanger
                      ? AppColors.expense.withOpacity(0.1)
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon,
                    size: 20,
                    color: isDanger ? AppColors.expense : AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDanger
                        ? AppColors.expense
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              if (hasToggle && toggleValue != null)
                GestureDetector(
                  onTap: () => onToggleChanged?.call(!toggleValue!),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 48,
                    height: 28,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: toggleValue!
                          ? AppColors.primary
                          : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      alignment: toggleValue!
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              if (trailingText != null) ...[
                Text(
                  trailingText!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 4),
              ],
              if (hasChevron)
                const Icon(Icons.chevron_right_rounded,
                    size: 20, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
