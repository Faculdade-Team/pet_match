import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetMatchBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PetMatchBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green.shade800,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.dog, color: Colors.white),
          label: 'Adoção',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user, color: Colors.white),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.rightFromBracket, color: Colors.white),
          label: 'Sair',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
