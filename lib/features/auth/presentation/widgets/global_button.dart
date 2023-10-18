import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const GlobalButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
          decoration: ShapeDecoration(
            color: const Color(0xFF35B7B7),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child:  Center(
            child: Text(
              buttonName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
    );
  }
}
