import 'dart:async';

import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print("WebView is loading (progress : $progress%)");
              },

              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                if(url.contains('successPayment')){
                  Navigator.pushNamedAndRemoveUntil(
                      context, Constants.SCREENS_MAIN_SCREEN, (route) => false);

                  print('success $url');
                }
                else   if(url.contains('failPayment')){
                  Navigator.pushNamedAndRemoveUntil(
                      context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
                  print('fail $url');
                }
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomBtnComponent(text: 'BackToHome'.tr(), onTap: (){
              Navigator.of(context).pushReplacementNamed(Constants.SCREENS_MAIN_SCREEN);
            }),
          ),
        ],
      )
    );
  }
}
