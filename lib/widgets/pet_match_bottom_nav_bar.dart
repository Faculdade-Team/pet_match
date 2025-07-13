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
      selectedItemColor: const Color.fromARGB(255, 114, 203, 245),
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: const Color.fromARGB(255, 118, 207, 235),
      ),
      unselectedIconTheme: IconThemeData(color: Colors.white),
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.dog),
          label: 'Adoção',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.rightFromBracket),
          label: 'Sair',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
