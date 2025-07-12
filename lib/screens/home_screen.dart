import 'package:flutter/material.dart';
import 'package:pet_match/widgets/header_logo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      body: Column(
        children: [
          HeaderLogoWidget(),
          SizedBox(height: 24),
          Text(
            'Bem-vindo ao PetMatch, ${user?.name}!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Image.asset(
            'lib/assets/pet_home.png',
            height: 300,
            fit: BoxFit.contain,
          ),
          Text(
            "Adote um Pet, ajude a salvar vidas!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade800,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.dog, color: Colors.white),
            label: 'Adoção',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cat, color: Colors.white),
            label: 'SOS',
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
        currentIndex: 0,
        onTap: (index) {
          // Adicione a navegação aqui se necessário
        },
      ),
    );
  }
}
