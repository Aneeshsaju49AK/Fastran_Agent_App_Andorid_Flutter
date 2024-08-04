import 'package:fastran_agent_app_android/export/export.dart';
import 'package:fastran_agent_app_android/views/screen/otpverification_screen/home_otp_screen.dart';

class HomeLoginScreen extends StatefulWidget {
  final String labelChoosen;
  final String underLineLabel;

  const HomeLoginScreen({
    super.key,
    required this.labelChoosen,
    required this.underLineLabel,
  });

  @override
  State<HomeLoginScreen> createState() => _HomeLoginScreenState();
}

class _HomeLoginScreenState extends State<HomeLoginScreen> {
  late final String labelhead;
  late final String underLineLabel;
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    labelhead = widget.labelChoosen;
    underLineLabel = widget.underLineLabel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonContainer(
              heightSize: 5,
              widthSize: 1,
              height: height,
              width: width,
              color: Colors.white,
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
                        ),
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
                      childWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            label: labelhead,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                          // CustomText(
                          //   label: underLineLabel,
                          //   color: Colors.grey,
                          //   fontWeight: FontWeight.w700,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustompaddingOnly(
              top: 20,
              childWidget: CommonContainer(
                heightSize: 9,
                widthSize: 1,
                height: height,
                width: width,
                color: Colors.white,
                border: BorderDirectional(
                    bottom: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.grey.withOpacity(0.3),
                        width: 1),
                    top: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.grey.withOpacity(0.3),
                        width: 1)),
                childWidget: Row(
                  children: [
                    // CommonContainer(
                    //   heightSize: 10,
                    //   widthSize: 4.4,
                    //   height: height,
                    //   width: width,
                    //   childWidget: const CustompaddingOnly(
                    //     left: 8,
                    //     right: 8,
                    //     childWidget: Customtexteditfield(
                    //       keyboardType: TextInputType.phone,
                    //       label: "Code",
                    //     ),
                    //   ),
                    // ),
                    CustompaddingOnly(
                      left: 5,
                      childWidget: CommonContainer(
                        heightSize: 10,
                        widthSize: 1.1,
                        height: height,
                        width: width,
                        childWidget: CustompaddingOnly(
                          left: 8,
                          right: 8,
                          childWidget: Customtexteditfield(
                            keyboardType: TextInputType.phone,
                            label: 'Mobile Number',
                            controller: _mobileNumberController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    navigateToScreen(
                        context, const  HomeOtpScreen());
                  },
                  child: CustomButton(
                    heightSize: 13,
                    widthSize: 1.1,
                    label: 'Next',
                    height: height,
                    width: width,
                    color: Colors.black,
                    labelColor: Colors.white,
                    boarderRadiusSize: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
