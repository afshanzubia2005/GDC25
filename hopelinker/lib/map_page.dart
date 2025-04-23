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
    final htmlString = await rootBundle.loadString(
      'assets/html/leafletmap.html',
    );
    await _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await _controller.setBackgroundColor(Colors.white);
    await _controller.loadHtmlString(htmlString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User-centered map')),
      body: FutureBuilder<void>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WebViewWidget(controller: _controller);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
