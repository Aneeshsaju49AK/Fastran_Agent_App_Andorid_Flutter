import 'package:fastran_agent_app_android/export/export.dart';

////////////////////////////////////////////////////////
class HomeOtpScreen extends StatefulWidget {
  final String? mobileNumber;
  const HomeOtpScreen({super.key, this.mobileNumber});

  @override
  State<HomeOtpScreen> createState() => _HomeOtpScreenState();
}

class _HomeOtpScreenState extends State<HomeOtpScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  String generatedOtp = '';

  @override
  void initState() {
    super.initState();
    if (widget.mobileNumber?.isNotEmpty == true) {
      generatedOtp = generateOtp();
      showTopSnackBar(generatedOtp, context,
          widget.mobileNumber); // Show the OTP via a top SnackBar
    }
  }

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
                subLabel: widget.mobileNumber?.isNotEmpty == true
                    ? 'code +91${widget.mobileNumber}'
                    : 'code +91**********',
              ),
              CustompaddingOnly(
                top: 15,
                childWidget: CommonContainer(
                  heightSize: 1.5,
                  widthSize: 1,
                  height: height,
                  width: width,
                  color: Colors.white,
                  border: BorderDirectional(
                      top: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey.withOpacity(0.3),
                          width: 1)),
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
                                        controller: _otpControllers[index],
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
                                            _focusNodes[index + 1]
                                                .requestFocus();
                                          } else if (value.isEmpty &&
                                              index > 0) {
                                            _focusNodes[index - 1]
                                                .requestFocus();
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const CustomText(label: "Didn't receive code?"),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    generatedOtp = generateOtp();
                                  });
                                  showTopSnackBar(generatedOtp, context,
                                      widget.mobileNumber);
                                },
                                child: const CustomText(label: "Resend Code"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    final enteredOtp = _otpControllers
                        .map((controller) => controller.text)
                        .join();
                    validateOtp(context, enteredOtp, generatedOtp);
                  },
                  child: CustomButton(
                    heightSize: 13,
                    widthSize: 1.1,
                    label: 'Verify & Proceed',
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
