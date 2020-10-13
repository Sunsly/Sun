import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/auth_info.dart';
import 'package:my_flutter/http/apis.dart';
import 'package:my_flutter/new_auth.dart';
import 'package:dio/dio.dart';
import 'sun_request.dart';
import 'package:my_flutter/http/http_utils.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _click() {
    print('授权');
  }

  Widget cellView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AuthInfoContrller();
        }));
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        height: 100,
        // color: Colors.red,//不能与下面的属性同时出现
        decoration: BoxDecoration(
//边框
          // border: Border.all(
          //   color:Colors.green,
          //   width: 1
          // ),

          boxShadow: [
            BoxShadow(blurRadius: 0.01, spreadRadius: 0.01, color: Colors.grey)
          ],

          color: Colors.white,
          borderRadius: BorderRadius.circular(5), // 圆角也可控件一边圆角大小
          //borderRadius: BorderRadius.only(
          //  topRight: Radius.circular(10),
          // bottomRight: Radius.circular(10)) //单独加某一边圆角
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 28, left: 20),
                    child: Text('16621070078'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14, left: 20),
                    child: Text('有效期：2020-02-04 至2020-12-12'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, top: 30),
              child: Text(
                '授权',
                textAlign: TextAlign.right,
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    //http://210.13.111.26:10296/api/vhcApp/subaccount/subAccountList
    // TODO: implement initState
    super.initState();
    // getHttp();
    getCarList();

    getAuthCarList();
  }

  void getHttp() async{
    // try {
    //   Response response = await Dio().get("http://www.baidu.com");
    //   print(response);
    // } catch (e) {
    //   print(e);
    // }
    /*
    <GTMCAuthSubAccountListRequest: 0x6000031d6560>{ URL: http://210.13.111.26:10296/api/vhcApp/subaccount/subAccountList?appVersion=1.5.0&userId=214 } { method: POST } { arguments: {
	vin = LJNTFUCY7KN143418;
	status = 1;
    */
  //  final result =   await SUNHttpRequest.request("http://210.13.111.26:10296/api/vhcApp/subaccount/subAccountList");
  //  print(result);

  HttpUtils.PostRequest(APIType.AuthManager, {"vin":"LJNTFUCY7KN143418","status":"1","userId":"214","appVersion":"1.5.0"},
    success:(data){
    
     print(data);


   },fail: (code){

     print(code);
   });

// HttpUtils.GetRequest(apiType, parameters)

  }
  getCarList() async{
    HttpUtils.PostRequest(APIType.CarVhcList, {"phone":"15837126020","searchParam":""},success: (data){

      print(data);
    },fail: (code){

    });
  }
  getAuthCarList(){
    HttpUtils.GetRequest(APIType.AuthList, {"phone":"15837126020"},success: (data){

    }, fail: (code){

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          title: Text(
            '授权管理',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return cellView(context);
                },
              ),
            ),
            GestureDetector(
              onTap: _click,
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                  ),
                  child: Center(
                      child: CupertinoButton(
                          child: Text(
                            "授权爱车给朋友",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewBuildAuthController();
                            }));
                          }))),
            )
          ],
        ),
      ),
    );
  }
}
