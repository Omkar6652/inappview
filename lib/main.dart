import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
   late final WebViewController _controller;
     PlatformWebViewControllerCreationParams params=
    const PlatformWebViewControllerCreationParams();
    _MyHomePageState(){
final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
         controller
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      //  WebView(
      //       initialUrl:
      //      'asset:///assets/video_player.html', 
      //       javascriptMode: JavascriptMode.unrestricted,
      //       onWebViewCreated: (WebViewController controller) {
      //         _controller.complete(controller);
      //       },
      //     )),
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onHttpError: (HttpResponseError error) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        
        return NavigationDecision.navigate;
      },
    ),
  );
  // ..loadRequest(Uri.parse('asset:///assets/video_player.html'));
_controller = controller;
_controller.loadFlutterAsset('assets/video_player.html');
if (_controller.platform is AndroidWebViewController) {
  AndroidWebViewController.enableDebugging(true);
  (_controller.platform as AndroidWebViewController)
      .setMediaPlaybackRequiresUserGesture(false);
}
    }
   
 
 void initState(){
  
 }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player' ,textDirection: TextDirection.ltr),
      ),
      body: Column(
        children: [
          Container(
         width: 500.0,
         height:500.0 ,
         child: WebViewWidget(controller: _controller)),
        
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () async {
                 
                  await _controller.runJavaScript(
                      'playPauseButton.click();'); // Trigger JS click
                },
              ),
              IconButton(
                icon: Icon(Icons.fullscreen),
                onPressed: () async {
                 
                  // Call a JavaScript function to handle fullscreen
                  await _controller.runJavaScript(
                      'fullscreenButton.click();'); // Trigger JS click
                },
              ),
            ],
          ),
      ],
      ),
    );
  }
}
