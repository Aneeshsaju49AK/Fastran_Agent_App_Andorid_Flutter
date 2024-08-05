import 'package:fastran_agent_app_android/export/export.dart';

String generateOtp() {
  final random = Random();
  final otp = random.nextInt(900000) + 100000; // Generates a 6-digit number
  return otp.toString();
}
void validateOtp(BuildContext context, String enteredOtp, String generatedOtp) {
  print(enteredOtp);
  print(generatedOtp);
  if (enteredOtp == generatedOtp) {
    navigateToScreen(context, BottomNavigationoptionScreen());
  } else {
    final snackBar = SnackBar(
      content: Text('Incorrect OTP. Please try again.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


void showTopSnackBar(String otp, BuildContext context, String? number) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final overlay = Overlay.of(context);

    // Define the overlay entry variable
    OverlayEntry? overlayEntry;

    // Create the overlay entry
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Your $number OTP is $otp',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    overlayEntry!.remove();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    overlay.insert(overlayEntry);

    // Automatically remove the overlay entry after 6 seconds
    Future.delayed(Duration(seconds: 6), () {
      overlayEntry!.remove();
    });
  });
}
