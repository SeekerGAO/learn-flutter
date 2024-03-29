import 'package:flutter/material.dart';

class ThemeRoute extends StatefulWidget {
  @override
  _ThemeRouteState createState() => _ThemeRouteState();
}

class _ThemeRouteState extends State<ThemeRoute> {
  Color _themeColor = Colors.teal; // 当前路由主题颜色

  @override
  Widget build(BuildContext context) {
//    return Column(
//        children: <Widget>[
//          //背景为蓝色，则title自动为白色
//          NavBarTest(color: Colors.blue, title: "颜色和主题"),
//          //背景为白色，则title自动为黑色
//          NavBarTest(color: Colors.white, title: "颜色和主题"),
//        ]
//    );

    ThemeData themeData = Theme.of(context);

    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
          ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(Icons.favorite),
              Icon(Icons.airport_shuttle),
              Text("  颜色跟随主题")
            ]),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色")
                  ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => //切换主题
                setState(() => _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal),
            child: Icon(Icons.palette)),
      ),
    );
  }
}

class NavBarTest extends StatelessWidget {
  NavBarTest({
    Key key,
    this.color,
    this.title,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          //阴影
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //根据背景色亮度来确定Title颜色
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
