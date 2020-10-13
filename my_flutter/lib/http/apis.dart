class APIs {
  //url 前缀
  static const String apiPrefix =
      "http://210.13.111.26:10296/api";

  //登录接口
  static String login = "/login";
  //获取分页数据
  static String getPage = "/getPageArrDic";
  //获取分页分组数据
  static String getGroupPage = "/getGroupPageArrDic";
  static String getAuthManager= "/vhcApp/subaccount/subAccountList";
  static String getVhcList= "/vhcApp/vhcNet/getVhcList";
    static String getAuthList= "/vhcApp/subaccount/authCarList";

//     

//
}

//接口类型
enum APIType {
  Login,
  GetPage,
  AuthManager,
  CarVhcList,
  AuthList,
}
//使用：APITypeValues[APIType.Login]
const APITypeValues = {
  APIType.Login: "/login",
  APIType.GetPage: "/getPageArrDic",
  APIType.AuthManager:"/vhcApp/subaccount/subAccountList",
  APIType.CarVhcList:"/vhcApp/vhcNet/getVhcList",
  APIType.AuthList:"/vhcApp/subaccount/authCarList",
};
