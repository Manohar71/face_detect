import 'package:flutter/material.dart';

class info extends StatelessWidget {
  const info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title: Center(child: Text("About us")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
                'Ur Face app detects many face emotions of human with high level machine learnings tecqniques and we are going to give suggestions based on your emotion which makes you to change the mood and many more we are updating soon...',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
