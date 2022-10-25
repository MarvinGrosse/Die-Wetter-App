import 'dart:developer';

import 'package:die_wetter_app/models/locations.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:weather/weather.dart';

import '../services/database_helper.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  String location = "";

  bool locationExists = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(children: <Widget>[
              TextFormField(
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                  if (value == null ||
                      value.isEmpty ||
                      !regex.hasMatch(value)) {
                    return 'Please enter some text';
                  }
                  if (!locationExists) {
                    return 'Location does not exist';
                  }

                  return null;
                },
                onSaved: (newValue) => location = newValue!,
                decoration: InputDecoration(
                  hintText: ('City Name'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 5.0),
                  ),
                ),
              ),
              ElevatedButton(
                  key: const Key('AddScreenAddButton'),
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)))),
                  onPressed: () async {
                    _formKey.currentState!.save();
                    checkValid(context);
                  },
                  child: const Text('Add'))
            ])),
      ),
    );
  }

  checkValid(BuildContext context) async {
    const String apiKey = '7e12052d9bea3a2d6045ce0bec3bb6d8';

    WeatherFactory ws = WeatherFactory(apiKey);

    try {
      await ws.currentWeatherByCityName(location);
      locationExists = true;
    } catch (e) {
      locationExists = false;
    }
    _formKey.currentState!.validate();

    if (locationExists) {
      await ref.read(databaseProvider).insertLocation(
          Location(id: const Uuid().v4().toString(), name: location));
      const snackBar = SnackBar(
        content: Text('Location added'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop(true);
    }
  }
}
