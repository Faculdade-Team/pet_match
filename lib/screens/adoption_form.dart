import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_match/model/adoption.dart';
import 'package:pet_match/model/adoption_dao.dart';
import 'package:pet_match/providers/user_provider.dart';
import 'package:pet_match/widgets/header_logo_widget.dart';
import 'package:pet_match/widgets/pet_match_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class AdoptionForm extends StatefulWidget {
  const AdoptionForm({super.key});

  @override
  State<AdoptionForm> createState() => _AdoptionFormState();
}

class _AdoptionFormState extends State<AdoptionForm> {
  late TextEditingController _nameController;
  late TextEditingController _healthStatusController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;
  late TextEditingController _sizeController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _healthStatusController = TextEditingController();
    _breedController = TextEditingController();
    _ageController = TextEditingController();
    _sizeController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _healthStatusController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  Future<void> onSubmit(int? userId) async {
    if (_nameController.text.isEmpty ||
        _healthStatusController.text.isEmpty ||
        _breedController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _sizeController.text.isEmpty) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Atenção'),
              content: Text('Por favor, preencha todos os campos.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
      return;
    }

    final count = await AdoptionDAO.countAdoptionsByUser(userId!);
    if (count >= 3) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Limite atingido'),
              content: Text('Você só pode cadastrar até 3 pets para adoção.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
      return;
    }

    Adoption adoption = Adoption(
      id: null,
      userId: userId,
      name: _nameController.text,
      healthStatus: _healthStatusController.text,
      breed: _breedController.text,
      age: _ageController.text,
      size: _sizeController.text,
      imagePath: _imageFile,
    );

    await AdoptionDAO.inserir(adoption);

    if (mounted) context.go('/adoption');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderLogoWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Adicionar para Adoção',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.paw),
                        hintText: 'Nome do pet',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      controller: _nameController,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.heart),
                        hintText: 'Estado de Saúde',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      controller: _healthStatusController,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.dog),
                        hintText: 'Raça do Pet',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      controller: _breedController,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.calendar),
                        hintText: 'Idade',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      controller: _ageController,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.rulerVertical),
                        hintText: 'Porte',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      controller: _sizeController,
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        onSubmit(user?.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      child: Text(
                        'Adicionar para Adoção',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
            context.go('/profile');
          } else if (index == 3) {
            context.go('/');
          }
        },
      ),
    );
  }
}
