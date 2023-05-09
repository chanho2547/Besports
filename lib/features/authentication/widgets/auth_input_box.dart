import 'package:flutter/material.dart';

const Color myGreen = Color.fromRGBO(50, 210, 0, 1);
const Color myBlack = Color.fromRGBO(28, 29, 27, 1);
const Color myDarkGray = Color.fromRGBO(45, 49, 44, 1);
const Color myLightGray = Color.fromRGBO(181, 181, 181, 1);

class AuthInputBox extends StatefulWidget {
  final String inputInfo;

  const AuthInputBox({
    super.key,
    required this.inputInfo,
  });

  @override
  State<AuthInputBox> createState() => _AuthInputBoxState();
}

class _AuthInputBoxState extends State<AuthInputBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FractionallySizedBox(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              // make InputDecoration border rounded

              // make input box background color as myDarkGray
              filled: true,
              fillColor: myDarkGray,
              enabledBorder: OutlineInputBorder(
                //make OutlineInputBorder border rounded
                borderRadius: BorderRadius.all(Radius.circular(16)),

                borderSide: BorderSide(
                  color: myDarkGray,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                  color: myGreen,
                ),
              ),
              // make input box hint text color as myGreen
              hintText: '이메일',
              hintStyle: TextStyle(
                color: Colors.white60,
              ),
            ),
            onChanged: (String value) {
              //id = value;
            },
          ),
        ),
      ),
    );
  }
}
