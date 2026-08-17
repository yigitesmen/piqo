import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final String text;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () async {
                setState(() => isEnabled = false);
                await widget.onPressed();
                setState(() => isEnabled = true);
              }
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          disabledForegroundColor: Theme.of(context).primaryColor,
          disabledBackgroundColor: Colors.white.withValues(alpha: 0.6),
          elevation: 6,
          shadowColor: Colors.black.withValues(alpha: 0.35),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        ),
        child: isEnabled
            ? Text(
                widget.text,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.2,
                ),
              )
            : SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 3,
                ),
              ),
      ),
    );
  }
}
