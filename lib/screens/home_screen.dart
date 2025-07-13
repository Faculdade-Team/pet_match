import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_match/widgets/header_logo_widget.dart';
import '../widgets/pet_match_bottom_nav_bar.dart';
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
      bottomNavigationBar: PetMatchBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            context.go('/home');
          } else if (index == 1) {
            context.go('/adoption');
          } else if (index == 2) {
            // userProvider.logout();
            context.go('/profile');
          } else if (index == 3) {
            context.go('/');
          }
        },
      ),
    );
  }
}
