import 'dart:io';

class Request {
  final String id;
  final String description;
  final File imageFile;
  bool isReqSent;

  Request(
      {required this.id,
      required this.description,
      required this.imageFile,
      this.isReqSent = false});
}
