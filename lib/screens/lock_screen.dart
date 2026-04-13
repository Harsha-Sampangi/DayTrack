import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../services/lock_service.dart';

/// Lock screen — 4-digit PIN pad with optional biometric button.
///
/// Shown on app launch when app lock is enabled.
class LockScreen extends StatefulWidget {
  final VoidCallback onUnlocked;

  const LockScreen({super.key, required this.onUnlocked});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen>
    with SingleTickerProviderStateMixin {
  String _pin = '';
  bool _hasError = false;
  bool _biometricAvailable = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    _checkBiometric();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _checkBiometric() async {
    final available = await LockService.isBiometricAvailable();
    if (mounted) setState(() => _biometricAvailable = available);
    if (available) _tryBiometric();
  }

  Future<void> _tryBiometric() async {
    final ok = await LockService.authenticateWithBiometrics();
    if (ok) widget.onUnlocked();
  }

  void _onDigit(String digit) {
    if (_pin.length >= 4) return;
    setState(() {
      _pin += digit;
      _hasError = false;
    });

    if (_pin.length == 4) {
      _verifyPin();
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
      _hasError = false;
    });
  }

  Future<void> _verifyPin() async {
    final ok = await LockService.verifyPin(_pin);
    if (ok) {
      widget.onUnlocked();
    } else {
      setState(() {
        _hasError = true;
        _pin = '';
      });
      _shakeController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            // Lock icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock_rounded,
                  size: 40, color: AppColors.primary),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              'Enter PIN',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              _hasError ? 'Incorrect PIN. Try again.' : 'Enter your 4-digit PIN',
              style: TextStyle(
                color: _hasError ? AppColors.error : AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),

            // PIN dots
            AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    _shakeController.isAnimating
                        ? _shakeAnimation.value *
                            ((_shakeController.value * 10).round().isEven
                                ? 1
                                : -1)
                        : 0,
                    0,
                  ),
                  child: child,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final filled = i < _pin.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hasError
                          ? AppColors.error
                          : filled
                              ? AppColors.primary
                              : Colors.transparent,
                      border: Border.all(
                        color: _hasError
                            ? AppColors.error
                            : filled
                                ? AppColors.primary
                                : AppColors.textSecondary,
                        width: 2,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const Spacer(),

            // Number pad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                children: [
                  for (int row = 0; row < 3; row++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int col = 1; col <= 3; col++)
                          _PadButton(
                            label: '${row * 3 + col}',
                            onTap: () => _onDigit('${row * 3 + col}'),
                          ),
                      ],
                    ),
                  // Last row: biometric / 0 / backspace
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _biometricAvailable
                          ? _PadButton(
                              icon: Icons.fingerprint_rounded,
                              onTap: _tryBiometric,
                            )
                          : const SizedBox(width: 72),
                      _PadButton(
                        label: '0',
                        onTap: () => _onDigit('0'),
                      ),
                      _PadButton(
                        icon: Icons.backspace_rounded,
                        onTap: _onBackspace,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

/// Single PIN pad button.
class _PadButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  const _PadButton({this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(36),
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Center(
            child: label != null
                ? Text(
                    label!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  )
                : Icon(icon, color: AppColors.textSecondary, size: 24),
          ),
        ),
      ),
    );
  }
}
