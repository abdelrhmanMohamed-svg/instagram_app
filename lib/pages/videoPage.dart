import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ig_app/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';
import 'package:ionicons/ionicons.dart';

class Videopage extends StatefulWidget {
  const Videopage(
      {super.key,
      required this.videoUrl,
      required this.profilePic,
      required this.Username,
      this.caption});
  final String videoUrl;
  final String profilePic;
  final String Username;
  final String? caption;
  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  late VideoPlayerController _controller;
  bool _showIcon = false;
  IconData _currentIcon = Icons.play_circle_filled;
  bool iconCliked = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  void _togglePlayPause() {
    bool isPlaying = _controller.value.isPlaying;

    setState(() {
      if (isPlaying) {
        _controller.pause();
        _currentIcon = Icons.pause_circle_filled;
      } else {
        _controller.play();
        _currentIcon = Icons.play_circle_filled;
      }
      _showIcon = true;
    });

    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _showIcon = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeFavColor() {
    setState(() {
      iconCliked = !iconCliked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),
                if (_showIcon)
                  AnimatedOpacity(
                    opacity: _showIcon ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      _currentIcon,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                Positioned(
                    top: 45,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios)),
                        CustomText(
                          txt: "your Reels",
                          fontsize: 19,
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.camera_alt_outlined)
                      ],
                    )),
                Positioned(
                    bottom: 105,
                    right: 10,
                    child: Column(children: [
                      GestureDetector(
                          onTap: changeFavColor,
                          child: Icon(
                            Icons.favorite,
                            size: 32,
                            color: iconCliked ? Colors.red : Colors.white,
                          )),
                      SizedBox(height: 3),
                      Text("345", style: TextStyle(color: Colors.white)),
                      SizedBox(height: 30),
                      Icon(Ionicons.chatbubble_ellipses_outline, size: 32),
                      SizedBox(height: 3),
                      Text("14", style: TextStyle(color: Colors.white)),
                      SizedBox(height: 30),
                      Icon(Icons.send, size: 32),
                      SizedBox(height: 3),
                      Text("1K", style: TextStyle(color: Colors.white)),
                      SizedBox(height: 30),
                      Icon(Icons.more_horiz, size: 32),
                      SizedBox(height: 3),
                    ])),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 20),
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(widget.profilePic),
                            ),
                            SizedBox(width: 15),
                            CustomText(
                              txt: widget.Username,
                              fontsize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 50),
                            SizedBox(
                              width: 340,
                              child: CustomText(
                                txt: widget.caption ??
                                    "this is a caption for the video ♥️ #mrbeastarmy #shorts",
                                fontsize: 14,
                                maxline: 2,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                          endIndent: 20,
                          indent: 20,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Icon(Icons.remove_red_eye_outlined),
                            CustomText(
                              txt: "1.2M viwes",
                              fontsize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
