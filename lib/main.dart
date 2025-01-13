import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/utils/colors.dart';

import 'Screens/HomePage.dart';
import 'cubit/show_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShowCubit()), // Provide ShowCubit here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
 final currentIndex = 0;
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            textTheme: TextTheme(
                bodyLarge: GoogleFonts.quicksand(
                    textStyle: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold)),
                bodyMedium: GoogleFonts.quicksand(
                    textStyle: TextStyle(color: AppColors.primary)),
              bodySmall: GoogleFonts.quicksand(
                    textStyle: TextStyle(color: AppColors.primary,)),
            )
        ),
        home: Scaffold(
          body: HomePage(),
        ));
  }
}
