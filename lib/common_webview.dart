import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CommonWebViewPage extends StatefulWidget {
  final String url;

  const CommonWebViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<CommonWebViewPage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<CommonWebViewPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  TextEditingController textEditingController = TextEditingController();

  double progress = 0;
  String userAgent = "SmartGovernmentApp";
  bool hideAppBar = false;
  String json="{\"deptName\":\"科技信息处\",\"code\":\"2c94e53d7ae5f4ab017b1a4dee9a17e6\",\"nickName\":null,\"sex\":1,\"deptId\":\"49421e07539647bd9f784a46b6f2440d\",\"photo\":null,\"remark\":null,\"loginPolicy\":null,\"token\":null,\"deptSortIndex\":null,\"phone\":\"18896562931\",\"identity\":null,\"deptPath\":\"277e\",\"name\":\"零号人员\",\"tenantId\":\"RBAC\",\"id\":\"2c94e53d7ae5f4ab017b1a4dee9a17e6\",\"position\":null,\"deptCode\":\"fy-pbms-back-test\",\"email\":null,\"status\":1,\"username\":\"零号人员\"}";

  Future<bool> closePage() async {
    if ((await webViewController?.canGoBack()) ?? false) {
      await webViewController?.goBack();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: closePage,
      child: Column(
        children: [
          SizedBox(height: 56),
          TextField(
            controller: textEditingController,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF000B1D)),
            onChanged: (value) {
              webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(value)));
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                hintText: '请输入url', // 提示文本
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFBBBBBB)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Color(0x00DEE3E7),
                    width: 1,
                  ),
                )),
          ),
          Expanded(
              child: Scaffold(
            body: SafeArea(
              child: InAppWebView(
                key: webViewKey,
                initialFile: widget.url,
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                    userAgent: userAgent,
                    // applicationNameForUserAgent: userAgent,
                  ),
                  android: AndroidInAppWebViewOptions(
                    useHybridComposition: false,
                  ),
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                  controller.addJavaScriptHandler(
                    handlerName: "getUserInfo",
                    callback: (args) async {
                      return json;
                    },
                  );
                },
                onTitleChanged: (controller, title1) {},
                onLoadStart: (controller, url) {},
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {},
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class WebViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final double leadingWidth;

  const WebViewAppBar({
    Key? key,
    required this.title,
    this.leading,
    required this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/icons/approval_title.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        centerTitle: true,
        title: title,
        leadingWidth: leadingWidth,
        leading: leading,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

String getContentTypeFromFileName(String fileName) {
  const dic = {
    ".3gp": "video/3gpp",
    ".torrent": "application/x-bittorrent",
    ".kml": "application/vnd.google-earth.kml+xml",
    ".gpx": "application/gpx+xml",
    ".csv": "application/vnd.ms-excel",
    ".apk": "application/vnd.android.package-archive",
    ".asf": "video/x-ms-asf",
    ".avi": "video/x-msvideo",
    ".bin": "application/octet-stream",
    ".bmp": "image/bmp",
    ".c": "text/plain",
    ".class": "application/octet-stream",
    ".conf": "text/plain",
    ".cpp": "text/plain",
    ".doc": "application/msword",
    ".docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    ".xls": "application/vnd.ms-excel",
    ".xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    ".exe": "application/octet-stream",
    ".gif": "image/gif",
    ".gtar": "application/x-gtar",
    ".gz": "application/x-gzip",
    ".h": "text/plain",
    ".htm": "text/html",
    ".html": "text/html",
    ".jar": "application/java-archive",
    ".java": "text/plain",
    ".jpeg": "image/jpeg",
    ".jpg": "image/jpeg",
    ".js": "application/x-javascript",
    ".log": "text/plain",
    ".m3u": "audio/x-mpegurl",
    ".m4a": "audio/mp4a-latm",
    ".m4b": "audio/mp4a-latm",
    ".m4p": "audio/mp4a-latm",
    ".m4u": "video/vnd.mpegurl",
    ".m4v": "video/x-m4v",
    ".mov": "video/quicktime",
    ".mp2": "audio/x-mpeg",
    ".mp3": "audio/x-mpeg",
    ".mp4": "video/mp4",
    ".mpc": "application/vnd.mpohun.certificate",
    ".mpe": "video/mpeg",
    ".mpeg": "video/mpeg",
    ".mpg": "video/mpeg",
    ".mpg4": "video/mp4",
    ".mpga": "audio/mpeg",
    ".msg": "application/vnd.ms-outlook",
    ".ogg": "audio/ogg",
    ".pdf": "application/pdf",
    ".png": "image/png",
    ".pps": "application/vnd.ms-powerpoint",
    ".ppt": "application/vnd.ms-powerpoint",
    ".pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    ".prop": "text/plain",
    ".rc": "text/plain",
    ".rmvb": "audio/x-pn-realaudio",
    ".rtf": "application/rtf",
    ".sh": "text/plain",
    ".tar": "application/x-tar",
    ".tgz": "application/x-compressed",
    ".txt": "text/plain",
    ".wav": "audio/x-wav",
    ".wma": "audio/x-ms-wma",
    ".wmv": "audio/x-ms-wmv",
    ".wps": "application/vnd.ms-works",
    ".xml": "text/plain",
    ".z": "application/x-compress",
    ".zip": "application/x-zip-compressed",
    "": "*/*"
  };

  var index = fileName.lastIndexOf(".");
  if (index > 0) {
    var formant = fileName.substring(index).toLowerCase();
    return dic[formant] ?? "*/*";
  }
  return "*/*";
}
