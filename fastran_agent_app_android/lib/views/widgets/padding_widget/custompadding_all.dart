
// this class a custom creation of padding to ALL sides
// you can assign only one value
//perform as the same like padding.All
import 'package:fastran_agent_app_android/export/export.dart';

class CustompaddingAll extends StatelessWidget {
  final double value;
  final Widget? childWidget;
  const CustompaddingAll({super.key, required this.value,this.childWidget,});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(value),child: childWidget,);
  }
}
