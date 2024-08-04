
// in this class i given option to give padding to any side you need
// also if values not given default value will 0

import 'package:fastran_agent_app_android/export/export.dart';

class CustompaddingOnly extends StatelessWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final Widget? childWidget;

  const CustompaddingOnly({
    this.childWidget,
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottom ?? 0,
        left: left ?? 0,
        top: top ?? 0,
        right: right ?? 0,
      ),
      child: childWidget,
    );
  }
}
