import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/api/api_service.dart';
import 'package:flutter_login_app/common/styles.dart';
import 'package:flutter_login_app/provider/user_provider.dart';
import 'package:flutter_login_app/ui/login_screen.dart';
import 'package:flutter_login_app/widget/custom_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var isVerified = false;

  @override
  void initState() {
    super.initState();
    bool emailVerified = auth.currentUser!.emailVerified;

    FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser!.uid}')
        .update({'isVerified': emailVerified});
  }

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    final uid = user?.uid;

    return Scaffold(
        backgroundColor: whiteBackground,
        body: ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(apiService: ApiService()).getUsers(),
          child: Consumer<UserProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                var users = state.resultUser;
                var verifiedUser = users.where((user) {
                  return user.fields.isverified.booleanValue == true;
                }).toList();

                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            'FIlter user by verified email',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: darkPrimaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Switch(
                            value: isVerified,
                            onChanged: (value) {
                              setState(() {
                                isVerified = value;
                              });
                            },
                            activeTrackColor: Colors.yellow[100],
                            activeColor: secondaryColor,
                          ),
                        ],
                      ),
                      ListView(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          isVerified ? verifiedUser.length : users.length,
                          (index) {
                            return container(context,
                                isVerified ? verifiedUser : users, index);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: darkPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        color: secondaryColor,
                        textTheme: ButtonTextTheme.primary,
                        height: 53,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut().whenComplete(
                                () => Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginScreen.routeName,
                                      (route) => false,
                                    ));
                          } on FirebaseAuthException catch (e) {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: 'Log Out Gagal',
                                  descriptions:
                                      'Error: ${e.message}. Silahkan coba lagi beberapa saat kemudian!',
                                  text: 'OK',
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else if (state.state == ResultState.NoData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.Error) {
                return Center(
                    child: Column(
                  children: <Widget>[
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            foregroundColor: darkPrimaryColor,
                            textStyle: Theme.of(context).textTheme.bodyMedium),
                        child: const Text(
                          "Log Out",
                        ),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut().whenComplete(
                                () => Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginScreen.routeName,
                                      (route) => false,
                                    ));
                          } on FirebaseAuthException catch (e) {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: 'Log Out Gagal',
                                  descriptions:
                                      'Error: ${e.message}. Silahkan coba lagi beberapa saat kemudian!',
                                  text: 'OK',
                                );
                              },
                            );
                          }
                        }),
                    CircleAvatar(
                      child: Icon(Icons.wifi_off, color: primaryColor),
                      backgroundColor: secondaryColor,
                    ),
                    const Text('Tidak ada koneksi',
                        style: TextStyle(color: Colors.black))
                  ],
                ));
              } else {
                return const Center(
                    child:
                        Text('error', style: TextStyle(color: Colors.black)));
              }
            },
          ),
        ));
  }

  Widget container(BuildContext context, users, idx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Nama:', style: Theme.of(context).textTheme.bodySmall),
          Text(
            '${users[idx].fields.nama.value}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 15),
          Text('Email:', style: Theme.of(context).textTheme.bodySmall),
          Text(
            '${users[idx].fields.email.value}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
