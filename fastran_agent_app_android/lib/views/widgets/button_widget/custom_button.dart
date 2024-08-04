

//this class is custom made buttom and it's save item and space
// you can and any options to improve the features
// use nullable parameters so  work flow will optiional
// or give deafault values in case of null

import 'package:fastran_agent_app_android/export/export.dart';


class CustomButton extends StatelessWidget {
  final double widthSize;
  final double heightSize;
  final Color? color;
  final double? boarderRadiusSize;
  final double width;
  final double height;
  final String label;
  final Color? labelColor;

  const CustomButton({
    required this.heightSize,
    required this.widthSize,
    required this.label,
    this.labelColor,
    this.color,
    this.boarderRadiusSize,
    required this.height,
    required this.width,
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return  Container(
      width: width / widthSize,
      height: height / heightSize,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          boarderRadiusSize ?? 5,
        ),
      ),
      child: Center(
        child: CustomText(
          label: label,
          color: labelColor,
        ),
      ),
    );
  }
}
