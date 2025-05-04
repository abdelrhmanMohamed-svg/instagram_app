import 'package:flutter/material.dart';
import 'package:ig_app/widgets/custom_text.dart';

class UserInfo extends StatelessWidget {
  UserInfo({super.key, required this.userImg, required this.followerNumber});
  final String userImg;
  final String followerNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.pinkAccent, Colors.pinkAccent, Colors.orangeAccent])),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(userImg),
              )),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txt: "2",
              fontWeight: FontWeight.bold,
              fontsize: 18,
            ),
            CustomText(txt: "Posts"),
          ],
        ),
        SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txt: followerNumber,
              fontWeight: FontWeight.bold,
              fontsize: 18,
            ),
            CustomText(txt: "Followers"),
          ],
        ),
        SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txt: "300",
              fontWeight: FontWeight.bold,
              fontsize: 18,
            ),
            CustomText(txt: "Following"),
          ],
        )
      ],
    );
  }
}
