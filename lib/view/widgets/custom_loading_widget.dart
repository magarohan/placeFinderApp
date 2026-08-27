import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String? message;
  final bool isOverlay;

  const CustomLoadingWidget({super.key, this.message, this.isOverlay = false});

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ],
    );

    if (isOverlay) {
      return Container(
        color: Colors.black.withValues(alpha: 0.5),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: content,
        ),
      );
    }

    return Center(child: content);
  }
}
