import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak password') {
      print('the password is too weak');
    } else if (e.code == 'email already in use') {
      print('The account already exist for this email');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

// Future<bool> addCoin(String id, String amount) async {
//   try {
//     String uid = FirebaseAuth.instance.currentUser!.uid;
//     var value = double.parse(amount);
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection('Users')
//         .doc(uid)
//         .collection('Coins')
//         .doc(id);
//     FirebaseFirestore.instance.runTransaction(
//       (transaction) async {
//         DocumentSnapshot snapshot = await transaction.get(documentReference);
//         if (!snapshot.exists) {
//           documentReference.set({"Amount": value});
//           return true;
//         }
//         double newAmount = snapshot.data()?['Amount'] + value;
//         transaction.update(documentReference, {'Amount': newAmount});
//         return true;
//       },
//     );
//     return true;
//   } catch (e) {
//     return false;
//   }
// }
Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);

    // Create a Map containing the data you want to update
    Map<String, dynamic> data = {
      "Amount": value,
      // Add other fields as needed
    };

    // Use a transaction to safely update the document
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        // If the document doesn't exist, set it with the initial data
        transaction.set(documentReference, data);
      } else {
        // If the document exists, update the 'Amount' field
        data['Amount'] = value; // Update the 'Amount' field with the new value
        transaction.update(documentReference, data);
      }

      // Return true inside the transaction
      return true;
    });

    // Transaction completed successfully
    return true;
  } catch (e) {
    // Handle any errors that occur during the process
    print("Error: $e");
    return false;
  }
}

Future<bool> addDataToFirebase(
    String collectionName, Map<String, dynamic> data) async {
  try {
    // Initialize Firebase if not already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    // Reference to the Firestore collection
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);

    // Add data to Firestore
    await collection.add(data);

    // Data added successfully
    return true;
  } catch (e) {
    // Handle any errors that occur during the process
    print("Error: $e");
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}

// Future<bool> addDataToFirebase(String collectionName, String data) async {
//   try {
//     // Initialize Firebase if not already initialized
//     if (Firebase.apps.isEmpty) {
//       await Firebase.initializeApp();
//     }
//     print("heelllllooooo");
//     // Reference to the Firestore collection
//     CollectionReference collection = FirebaseFirestore.instance.collection(collectionName);

//     // Add data to Firestore
//     await collection.add(data);

//     // Data added successfully
//     return true;
//   } catch (e) {
//     // Handle any errors that occur during the process
//     print("Error: $e");
//     return false;
//   }
// }