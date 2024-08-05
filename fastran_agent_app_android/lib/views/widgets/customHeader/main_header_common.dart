import 'package:fastran_agent_app_android/export/export.dart';

class MainHeaderCommon extends StatelessWidget {
  const MainHeaderCommon({
    super.key,
    required this.height,
    required this.width,
    this.headLabel,
    this.subLabel,
    required this.isIconwidgetNeeded,
    this.handleIconButtom,
  });
  final String? headLabel;
  final String? subLabel;
  final double height;
  final double width;
  final bool isIconwidgetNeeded;
  final Function? handleIconButtom;
  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      heightSize: 5,
      widthSize: 1,
      height: height,
      width: width,
      border: BorderDirectional(
        bottom: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.withOpacity(0.3),
            width: 1),
      ),
      childWidget: Column(
        children: [
          CommonContainer(
            heightSize: 14,
            widthSize: 1,
            height: height,
            width: width,
            color: Colors.white,
            childWidget: Row(
              children: [
                // in this icon button a onTap is given
                //in tha onTap a pop function called navigationPopScreen
                //the navigationPopScreen need 1 Parameter to perform
                //current BuildContext
                //
                CustompaddingOnly(
                  left: 5,
                  right: 5,
                  childWidget: CustomIcons(
                    iconChoosen: Icons.navigate_before,
                    sizeChoosen: 27,
                    function: (context) => navigationPopScreen(context),
                  ),
                ),
                const CustomText(
                  label: 'Back',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
          CommonContainer(
            heightSize: 8,
            widthSize: 1,
            height: height,
            width: width,
            color: Colors.white,
            childWidget: CustompaddingAll(
              value: 10,
              childWidget: Row(
                children: [
                  CommonContainer(
                    heightSize: 3,
                    widthSize: 1.4,
                    height: height,
                    width: width,
                    childWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          label: headLabel ?? '',
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                        CustomText(
                          label: subLabel ?? '',
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                  ),
                  if (isIconwidgetNeeded)
                    CommonContainer(
                      heightSize: 3,
                      widthSize: 4.5,
                      height: height,
                      width: width,
                      childWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonContainer(
                            heightSize: 13,
                            widthSize: 6,
                            height: height,
                            width: width,
                            boarderRadiusSize: 15,
                            color: Colors.black,
                            childWidget: IconButton(
                              onPressed: () {
                                if (handleIconButtom != null) {
                                  handleIconButtom!();
                                }
                              },
                              icon: const Icon(Icons.add, color: Colors.white,size: 40,),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
