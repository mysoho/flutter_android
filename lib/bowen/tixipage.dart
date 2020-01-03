import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

class TixiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TixiPageState();
}

class _TixiPageState extends State<TixiPage> {
  var datalist = [];
  int index;
  var articles=[];
  @override
  void initState() {
    super.initState();
    //初始化controller
//    _controller = TabController(vsync: this, length: 0);
    getdatalist();
  }

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
              title: Text('导航'),
            ),
            preferredSize: Size.fromHeight(45)),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Container(
                  color: Colors.redAccent,
//                  width: 150,
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: datalist.length,
                      itemBuilder: (BuildContext context, int i) {
                        return getRow(i);
                      }),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: getChip(index),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int i) {
    var itemdata = datalist[i];
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            itemdata['name'],
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                height: 1.5),
          )),
      onTap: () {
        setState(() {
          index=i;
        });
      },
    );
  }
  Widget getChip(int index){
    _updateArticles(index);
    return Wrap(
      spacing: 10.0, //两个widget之间横向的间隔
      direction: Axis.horizontal, //方向
      alignment: WrapAlignment.start, //内容排序方式
      children: List<Widget>.generate(
        articles.length,
            (int index) {
          return ActionChip(
            //标签文字
            label: Text(articles[index]['title'],
                style: TextStyle(
                    fontSize: 16, color: Colors.black87)),
            //点击事件
            onPressed: () {},
            elevation: 3,
          );
        },
      ).toList(),
    );
  }

  getdatalist() async {
    var response = await dio.get('https://www.wanandroid.com/navi/json');
    var result = response.data;
    if (mounted) {
      setState(() {
        datalist = result['data'];
        index = 0;
      });
    }
  }
  List _updateArticles(int i) {
    setState(() {
      if (datalist.length != 0) articles = datalist[i]['articles'];
    });
    return articles;
  }
}
