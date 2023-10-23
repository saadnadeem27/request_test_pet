import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:request_test/model/request_manager.dart';
import 'package:request_test/views/request_screen.dart';

import '../controller/controller.dart';

class ManageRequestsScreen extends StatefulWidget {
  // List getTotalRequest;
  const ManageRequestsScreen({
    super.key,
  });

  @override
  State<ManageRequestsScreen> createState() => _ManageRequestsScreenState();
}

class _ManageRequestsScreenState extends State<ManageRequestsScreen> {
  final RequestManager reqManager = RequestManager();
  List updatedList = [];
  final controller = Get.put(MyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //updatedList.addAll(widget.getTotalRequest);
    updatedList = List.from(controller.totalSendReq);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Requests'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: ListView.builder(
              itemCount: updatedList.length,
              itemBuilder: (context, index) {
                //Request request = reqManager.sendReq[index];
                print(updatedList.length);
                return ListTile(
                  title: Text(updatedList[index].id.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            //reqManager.acceptRequest(updatedList[index].id);
                            controller.posts.removeWhere((request) =>
                                request.id == updatedList[index].id);
                            controller.acceptRequest(updatedList[index].id);
                            updatedList.removeWhere((request) =>
                                request.id == updatedList[index].id);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Logic for rejecting request goes here
                          setState(() {
                            controller.acceptRequest(updatedList[index].id);

                            for (var i = 0; i < updatedList.length; i++) {
                              if (updatedList[i].id == updatedList[index].id) {
                                updatedList[i].isReqSent = false;
                                break;
                              }
                            }
                            updatedList.removeWhere((request) =>
                                request.id == updatedList[index].id);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const RequestScreen())));
              },
              child: const Text('Data to request Screen'))
        ],
      ),
    );
  }
}
