import 'package:empty_feature_folder/features/main/presentation/bloc/main_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../user/presentation/pages/user_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: const Color(0xff36B8B8),
            centerTitle: true,
            title: const Text('Settings'),
            elevation: 0,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  height: 80,
                  decoration: ShapeDecoration(
                    color: const Color(0x33B5E2E2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5,top: 10),
                    child: ListTile(
                      leading: Container(
                        decoration: const ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Color(0xFF35B7B7)),
                          ),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(2.0),
                          child: _firebaseAuth.currentUser?.photoURL == null
                              ? const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                              : Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(_firebaseAuth.currentUser!.photoURL.toString()),
                                fit: BoxFit.fill,
                              ),
                              shape: const OvalBorder(),
                            ),
                          ),
                        ),
                      ),
                      title: Text(_firebaseAuth.currentUser!.email.toString()),

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UserPage(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.userPen),
                        title: Text('Edit Profile'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        state.dbRef?.remove();
                        FirebaseAuth.instance.currentUser!.delete();
                        await FirebaseAuth.instance.signOut();
                      },
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.trash),
                        title: Text('Delete account'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    InkWell(
                      enableFeedback: true,
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                        title: Text('Logout'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
