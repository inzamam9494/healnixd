import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healnixd/components/medicine_stock_card.dart'; // For SystemNavigator.pop()

class ExitConfirmation extends StatelessWidget {
  final Widget child;

  const ExitConfirmation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent automatic pop
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        bool? shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text("Exit App"),
            content: const Text("Are you sure you want to exit the healnixd?"),
            actions: [
              dialogButton(
                text: "Cancel",
                color: Colors.white,
                textColor: Colors.grey,
                onPressed: () => Navigator.of(context).pop(false),
              ),
             dialogButton(
                text: "Exit",
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );

        if (shouldExit == true) {
          // Properly exit the app
          SystemNavigator.pop();
        }
      },
      child: child,
    );
  }
}
