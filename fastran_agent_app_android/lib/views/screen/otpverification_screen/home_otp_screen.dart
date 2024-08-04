import 'package:fastran_agent_app_android/export/export.dart';

////////////////////////////////////////////////////////
class HomeOtpScreen extends StatefulWidget {
  const HomeOtpScreen({super.key});

  @override
  State<HomeOtpScreen> createState() => _HomeOtpScreenState();
}

class _HomeOtpScreenState extends State<HomeOtpScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final String requiredOtp = '2468';
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainHeaderCommon(
                height: height,
                width: width,
                isIconwidgetNeeded: false,
                headLabel: "Verification",
                subLabel: 'code +918848209619',
              ),
              CommonContainer(
                heightSize: 1.5,
                widthSize: 1,
                height: height,
                width: width,
                color: const Color.fromARGB(255, 235, 234, 227),
                childWidget: Column(
                  children: [
                    CustompaddingOnly(
                      top: 33,
                      childWidget: CommonContainer(
                        heightSize: 5,
                        widthSize: 1,
                        height: height,
                        width: width,
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Pinput(
                            //   controller: otpController,
                            // ),
                            CommonContainer(
                              heightSize: 10,
                              widthSize: 1,
                              height: height,
                              width: width,
                              childWidget: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(6, (index) {
                                  return SizedBox(
                                    width: 40,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      focusNode: _focusNodes[index],
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1 && index < 5) {
                                          _focusNodes[index + 1].requestFocus();
                                          // FocusScope.of(context).nextFocus();
                                        } else if (value.isEmpty && index > 0) {
                                          _focusNodes[index - 1].requestFocus();
                                          // FocusScope.of(context)
                                          //     .previousFocus();
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const CustomText(label: "Did't receive code?"),
                            const CustomText(label: "Resend Code"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    navigateToScreen(
                        context, BottomNavigationoptionScreen());
                  },
                  child: CustomButton(
                    heightSize: 13,
                    widthSize: 1.1,
                    label: 'verifly & Proced',
                    height: height,
                    width: width,
                    color: Colors.black,
                    labelColor: Colors.white,
                    boarderRadiusSize: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      color: Colors.white,
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
                            color: Colors.grey,
                            childWidget: IconButton(
                              onPressed: () {
                                if (handleIconButtom != null) {
                                  handleIconButtom!();
                                }
                              },
                              icon: const Icon(Icons.add),
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
