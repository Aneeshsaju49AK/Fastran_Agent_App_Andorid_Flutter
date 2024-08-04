
//custom class for SizedBox 
// to ensure coding standard
import 'package:fastran_agent_app_android/export/export.dart';

class CustomSizedBox extends StatelessWidget {
  final double width;
  final double height;
  final double widthSize;
  final double heightSize;
  final Widget? childWidget;
  const CustomSizedBox({
    required this.width,
    required this.height,
    required this.widthSize,
    required this.heightSize,
    this.childWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / widthSize,
      height: height / heightSize,
      child: childWidget,
    );
  }
}
