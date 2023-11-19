import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewViewer extends StatefulWidget {
  String url;
  ViewViewer({super.key, required this.url});

  @override
  State<ViewViewer> createState() => _ViewViewerState();
}

class _ViewViewerState extends State<ViewViewer> {
  bool isvideoLoaded = false;
  var controller;

  @override
  void initState() {
    // TODO: implement initState
    List option = widget.url.split("/");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.mathlabcochin.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse(
              'https://player.vimeo.com/video/${option[0]}?h=${option[1]}'),
          headers: {
            "Authorization": "Bearer c15bd5941857f4e8680986c11a94cf38"
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: 800, maxHeight: 700),
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
                child: WebViewWidget(
                  controller: controller,
                ))));
  }
}
