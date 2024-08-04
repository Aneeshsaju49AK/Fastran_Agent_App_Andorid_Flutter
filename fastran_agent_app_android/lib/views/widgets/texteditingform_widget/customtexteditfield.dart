
//custom made foe TextEditingfield
//takes as keybordtype, validator,controller
//not given lot of feature but you trying to given then use optional parameters
import 'package:fastran_agent_app_android/export/export.dart';

class Customtexteditfield extends StatelessWidget {
  final TextInputType keyboardType;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const Customtexteditfield({
    super.key,
    required this.keyboardType,
    this.controller,
    this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // return CupertinoTextField(
    //   keyboardType: keyboardType,
    //   controller: controller,
    //   placeholder: label,
    //   decoration: BoxDecoration(
    //     color: Colors.black
    //   ),
    // );
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      style: const TextStyle(
        
      ),
      decoration: InputDecoration(
        labelText: label,labelStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black)
        
      ),
    );
  }
}
