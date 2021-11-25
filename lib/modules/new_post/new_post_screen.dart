import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Post',
        ),
      ),
    );
  }
}
