import 'package:flutter/material.dart';
import 'package:ig_app/widgets/custom_text.dart';

class CategoryInfo extends StatefulWidget {
  const CategoryInfo({super.key, required this.img, required this.category});
  final List img;
  final String category;
  @override
  State<CategoryInfo> createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          CustomText(txt: widget.category,color: Colors.white,),
          SizedBox(height: 7),
          Row(
            children: [
              Transform.rotate(angle: -10, child: Icon(Icons.link)),
              SizedBox(width: 5),
              CustomText(
                txt: "https://jacuees.com",
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: (widget.img.length * 27.0) + 10,
                child: Stack(
                  children: [
                    for (int i = 0; i < widget.img.length; i++)
                      Positioned(
                        left: i * 24.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 20,
                          child: CircleAvatar(
                            radius: 19,
                            backgroundImage: NetworkImage(widget.img[i]),
                          ), // CircleAvatar
                        ), // CircleAvatar
                      ), // Positioned
                  ],
                ), // Stack
              ),
              SizedBox(width: 5),
              SizedBox(
                width: 290,
                child: CustomText(
                  txt: "Followed by amr, hossam,mohammed and    3 others ",
                  fontWeight: FontWeight.bold,
                  maxline: 2,
                ),
              )
            ],
          ), // SizedBox
        ],
      ),
    );
  }
}
