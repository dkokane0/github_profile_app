import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main()=> runApp(MaterialApp(
    home:MyHomePage(),
    debugShowCheckedModeBanner: false,
    theme:ThemeData(
        primarySwatch: Colors.blue
    )
));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {

  TextEditingController controller=TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin= FlutterWebviewPlugin();
  var url= "https://github.com/dkokane0";

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {});
  }
  searchURL(){
    setState(() {
      url = "https://www."+controller.text;
      flutterWebviewPlugin.reloadUrl(url);
      controller.text=url;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      withZoom: true,
      hidden: false,

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Icon(Icons.search),
        title: TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onSubmitted:(url)=>searchURL(),
          style: TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
              hintText: "  Search Here",
              hintStyle: TextStyle(color: Colors.white)
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: (){
                flutterWebviewPlugin.goBack();
                controller.text="";
              }
          ),
          IconButton(icon: Icon(Icons.arrow_forward_ios_sharp),
            onPressed: searchURL,),
        ],
      ),
    );
  }
}
