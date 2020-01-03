import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/xiangmu/xiangmutab.dart';

import '../project_entity_entity.dart';
import '../project_list_data_entity.dart';

Dio dio = new Dio();

class XiangmuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _XiangmuPageState();
}

class _XiangmuPageState extends State<XiangmuPage>
    with TickerProviderStateMixin {
//   List<ProjectData> _datas = new List();//tab集合
  TabController _controller; //tab控制器
  List<ProjectEntityData> _datas = new List(); //tab集合
  List<ProjectListDataDataData> _listDatas = new List(); //内容集合
  int _currentIndex = 0; //选中下标

  @override
  void initState() {
    super.initState();
    //初始化controller
    _controller = new TabController(vsync: this, length: _datas.length
    );
    getdatalist();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text('项目'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.search), onPressed: () {}),
          ],
          bottom: TabBar(
//                  backgroundColor: Colors.white,
            controller: _controller,
            //控制器
            indicatorColor: Colors.white,
            //下划线颜色
            labelColor: Colors.white,
            //选中的颜色
            isScrollable: true,
            //是否可滑动
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16),
//                  labelColor : Colors.white,
            tabs: _datas.map((ProjectEntityData choice) {
              return new Tab(
                text: choice.name,
              );
            }).toList(),
          ),
        ),
//          appBar: AppBar(

//          ),
        body: TabBarView(
          controller: _controller,
          children: _datas.map((ProjectEntityData choice) {
            return ListView.builder(
                itemCount: _listDatas.length,
                itemBuilder: (BuildContext context, int i) {
                  return  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(10),
                    child: new Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Expanded(
                              flex: 2,
                              child: new Image.network(_listDatas[i].envelopePic),
                            ),
                            new Expanded(
                              flex: 5,
                              child: new Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: new Text(
                                      _listDatas[i].title,
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.all(10),
                                    child: new Text(
                                      _listDatas[i].desc,
                                      style:
                                      TextStyle(fontSize: 14, color: Colors.black54),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  new Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      children: <Widget>[
                                        new Expanded(
                                          flex: 1,
                                          child: new Padding(
                                            padding: EdgeInsets.all(10),
                                            child: new Text(_listDatas[i].niceDate,
                                                style: TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                        new Padding(
                                          padding: EdgeInsets.all(10),
                                          child: new Text(
                                            _listDatas[i].author,
                                            style: TextStyle(fontSize: 14),
                                            textAlign: TextAlign.right,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }).toList(),
        ),
      ),
    );
  }

  getdatalist() async {
    try {
      var response =
          await dio.get('https://www.wanandroid.com/project/tree/json');
      Map userMap = json.decode(response.toString());
      var projectEntity = new ProjectEntityEntity.fromJson(userMap);
      if(mounted) {
        setState(() {
//      _datas = projectEntity.data;
          _datas = projectEntity.data;
          _controller = new TabController(length: _datas.length, vsync: this);
          _currentIndex = 0;
        });
      }
      getDetail();
      //初始化controller并添加监听

      //controller添加监听

      _controller.addListener(() => _onTabChanged());
    } catch (e) {
      print(e);
    }
  }

  _onTabChanged() {
    if (_controller.index.toDouble() == _controller.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = _controller.index;
      });
      getDetail();
    }
  }

  getDetail() async {
    try {
//      var data = {"cid": _datas[_currentIndex].id};
      var response2 = await dio.get(
          'https://www.wanandroid.com/project/list/1/json?cid=${_datas[_currentIndex].id}');
      Map userMap2 = json.decode(response2.toString());
      var projectListEntity = new ProjectListDataEntity.fromJson(userMap2);
      setState(() {
        _listDatas = projectListEntity.data.datas;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void dispose() {
    _controller.dispose(); //销毁
    super.dispose();
  }
}
