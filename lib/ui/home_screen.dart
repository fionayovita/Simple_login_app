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

  @override
  State<HomeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var isVerified = false;

  @override
  void initState() {
    // TODO: implement initState
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
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                var users = state.resultUser;
                var sortedUser1 = users.where((user) {
                  return user.fields.isverified.booleanValue == true;
                }).toList();
                var sortedUser2 = users.where((user) {
                  return user.fields.isverified.booleanValue == false;
                }).toList();

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                          child: Text(
                            'Verified',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: darkPrimaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          color: isVerified ? secondaryColor : lightBlue,
                          textTheme: ButtonTextTheme.primary,
                          height: 53,
                          minWidth: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () async {
                            setState(() {
                              isVerified = !isVerified;
                            });
                          }),
                      ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          users.length,
                          (index) {
                            return container(
                                context,
                                isVerified ? sortedUser1 + sortedUser2 : users,
                                index);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
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
                            padding: EdgeInsets.all(0),
                            foregroundColor: darkPrimaryColor,
                            textStyle: Theme.of(context).textTheme.bodyMedium),
                        child: Text(
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
                    Text('Tidak ada koneksi',
                        style: TextStyle(color: Colors.black))
                  ],
                ));
              } else {
                return Center(
                    child:
                        Text('error', style: TextStyle(color: Colors.black)));
              }
            },
          ),
        ));
  }

  Widget container(BuildContext context, users, idx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
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
          SizedBox(height: 15),
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
