import 'dart:convert';

import 'package:http/http.dart';
import 'package:marchant/services/storage_service.dart/session.dart';

class ApiCallService {
  // Authorization
  static const String _auth = "Authorization";

  // header
  static final header = {
    "content-type": "application/json",
    "Accept": "application/json"
  };

  // can handle all api
  static const Duration timeout = Duration(seconds: 15);

  // timeout response.
  static Response timeoutResponse =
      Response('Request timeout check your connection', 500);

  // connection problem response.
  static Response connectionProblem =
      Response('Please check your internet connection!', 500);

  // // post call
  // static Future<Response> postCall(
  //     String url, String token, Map<String, dynamic> body,
  //     {required bool needToken}) async {
  //   needToken ? header[_auth] = 'Bearer $token' : null; //'Bearer $token'
  //   try {
  //     Response response =
  //         await post(Uri.parse(url), headers: header, body: jsonEncode(body))
  //             .timeout(
  //       timeout,
  //       onTimeout: () => timeoutResponse,
  //     );
  //     return response;
  //   } catch (e) {
  //     return connectionProblem;
  //   }
  // }

// post call
  static Future<Response> postCall(String url, Map<String, dynamic> body,
      {required bool needToken}) async {
    needToken ? header[_auth] = 'Bearer ${await _getToken()}' : null;
    try {
      Response response =
          await post(Uri.parse(url), headers: header, body: jsonEncode(body))
              .timeout(
        timeout,
        onTimeout: () => timeoutResponse,
      );
      return response;
    } catch (e) {
      return connectionProblem;
    }
  }
  // get call
  static Future<Response> getCall(String url, String token,
      {required bool needToken}) async {
    needToken ? header[_auth] = 'Bearer $token' : null; //'Bearer $token'
    try {
      Response response = await get(Uri.parse(url), headers: header).timeout(
        timeout,
        onTimeout: () => timeoutResponse,
      );
      return response;
    } catch (e) {
      return connectionProblem;
    }
  }


   // patch call
  static Future<Response> patchCall(String url, Map<String, dynamic> body,
      {required bool needToken}) async {
    needToken ? header[_auth] = 'Bearer ${await _getToken()}' : null;
    try {
      Response response =
          await patch(Uri.parse(url), headers: header, body: jsonEncode(body))
              .timeout(
        timeout,
        onTimeout: () => timeoutResponse,
      );
      return response;
    } catch (e) {
      return connectionProblem;
    }
  }


  static _getToken() async {
    return await SessionService.getString(SessionKey.token);
  }
}
