//this class for custom container
//re-use this custom container rather than for deafult container
//the parameters width,height required and
//other parameters optional
//you can add additional parameter if you want
//for better result use nullable or optional parameters

import 'package:fastran_agent_app_android/export/export.dart';

class CommonContainer extends StatelessWidget {
  final double widthSize;
  final double heightSize;
  final Color? color;
  final Widget? childWidget;
  final BoxBorder? border;
  final double? boarderRadiusSize;
  // the width and height is passed from parent widget
  final double width;
  final double height;
  const CommonContainer(
      {required this.heightSize,
      required this.widthSize,
      this.color,
      this.childWidget,
      this.boarderRadiusSize,
      this.border,
      required this.height,
      required this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Container(
       clipBehavior: Clip.antiAlias,
      height: height / heightSize,
      width: width / widthSize,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: BorderRadius.circular(boarderRadiusSize ?? 1)
      ),
      child: childWidget,
    );
  }
}
