import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:request_test/utils/utils.dart';
import 'package:request_test/views/request_screen.dart';

import '../controller/controller.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final idController = TextEditingController();
  final descController = TextEditingController();
  final controller = Get.put(MyController());
  File? imageFile;
  void getImage() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        imageFile = File(pick.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data for Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageFile != null
                    ? Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(imageFile!),
                          ),
                        ),
                      )
                    : Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            getImage();
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Upload'),
                              Icon(Icons.file_upload),
                            ],
                          ),
                        )),
                      ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                      hintText: 'Enter Desc', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (imageFile != null && descController.text.isNotEmpty) {
                      controller.addPost(
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          descController.text,
                          imageFile!);
                      showToast('Post Added');
                      descController.clear();
                      setState(() {
                        imageFile = null;
                      });
                    } else {
                      if (imageFile == null && descController.text.isEmpty) {
                        showToast('Fields must be filled');
                      } else if (descController.text.isEmpty) {
                        showToast('desciption must be added');
                      } else if (imageFile == null) {
                        showToast('Image must be added');
                      }
                      // else if (imageFile != null &&
                      //     descController.text.isNotEmpty) {
                      //   showToast('Fields must be filled');
                      // }
                    }
                  },
                  child: const Text('Add Post'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestScreen(),
                      ),
                    );
                  },
                  child: const Text('Request Screen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
