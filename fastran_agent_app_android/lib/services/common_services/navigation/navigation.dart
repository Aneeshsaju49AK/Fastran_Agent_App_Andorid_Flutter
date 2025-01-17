

// this file contain the common function that are resused
//this page for common navigation function


import 'package:fastran_agent_app_android/export/export.dart';

void navigateToScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void navigateToScreenReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}


void navigationPopScreen(BuildContext context){
  Navigator.pop(context);
}