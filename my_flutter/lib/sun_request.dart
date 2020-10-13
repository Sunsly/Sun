import 'package:dio/dio.dart';

class SUNHttpRequest {
  static final Dio dio = Dio();

  static Future<T> request<T>(String url,
      {String method = "get", Map<String, dynamic> params}) async {
    final options = Options(method: method,headers: httpHeaders);
    try {
      Response response = await dio.request(url,queryParameters: params,options: options);
      return response.data;
    } on DioError catch(e){
      return Future.error(e);
    }

  }
}
Map<String, dynamic> httpHeaders = {
  'Accept': 'application/json,*/*',
  'Content-Type': 'application/json',
  'appVersion':"1.5.0",
  'type':"1",
  'token': "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIyMTQiLCJ1c2VySWQiOiIyMTQiLCJuYW1lIjoiIiwicmVtYXJrIjoiIiwia2lja091dCI6dHJ1ZSwidGVsUGhvbmUiOiIxNTgzNzEyNjAyMCIsInVzZXJOYW1lIjoiIiwibmlja25hbWUiOiJzdW5naCIsImF2YXRhciI6IiIsImRlYWxlckNvZGUiOiIyMDA1OTExIiwibG9nVGltZSI6IjIwMjAtMDctMTAgMTQ6MzEiLCJleHBlcmllbmNlU3RhdHVzIjoiMzAzMTEwMDMiLCJpc05ldyI6IjEwMDQxMDAyIiwidXVpZCI6IkMyMTQiLCJleHAiOjE2MDI0MDc5MTd9.HiylB08TodbTMT0i6oSkkROo_GbD4PPBqYWYTuZjBdH_w3r9xCwnw8EZXuEHNJHeUxrhHVDMC0kbEqTiO6kn6TphrRa5z63nOjXm3GuiSPT1x9HXPTwCdjrqrVlYoMTkuMXLCoV9mManf8gwJrYGw7k4IDYKR_lfWMjCl9WMbWY",
};
