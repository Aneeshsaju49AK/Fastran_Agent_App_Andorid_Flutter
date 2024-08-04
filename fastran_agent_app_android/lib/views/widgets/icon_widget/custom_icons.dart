
//this act like a normal icon 
// this class have call back function so if function is not null the function call will happen
// if the function call is null the nothing change

import 'package:fastran_agent_app_android/export/export.dart';

class CustomIcons extends StatelessWidget {
 final IconData iconChoosen;
 final double? sizeChoosen;
 final Function? function;

  const CustomIcons({super.key,
  required this.iconChoosen,
  this.sizeChoosen,
  this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(function != null){
          function!(context);
        }
      },
      child: Icon(iconChoosen,size: sizeChoosen,));
}}