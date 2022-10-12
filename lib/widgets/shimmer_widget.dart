import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/constants/constants.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerWidget.rectangular({required this.width, required this.height});
  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        color: Colors.grey,
      );
}
