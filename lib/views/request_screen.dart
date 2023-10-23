import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:request_test/model/request_manager.dart';
import 'package:request_test/views/manage_request_screen.dart';

import '../controller/controller.dart';
import '../model/request.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final RequestManager reqManager = RequestManager();
  final controller = Get.put(MyController());

  List totalReq = [];
  List<bool> sentedreq = [];

  // List<Request> requests = [
  @override
  Widget build(BuildContext context) {
    print(controller.posts.length);
    setState(() {});

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Management'),
        // automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.7,
            width: double.infinity,
            child: ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                final request = controller.posts[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          request.description,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(request.imageFile),
                            ),
                          ),
                        ),
                      ],
                    ),
                    request.isReqSent == true
                        ? MaterialButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Text('Requested'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              setState(() {
                                request.isReqSent = true;
                                print(request.id);

                                totalReq = reqManager.sendRequest(request);
                                controller.getReqts(totalReq);
                              });

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageRequestsScreen()));
                            },
                            child: const Text('Send Request'),
                          ),
                  ],
                );
                // ListTile(
                //   title: Column(
                //     children: [
                //       Text(request.description),
                //       Container(
                //         height: 180,
                //         width: 180,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(color: Colors.black),
                //           image: DecorationImage(
                //             fit: BoxFit.fill,
                //             image: FileImage(request.imageFile),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                //   trailing: request.isReqSent == true
                //       ? MaterialButton(
                //           onPressed: () {},
                //           shape: RoundedRectangleBorder(
                //             side: const BorderSide(color: Colors.black),
                //             borderRadius: BorderRadius.circular(3),
                //           ),
                //           child: const Text('Requested'),
                //         )
                //       : ElevatedButton(
                //           onPressed: () {
                //             setState(() {
                //               request.isReqSent = true;
                //               print(request.id);

                //               totalReq = reqManager.sendRequest(request);
                //               controller.getReqts(totalReq);
                //             });

                //             //Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageRequestsScreen()));
                //           },
                //           child: const Text('Send Request'),
                //         ),
                // );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageRequestsScreen(
                      //getTotalRequest: totalReq,
                      ),
                ),
              );
            },
            child: const Text('Check total requests'),
          ),
          TextButton(
            onPressed: () {
              reqManager.checkSendRequest();
            },
            child: const Text('print total send requests'),
          ),
        ],
      ),
    );
  }
}
