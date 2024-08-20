import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/screens/LoginScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      designSize: Size(375, 825),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hostel Management System',
        home: LoginScreen(),
      ),
    );
  }
}
