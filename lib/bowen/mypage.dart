import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bowen/bowenpage.dart';
import 'package:flutter_module/bowen/register.dart';
import 'package:flutter_module/utils/Toast.dart';

import '../bowenhome.dart';
Dio dio=new Dio();
 class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MyPageState();
   
 }
 class _MyPageState extends State<MyPage>{
   var errorCode;
   //手机号的控制器
   TextEditingController userController = TextEditingController();

   //密码的控制器
   TextEditingController passController = TextEditingController();
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
            new IconButton(
                icon: new Icon(Icons.search), onPressed: () {}),
           ],
           title: Text('我的'),
          ),
          preferredSize: Size.fromHeight(45)),
       body: Container(
//         color: Colors.redAccent,
       padding: EdgeInsets.only(top: 50,left: 20,right: 20),

        child: Theme(data: new ThemeData(primaryColor: Colors.redAccent,hintColor: Colors.grey),
          child:Column(
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
         Container(
           padding: EdgeInsets.only(top: 20,bottom: 20),
           child:   SizedBox(
             width: double.infinity,
//             height: 50,
             child:RaisedButton(
//             : EdgeInsets.only(top: 40),
               color: Colors.redAccent,
               onPressed: (){
                 if(userController.text.length!=11){
                   showDialog(
                       context:context,
                       builder: (context)=>AlertDialog(
                         title:Text('请输入正确的手机号'),
                       ));
                 }else if(passController.text.length==0){
                   showDialog(
                       context:context,
                       builder: (context)=>AlertDialog(
                         title:Text('密码不正确'),
                       ));
                 }else{
                   getlogingData().then((val){
                     setState(() {
                       errorCode=val['errorCode'];
                     });
                     if (errorCode == 0) {
                       Toast.toast(context,msg: "登录成功",position: ToastPostion.center);
//                       showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text('登录成功'),
//                           ));
                       Navigator.of(context).pushAndRemoveUntil(
                           new MaterialPageRoute(
                               builder: (context) => new BoWenHomePage()),
                               (route) => route == null);
                     } else if(errorCode == -1){
                       showDialog(
                           context: context,
                           builder: (context) => AlertDialog(
                             title: Text('账号或密码错误'),
                           ));
                     }else{
                       showDialog(
                           context: context,
                           builder: (context) => AlertDialog(
                             title: Text('登录失败，请检查网络连接'),
                           ));
                     }
                   });
                 }
               },
               child: Text('登录',style: TextStyle(color: Colors.white,fontSize: 16),),
             ),),
         ),

          SizedBox(

            width:  double.infinity,
            child:GestureDetector(
              child: Text('注册新账号',textAlign: TextAlign.right,style: TextStyle(color: Colors.grey),),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new RegisterPage(),
                  ),
                );
              },
            ),
          ),

         ],
       ),),
       ),
     ),
    );
  }
  getlogingData()async{
    Response response;
    Map<String,dynamic> datas={
      'username':userController.text,
      'password':passController.text,
    };
    response=await dio.post('https://www.wanandroid.com/user/login',queryParameters:datas );
    return response.data;
  }
   
 }