import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:video_player/video_player.dart';

class SplashVideoScreen extends StatefulWidget {
  final String videoLink;
  final String videoTitle;
  final String userId;
  const SplashVideoScreen({
    super.key,
    required this.videoLink,
    required this.videoTitle,
    required this.userId,
  });

  @override
  State<SplashVideoScreen> createState() => _SplashVideoScreenState();
}

class _SplashVideoScreenState extends State<SplashVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoLink))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.isCompleted) {
        saveSplashScreenUserFunction();
      }
    });
  }

  Future<void> saveSplashScreenUserFunction() async {
    await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.saveSplashScreenUser,
      data: dio.FormData.fromMap({
        'user_id': widget.userId,
      }),
    );
    Get.offAll(
      () => MainHomeScreen(selectedIndex: 0.obs),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).viewPadding.top + 20),
            child: Text(
              widget.videoTitle,
              style: mediumText16.copyWith(
                color: blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
