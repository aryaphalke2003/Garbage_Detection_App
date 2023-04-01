import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

String serverURL = 'https://eco-tags-backend.onrender.com';

getURI(String path) {
  return Uri.parse(serverURL + "/" + path);
}

getToken() async {
  User? user = FirebaseAuth.instance.currentUser;
  String token = await user!.getIdToken();
  return token;
}

postApiCall(Object body, String path) async {
  print("postApiCall");
  var uri = getURI(path);
  print(body);
  print('uri${uri.toString()}');
  // put jwt token in headers
  String token = await getToken();

  final Map<String, String> header = {"Authorization": 'Bearer $token'};
  print(header);

  Dio()
      .post(uri.toString(), data: body, options: Options(headers: header))
      .then(
    (response) {
      print(response);
      return {
        "data": response.data,
        "status": response.statusCode,
      };
    },
  ).catchError((error) {
    print(error);
    return {"data": error, "status": 500};
  });
}

// make a class ApiResponse
class ApiResponse {
  ApiResponse(this.status, this.data);
  final int status;
  final dynamic data;
}

Future<ApiResponse> getApiCall(String path) async {
  var uri = getURI(path);
  // put jwt token in headers
  String token = await getToken();
  final header = {"Authorization": 'Bearer $token'};

  var response =
      await Dio().get(uri.toString(), options: Options(headers: header));

  print("dfsaf");
  // return response.data;
  print(response.data);
  return ApiResponse(response.statusCode!, response.data);
}
