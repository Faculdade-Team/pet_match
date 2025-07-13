import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_match/model/user.dart';
import 'package:pet_match/widgets/header_logo_widget.dart';
import 'package:pet_match/widgets/pet_match_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../model/user_dao.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _cellphoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _cellphoneController = TextEditingController(text: user?.cellphone ?? '');
    _passwordController = TextEditingController(text: user?.password ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cellphoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    if (user == null) return;

    final allUsers = await UserDAO.carregarUsuarios();
    final emailExists = allUsers.any(
      (u) => u.email == _emailController.text && u.id != user.id,
    );
    if (emailExists) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('E-mail já cadastrado'),
              content: Text('Já existe outro usuário com esse e-mail.'),
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

    final cellphoneExists = allUsers.any(
      (u) => u.cellphone == _cellphoneController.text && u.id != user.id,
    );
    if (cellphoneExists) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Celular já cadastrado'),
              content: Text(
                'Já existe outro usuário com esse número de celular.',
              ),
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

    final updatedUser = User(
      id: user.id,
      name: _nameController.text,
      email: _emailController.text,
      cellphone: _cellphoneController.text,
      password: _passwordController.text,
    );
    await UserDAO.atualizar(updatedUser);
    userProvider.setUser(updatedUser);
    setState(() {
      _editing = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Dados atualizados com sucesso!')));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Perfil')),
        body: Center(child: Text('Nenhum usuário logado.')),
      );
    }
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
                      'Perfil',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      controller: _nameController,
                      enabled: _editing,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Digite seu nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      enabled: _editing,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Digite seu e-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _cellphoneController,
                      enabled: _editing,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Digite seu celular',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      enabled: _editing,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Digite sua senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    if (_editing)
                      ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        child: Text(
                          'Salvar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    else
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _editing = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        child: Text(
                          'Editar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    if (_editing)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            final user =
                                Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).user;
                            if (user != null) {
                              setState(() {
                                _nameController.text = user.name;
                                _emailController.text = user.email;
                                _cellphoneController.text = user.cellphone;
                                _passwordController.text = user.password;
                                _editing = false;
                              });
                            } else {
                              setState(() {
                                _editing = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
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
        currentIndex: 2,
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
