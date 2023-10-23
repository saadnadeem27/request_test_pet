import 'dart:io';

import 'package:get/get.dart';
import 'package:request_test/model/request.dart';

class MyController extends GetxController {
  List totalSendReq = [];
  RxList<Request> posts = <Request>[].obs;

  void getReqts(List val) {
    totalSendReq = val;
  }

  void acceptRequest(String id) {
    totalSendReq.removeWhere((request) => request.id == id);
    //sendReq.removeWhere((request) => request.id == id);
  }

  void addPost(String idd, String desc, File img) {
    posts.add(Request(id: idd, description: desc, imageFile: img));
  }
}
