import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/presentation/name_age.dart';
import 'package:flutter/material.dart';
class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = ["bitcoin", "tether", "ethereum"];

  String dropDownValue = "bitcoin";
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: dropDownValue,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      dropDownValue = value;
                    });
                  }
                },
                items:
                    // coins .map<DropdownMenuItem<String>>((String value) {
                    //   return DropdownMenuItem<String> (value: value,child: Text(value),);
                    // }).toList(),
                    // )
                    [
                  for (String value in coins)
                    DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    )
                ],
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: "Coin Amount",
                
                  ),
                ),
              ),
                          SizedBox(height: 10,),
                
              Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green),
                    child: MaterialButton(
                     onPressed: ()async {
                       //TODO ADD   
                       await addCoin(dropDownValue, amountController.text);
                       Navigator.of(context).pop();
                     },
                      child: Text("Add"),
                    ),
                  ),
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return NameAndAge();
                },));
              }, icon: Icon(Icons.abc))
                  
            ],
          ),
        ),
      ),
    );
  }
}
