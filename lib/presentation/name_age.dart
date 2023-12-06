// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:crypto_wallet/net/flutterfire.dart';

class NameAndAge extends StatelessWidget {
   NameAndAge({super.key});
final name = TextEditingController();
final age = TextEditingController();
 String collection = "Datas";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              TextFormField(
                    controller: name,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Outline color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black), // Outline color when focused
                      ),
                    ),
                  ),
                      TextFormField(
                    controller: age,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Outline color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black), // Outline color when focused
                      ),
                    ),
                  ),
                   Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: MaterialButton(
                   onPressed: () {
                     addDataToFirebase(collection, Name(name: name.text, age: age.text).toMap());
                   },
                      child: Text("Register"),
                    ),
                  ),
                  ],
                ),
          )),
    );
  }
}

Map<String,dynamic> hello = {"hello":1,  "age": 30,
  "email": "johndoe@example.com",
  "isSubscribed": true,
    "street": "123 Main St",
    "city": "Anytown",
    "zipCode": "12345"};

class Name {
  String name;
  String age;
  Name({
    required this.name,
    required this.age,
  });

  Name copyWith({
    String? name,
    String? age,
  }) {
    return Name(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      name: map['name'] as String,
      age: map['age'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) => Name.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Name(name: $name, age: $age)';

  @override
  bool operator ==(covariant Name other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}


