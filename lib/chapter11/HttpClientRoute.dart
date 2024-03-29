import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class HttpClientRoute extends StatefulWidget {
  @override
  _HttpClientRouteState createState() => _HttpClientRouteState();
}

class _HttpClientRouteState extends State<HttpClientRoute> {

  bool _loading = false;
  String _text = "";


  _getBaiduHomePage() async{
      setState(() {
        _loading = true;
        _text = "正在请求";
      });

      try{
        //创建一个HttpClient
        HttpClient httpClient = new HttpClient();
        //打开http连接
        HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
        //使用iPhone的UA
        request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
        //等待连接服务器
        HttpClientResponse response = await request.close();
        //读取响应内容
        _text = await response.transform(utf8.decoder).join();
        //输出响应头
        print(response.headers);

        //请求结束，关闭HttpClient
        httpClient.close();
      }catch(e){
        _text = "请求失败：$e";
      }finally{
        setState(() {
          _loading = false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("获取百度首页"),
              onPressed: _loading ? null : _getBaiduHomePage,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(new RegExp(r"\s"), "")),
            )
          ],
        ),
      ),
    );
  }
}

