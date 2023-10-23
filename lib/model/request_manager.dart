import 'request.dart';

class RequestManager {
  List<Request> sendReq = [];
  // List<Request> requests = [
  //   Request(
  //     id: '10',
  //     description: 'Sample Request 1',
  //   ),
  //   Request(
  //     id: '11',
  //     description: 'Sample Request 2',
  //   ),
  //   // Add more initial requests if needed
  // ];
  void checkSendRequest() {
    print(sendReq);
  }

  // void acceptRequest(int id) {
  //   requests.removeWhere((request) => request.id == id);
  //   sendReq.removeWhere((request) => request.id == id);
  // }

  List<Request> sendRequest(Request requestModel) {
    sendReq.add(requestModel);
    return sendReq;
  }
}
