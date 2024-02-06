import 'dart:math';

import 'package:flutter/material.dart';
import 'package:auth5/model/termin.dart';

class NewTermin extends StatefulWidget {
  final Function addTermin;

  const NewTermin({super.key, required this.addTermin});

  @override
  State<NewTermin> createState() => _NewTerminState();
}

class _NewTerminState extends State<NewTermin> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();


  void _submitData() {
    final inputName = _nameController.text;
    final inputTime = _timeController.text;
    final inputDate=_dateController.text;
    if (inputTime.isEmpty || inputName.isEmpty|| inputDate.isEmpty) return;

    final newTermin = Termin(Random().nextInt(15), inputName, inputTime, inputDate);

    widget.addTermin(newTermin);//prethodno definiravme propery f-ja: final Function addTodo;


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
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name:"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: "Time:"),
              onSubmitted: (_) => _submitData),
          TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: "Date:"),
              onSubmitted: (_) => _submitData),
          ElevatedButton(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
                primary: Colors.purple[100],
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            child: const Text("Submit your activity!"),
          )
        ],
      ),
    );
  }
}
