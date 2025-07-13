import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_match/widgets/header_logo_widget.dart';
import 'package:provider/provider.dart';
import '../providers/adoption_provider.dart';
import '../model/user_dao.dart';
import '../model/user.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({super.key});

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  Map<int, User> _user = {};

  Future<void> _loadUsers(int userId) async {
    final user = await UserDAO.buscarPorId(userId);
    setState(() {
      _user = {if (user != null) user.id!: user};
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final adoptions =
          await Provider.of<AdoptionProvider>(
            context,
            listen: false,
          ).getAllAdoptions();
      Provider.of<AdoptionProvider>(
        context,
        listen: false,
      ).setAdoptions(adoptions);
      await _loadUsers(adoptions.map((a) => a.userId).toList().first);
    });
  }

  @override
  Widget build(BuildContext context) {
    final adoptionProvider = Provider.of<AdoptionProvider>(context);
    final adoptions = adoptionProvider.adoptions;

    return Scaffold(
      body: Column(
        children: [
          const HeaderLogoWidget(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Adoção de Pets',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.plus, size: 28),
                  onPressed: () {
                    context.go('/adoption/form');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child:
                adoptions.isEmpty
                    ? Center(child: Text('Nenhum pet para adoção.'))
                    : ListView.builder(
                      itemCount: adoptions.length,
                      itemBuilder: (context, index) {
                        final adoption = adoptions[index];
                        final user = _user[adoption.userId];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 128, 0, 0.15),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Color.fromRGBO(0, 128, 0, 0.2),
                                width: 1.2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (adoption.imagePath != null)
                                      ? CircleAvatar(
                                        radius: 32,
                                        backgroundImage:
                                            Image.file(
                                              adoption.imagePath!,
                                            ).image,
                                      )
                                      : Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.paw,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          adoption.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text(
                                              'Raça: ',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(adoption.breed),
                                            SizedBox(width: 12),
                                            Text(
                                              'Idade: ',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(adoption.age),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              'Saúde: ',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(adoption.healthStatus),
                                            SizedBox(width: 12),
                                            Text(
                                              'Porte: ',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(adoption.size),
                                          ],
                                        ),
                                        if (user != null) ...[
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                'Postado por: ',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(user.name),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                'WhatsApp: ',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(user.cellphone),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
