import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/CreaSchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPage.dart';

class ThreeButtons extends StatelessWidget {
  var _buttonText = [];
  ThreeButtons(this._buttonText);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()))},
            child: Text(_buttonText.first),
            style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
          ),
          const SizedBox(
            height: 50,
          ),
          //metodo senza parentesi perché è un riferimento ad esso
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()))},
            child: Text(_buttonText[1]),
            style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()))},
            child: Text(_buttonText.last),
            style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
          )
        ],
      ),
    );
  }
}
