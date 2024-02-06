import 'dart:ffi';

import 'package:auth5/model/termin.dart';
import 'package:auth5/widgets/add_termin.dart';
import 'package:auth5/widgets/sign_in.dart';
import 'package:auth5/widgets/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool userSignedIn = (FirebaseAuth.instance.currentUser != null);
  List<Termin> _termini = [];

  void _addNewTerminToList(Termin termin) {
    setState(() {
      _termini.add(termin);
    });
  }

  void _addTodoFunction() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTermin(//widgetot za dodavanje na nov todo so se naoga vo folderot /widgets
              addTermin: _addNewTerminToList,
            ),
          );
        });
  }

  void _updateSignIn() {
    setState(() {
      userSignedIn = (FirebaseAuth.instance.currentUser != null);
    });
  }

  _signIn() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: SignIn(
              //widgetot za signIn so se naoga vo folderot /widgets
              updateUserSignedIn: _updateSignIn,
            ),
          );
        });
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut();

    _updateSignIn();
    print("Signed out!!!");
  }

  _register() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Register(
              //widgetot za signIn so se naoga vo folderot /widgets
              updateUserSignedIn: _updateSignIn,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userSignedIn ? 'logged in' : 'logged out'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () => (userSignedIn) ? _signOut() : _signIn(),
              icon: (FirebaseAuth.instance.currentUser != null)
                  ? const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.play_arrow_outlined,
                      color: Colors.green,
                    )),
          IconButton(
              onPressed: () => _register(),
              icon: const Icon(
                Icons.account_box,
                color: Colors.yellow,
              )),
          if (userSignedIn)
            IconButton(
                onPressed: _addTodoFunction,
                icon: const Icon(
                  Icons.add_circle_rounded,
                  color: Colors.blue,
                ))
        ],
      ),
      body: GridView.builder(
        itemCount: _termini.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                _termini[index].name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              ),
              subtitle: Text(
                _termini[index].time+"h " +_termini[index].date ,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  setState(() {
                    _termini.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
      ),
    );
  }
}
