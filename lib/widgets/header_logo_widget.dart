import 'package:flutter/material.dart';

class HeaderLogoWidget extends StatelessWidget {
  const HeaderLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: Colors.green,
      child: Column(
        children: [
          Image.asset('lib/assets/pet-match_logo.png', height: 100),
          const SizedBox(height: 16),
          const Text(
            'PetMatch',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
