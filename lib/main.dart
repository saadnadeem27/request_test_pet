import 'package:flutter/material.dart';
import 'package:request_test/model/request_manager.dart';
import 'package:request_test/views/add_post_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final RequestManager requestManager = RequestManager();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Request Management App',
      home: AddPostScreen(),
    );
  }
}
