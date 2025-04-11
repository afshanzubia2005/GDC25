import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

// this is public so no underscore in name
class MapPage extends StatefulWidget{
  const MapPage({super.key});
  
  @override
  State<MapPage> createState() => _MapPageState();

}
// this is private so underscore
class _MapPageState extends State<MapPage>{
  late final WebViewController _controller;

  @override
  void initState(){
    super.initState();
    _loadLocalHtml();

  }

  Future<void> _loadLocalHtml() async {
    final htmlString = await rootBundle.loadString('assets/map.html');
    _controller = WebViewController()
      ..loadHtmlString(htmlString);

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('User-centered map')),
      body: WebViewWidget(controller: _controller)
    );
  }
}