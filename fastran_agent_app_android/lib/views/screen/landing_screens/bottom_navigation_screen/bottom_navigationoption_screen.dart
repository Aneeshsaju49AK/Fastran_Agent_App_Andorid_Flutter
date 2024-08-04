


import 'package:fastran_agent_app_android/export/export.dart';

ValueNotifier<int> indexChangeNotifer = ValueNotifier(0);

class BottomNavigationoptionScreen extends StatelessWidget {
   BottomNavigationoptionScreen({super.key});

  final _pages =  [
    HomeLoadScreen(),
    
    HomeMapScreen(),
    HomeScreen(),
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifer,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
