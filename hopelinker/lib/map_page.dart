import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

// this is public so no underscore in name
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

// this is private so underscore
class _MapPageState extends State<MapPage> {
  late final WebViewController _controller = WebViewController();
  late final Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _loadLocalHtml();
  }
  Future<void> _loadLocalHtml() async {
    try {
      final htmlString = await rootBundle.loadString(
        'assets/html/leafletmap.html',
      );
      await _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      await _controller.setBackgroundColor(Colors.white);
      await _controller.enableZoom(true);
      await _controller.loadHtmlString(htmlString);
    } catch (e) {
      print("Error loading map: $e");
    }
  }@override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return WebViewWidget(controller: _controller);
        }
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF37A5FF)),
              SizedBox(height: 20),
              Text('Loading map...', style: TextStyle(color: Colors.grey)),
            ],
          )
        );
      },
    );
  }
}
