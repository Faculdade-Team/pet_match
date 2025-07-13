import 'package:go_router/go_router.dart';
import 'package:pet_match/screens/adoption_form.dart';
import 'package:pet_match/screens/adoption_screen.dart';
import 'package:pet_match/screens/home_screen.dart';
import 'package:pet_match/screens/login_screen.dart';
import 'package:pet_match/screens/profile_screen.dart';
import 'package:pet_match/screens/sign_up_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/adoption',
      builder: (context, state) => const AdoptionScreen(),
    ),
    GoRoute(
      path: '/adoption/form',
      builder: (context, state) => const AdoptionForm(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
