import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/common/styles.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _namaController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureTextPassword = true;
  bool _obscureTextPasswordConfrim = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 700) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20.0),
                  child: _textField(context));
            } else if (constraints.maxWidth <= 1100) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 120.0, vertical: 20.0),
                  child: _textField(context));
            } else {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 200.0, vertical: 20.0),
                  child: _textField(context));
            }
          },
        ),
      ),
    );
  }

  Widget _textField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
          Hero(
            tag: 'Register',
            child: Text(
              'Register',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            'Create an account',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            style: TextStyle(color: darkPrimaryColor),
            controller: _namaController,
            validator: (text) {
              if (text != null && text.isNotEmpty) {
                if (text.length >= 3 && text.length <= 50) {
                  return null;
                } else {
                  return "Name must be more than 2 characters and less then 50 characters";
                }
              } else {
                return "Name can't be empty";
              }
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'Name',
              hintStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            style: TextStyle(color: darkPrimaryColor),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (text) {
              if (text != null && text.isNotEmpty) {
                return null;
              } else {
                return "Email can't be empty!";
              }
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'Email',
              hintStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            style: TextStyle(color: darkPrimaryColor),
            cursorColor: darkPrimaryColor,
            controller: _passwordController,
            obscureText: _obscureTextPassword,
            validator: (text) {
              if (text != null && text.isNotEmpty) {
                String? message;
                if (!RegExp(".*[0-9].*").hasMatch(text)) {
                  message ??= '';
                  message += 'Password should contain a numeric value 1-9. ';
                }
                if (!RegExp('.*[a-z].*').hasMatch(text)) {
                  message ??= '';
                  message += 'Password should contain a lowercase letter a-z. ';
                }
                if (!RegExp('.*[A-Z].*').hasMatch(text)) {
                  message ??= '';
                  message +=
                      'Password should contain an uppercase letter A-Z. ';
                }
                return message;
              } else {
                return "Password can't be empty";
              }
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'Password',
              hintStyle: Theme.of(context).textTheme.labelLarge,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: darkPrimaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureTextPassword = !_obscureTextPassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            style: TextStyle(color: darkPrimaryColor),
            cursorColor: primaryColor,
            controller: _confirmPasswordController,
            obscureText: _obscureTextPasswordConfrim,
            validator: (text) {
              if (text != null && text.isNotEmpty) {
                if (text == _passwordController.text) {
                  return null;
                } else {
                  return "Confirmation password doesn't match";
                }
              } else {
                return "Password can't be empty";
              }
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'Confirmation Password',
              hintStyle: Theme.of(context).textTheme.labelLarge,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureTextPasswordConfrim
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: darkPrimaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureTextPasswordConfrim = !_obscureTextPasswordConfrim;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          MaterialButton(
              child: Text('Register',
                  style: Theme.of(context).textTheme.bodyMedium),
              color: secondaryColor,
              textTheme: ButtonTextTheme.primary,
              height: 53,
              minWidth: MediaQuery.of(context).size.width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                if (!_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = false;
                  });
                  return;
                } else {
                  try {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final nama = _namaController.text;

                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    await _auth.currentUser?.sendEmailVerification();

                    _store.collection('users').doc(_auth.currentUser?.uid).set({
                      'email': email,
                      'password': password,
                      'nama': nama,
                      'isVerified': _auth.currentUser?.emailVerified
                    });
                  } catch (e) {
                    final snackbar = SnackBar(content: Text(e.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } finally {
                    setState(
                      () {
                        _isLoading = false;
                      },
                    );
                    Navigator.pop(context);
                  }

                  return;
                }
              }),
          TextButton(
            child: Text('Already have an acoount? Log In',
                style: Theme.of(context).textTheme.bodyMedium),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
