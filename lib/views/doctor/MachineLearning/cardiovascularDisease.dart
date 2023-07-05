import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/data.dart';


Future<String> sendPredictionRequest(Data data) async {
  final url = Uri.parse('http://10.0.2.2:8000/predict');
  final headers = {'Content-Type': 'application/json'};
  final requestBody = json.encode(data.toJson());

  final response = await http.post(url, headers: headers, body: requestBody);

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData['prediction'];
  } else {
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}

class CardiovascularDisease extends StatefulWidget {
  CardiovascularDisease({Key? key}) : super(key: key);

  @override
  State<CardiovascularDisease> createState() => _CardiovascularDiseaseState();
}

class _CardiovascularDiseaseState extends State<CardiovascularDisease> {
  final _formKey = GlobalKey<FormState>();
  late Data _data;

  int gender = 1;
  int bp_cat = 0;
  int cholesterol = 1;
  int gluc = 1;


  @override
  void initState() {
    super.initState();
    _data = Data(
      age: 0,
      height: 0,
      weight: 0,
      gender: 0,
      cholesterol: 0,
      gluc: 0,
      bp_cat: 0,
      smoke: false,
      alco: false,
      active: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardiovascular Disease Prediction'),
        backgroundColor: Color(0xff6527BE),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(

                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age',),
                  onChanged: (value) => _data.age = int.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  onChanged: (value) => _data.height = int.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  onChanged: (value) => _data.weight = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Gender'),
                  value: gender,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Women'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Men'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      _data.gender = gender;
                    });
                  },
                ),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Cholesterol'),
                  value: cholesterol,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Normal'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Above Normal'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Well Above Normal'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      cholesterol = value!;
                      _data.cholesterol = cholesterol;
                    });
                  },
                ),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Glucose'),
                  value: gluc,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Normal'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Above Normal'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Well Above Normal'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gluc = value!;
                      _data.gluc = gluc;
                    });
                  },
                ),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Blood Pressure Category'),
                  value: bp_cat,
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Normal'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Elevated'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('High'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Very High'),
                    ),
                    DropdownMenuItem<int>(
                      value: 4,
                      child: Text('Hypertensive Crisis'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      bp_cat = value!;
                      _data.bp_cat = bp_cat;
                    });
                  },
                ),

                CheckboxListTile(
                  fillColor: MaterialStateProperty.all(Color(0xffB28CFF)),
                  title: Text('Smoke'),
                  value: _data.smoke == true,
                  onChanged: (value) {
                    setState(() {
                      _data.smoke = value;
                    });
                  },
                ),
                CheckboxListTile(
                  fillColor: MaterialStateProperty.all(Color(0xffB28CFF)),
                  title: Text('Alcohol intake'),
                  value: _data.alco == true,
                  onChanged: (value) {
                    setState(() {
                      _data.alco = value;
                    });
                  },
                ),
                CheckboxListTile(
                  fillColor: MaterialStateProperty.all(Color(0xffB28CFF)),
                  title: Text('Physical activity'),
                  value: _data.active == true,
                  onChanged: (value) {
                    setState(() {
                      _data.active = value;
                    });
                  },
                ),


                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6527BE),
                    minimumSize: Size(double.infinity, 40),
                  ),
                  onPressed: () {
                    print(_data.toJson());
                    if (_formKey.currentState!.validate()) {
                      sendPredictionRequest(_data).then((prediction) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Prediction Result'),
                              content: Text('Prediction: $prediction'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }).catchError((error) {
                        // Handle request error
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(error.toString()),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
