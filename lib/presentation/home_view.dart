import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/apimethods.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/presentation/add_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;


  @override
  void initState() {
    getValues();
  }

  getValues()async{
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    getValues(String id ,double amount){
        if (id == "bitcoin") {
          return bitcoin * amount;
        }else  if (id == "ethereum") {
          return ethereum * amount;
        }else if (id == "tether") {
          return tether * amount;
        }
      }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
        ),
        child: SafeArea(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('Coins')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs.map(
                    (document) {
                    String? hello =  getValues(document.id,document.data()['Amount'])?.toStringAsFixed(2);
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                "Coin name : ${document.id}"),
                                 Text("Amount owned :₹${hello}"),
                                 IconButton(onPressed: ()async{
                                 await removeCoin(document.id);
                                 }, icon: Icon(Icons.remove)),
                                
                          ],
                        ),
                      );
                    },
                  ).toList(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddView();
              },
            ),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.black,
      ),
    );
  }
}
