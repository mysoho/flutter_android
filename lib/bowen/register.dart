import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bowen/mypage.dart';

Dio dio = new Dio();

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //手机号的控制器
  TextEditingController userController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  var errorCode;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Colors.redAccent,
              centerTitle: true,
              actions: <Widget>[
                new IconButton(icon: new Icon(Icons.search), onPressed: () {}),
              ],
              title: Text('注册'),
            ),
            preferredSize: Size.fromHeight(45)),
        body: Container(
//         color: Colors.redAccent,
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),

          child: Theme(
            data: new ThemeData(
                primaryColor: Colors.redAccent, hintColor: Colors.grey),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: userController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
//            icon: Icon(Icons.perm_identity),
                    hintText: '请输入你的用户名',
                    labelText: "用户名",
                  ),
                  autofocus: false,
                ),
                TextField(
                    controller: passController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),

//               icon: Icon(Icons.lock),
                      hintText: '请输入密码',
                      labelText: "密码",
                    ),
                    obscureText: true),
                TextField(
                    controller: pass2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),

//               icon: Icon(Icons.lock),
                      hintText: '请输入确认密码',
                      labelText: "确认密码",
                    ),
                    obscureText: true),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    width: double.infinity,
//             height: 50,
                    child: RaisedButton(
//             : EdgeInsets.only(top: 40),
                      color: Colors.redAccent,
                      onPressed: () {
                        if (userController.text.length != 11) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('请输入正确的手机号'),
                                  ));
                        } else if (passController.text.length == 0) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('请输入密码'),
                                  ));
                        } else if (pass2Controller.text.length == 0) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('请输入确认密码'),
                                  ));
                        } else if (passController.text !=
                            pass2Controller.text) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('密码不一致'),
                                  ));
                        } else {
                          getregisterList().then((val){
                            setState(() {
                              errorCode=val['errorCode'];
                            });
                            if (errorCode == 0) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('注册成功，正在跳转至登录页'),

                                  ));
                            } else if(errorCode == -1){
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('此用户名已注册'),
                                  ));
                            }else{
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('注册失败，请检查网络连接'),
                                  ));
                            }
                          });

                        }
                      },
                      child: Text(
                        '注册',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   getregisterList() async {

    try {
      Response response;

      Map<String,dynamic> params= {
        'username': userController.text,
        'password': passController.text,
        'repassword': pass2Controller.text,
      };
       response= await dio.post('https://www.wanandroid.com/user/register', queryParameters: params);
//      var veslut = response.data;
//      setState(() {
//        errorCode = veslut['errorCode'];
//      });
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
