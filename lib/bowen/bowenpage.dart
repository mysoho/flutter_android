import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

Dio dio = new Dio();

class BowenPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _BowenPageState();

}

class _BowenPageState extends State<BowenPage> {
  var itemlist = [];
  var bannerimglist = [];
  SwiperController _swiperController;

  //浮动按钮控制器
  ScrollController scrollController = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
//轮播图控制器
  @override
  void initState() {
    // TODO: implement initState
    getDataList();
    ScrollController _scrollController = ScrollController()..addListener(() {});
    _swiperController = new SwiperController();
    _swiperController.startAutoplay();
    scrollController.addListener(() {
      if (mounted&&scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (mounted&&scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
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
                  new IconButton(
                      icon: new Icon(Icons.search), onPressed: () {}),
                ],
                title: Text('博文'),
              ),
              preferredSize: Size.fromHeight(45)),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              elevation: 0.0, //阴影
              backgroundColor: Colors.redAccent,
              onPressed: () {
                scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
//              scrollController.jumpTo(scrollController.position.maxScrollExtent);
              },
            ),
      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(bannerimglist[index]['imagePath'],
                    fit: BoxFit.cover);
              },
              itemCount: bannerimglist.length,
//        pagination: new SwiperPagination(),
              autoplay: false,
              loop: false,
              controller: _swiperController,
            ),
          ),
          Expanded(
            child: Container(
//          height: 500,
              child: ListView.builder(
                controller: scrollController,
                itemCount: itemlist.length,
                itemBuilder: (BuildContext context, int i) {
                  var myitem = itemlist[i];
                  return Container(
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 15),
                    decoration:
                        BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(1, 1),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-1, -1),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(1, -1),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-1, 1),
                          blurRadius: 5)
                    ]),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            myitem['title'],
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                          Text(myitem['niceDate'],
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  height: 1.5),
                              textAlign: TextAlign.start),
                          Text(myitem['shareUser'],
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  height: 1.5),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }

  getDataList() async {
    var respons =
        await dio.get('https://www.wanandroid.com/article/list/0/json');
    var bannerrespons = await dio.get('https://www.wanandroid.com/banner/json');
    var result = respons.data;
    var bannerresult = bannerrespons.data;
    if(mounted) {
      setState(() {
        bannerimglist = bannerresult['data'];
        itemlist = result['data']['datas'];
        print(itemlist.length);
      });
    }
  }

  @override
  void dispose() {
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
