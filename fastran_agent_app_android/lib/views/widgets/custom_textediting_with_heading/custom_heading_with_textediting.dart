import 'package:fastran_agent_app_android/export/export.dart';

class CommonHeadWithTextfield extends StatelessWidget {
  const CommonHeadWithTextfield({
    super.key,
    required this.height,
    required this.width,
    required this.label,
    required this.controller,
  });

  final double height;
  final double width;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      heightSize: 11,
      widthSize: 1,
      height: height,
      width: width,
      childWidget: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              label: label,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: CommonContainer(
                height: height,
                width: width,
                widthSize: 1,
                heightSize: 22,
                childWidget: Customtexteditfield(
                    keyboardType: TextInputType.emailAddress,
                    controller: controller,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
