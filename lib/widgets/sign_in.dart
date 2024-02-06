import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function updateUserSignedIn;

  const SignIn({super.key, required this.updateUserSignedIn});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submitData() async {
    final inputEmail = _emailController.text;
    final inputPass = _passwordController.text;
    if (inputPass.isEmpty || inputEmail.isEmpty) return;

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: inputEmail, password: inputPass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    print("Currently logged in!!!!!");
    widget.updateUserSignedIn();

    Navigator.of(context)
        .pop(); //imame stack na widgets, za da se vratime nazad
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      //style na containerot, stava padding na site strani
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email:"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password:"),
              onSubmitted: (_) => _submitData),
          ElevatedButton(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onPressed: _submitData,
            child: Text("Submit!"),
            style: ElevatedButton.styleFrom(
                primary: Colors.purple[100],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
