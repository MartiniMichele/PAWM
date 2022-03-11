import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPage.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  ErrorPage(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(message),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
          onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage())),
              },
          child: Text("clicca per tornare alla home"))
    ]);
  }
}
