import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Moodle extends StatefulWidget {
  final String title;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  Moodle({Key key, this.title, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoodleState();
  }
}

JavascriptChannel snackbarJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
    name: 'SnackbarJSChannel',
    onMessageReceived: (JavascriptMessage message) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message.message),
      ));
    },
  );
}

class _MoodleState extends State<Moodle> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('UON Moodle'),
        actions: <Widget>[
          NavigationControls(_controller.future),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl: 'https://moodle.unizwa.edu.om/login/index.php',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>{
              snackbarJavascriptChannel(context),
            },
          );
        },
      ),
      //  floatingActionButton: _buildShowUrlBtn(),
    );
  }

  Widget _buildShowUrlBtn() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/1");
            },
            child: Icon(Icons.home),
          );
        }
        return Container();
      },
    );
  }

}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);
  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No Back history Item"),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No Forward history Item"),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: !webViewReady
                  ? null
                  : () async {
                controller.reload();
              },
            )
          ],
        );
      },
    );
  }
}