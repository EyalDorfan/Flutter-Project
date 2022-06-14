import 'package:flutter/material.dart';
import 'package:flutter2/views/layout_view.dart';

class WorkExperience extends StatelessWidget {
  const WorkExperience({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LayoutDesigner();
            }));
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
