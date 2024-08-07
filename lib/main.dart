import 'package:blogclub/article.dart';
import 'package:blogclub/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff0D253C);
    const secondaryTextColor = Color(0xff2D4379);
    const primaryColor = Color(0xff376AED);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlogClub',
      theme: ThemeData(
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          titleSpacing: 32,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: primaryTextColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.avenir,
              ),
            ),
          ),
        ),
        textTheme: const TextTheme(
          labelSmall: TextStyle(
            fontFamily: FontFamily.avenir,
            fontWeight: FontWeight.w700,
            color: Color(0xff7B8BB2),
            fontSize: 10,
          ),
          bodySmall: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
            fontSize: 15,
          ),
          titleLarge: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
            fontWeight: FontWeight.w200,
            fontSize: 18,
          ),
          headlineMedium: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: primaryTextColor),
          titleMedium: TextStyle(
            fontFamily: FontFamily.avenir,
            color: primaryTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          onSurface: Colors.white,
          surface: Color(0xffFBFCFF),
        ),
        useMaterial3: false,
      ),
      // home: const Stack(
      //   children: [
      //     Positioned.fill(
      //       child: HomeScreen(),
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       right: 0,
      //       left: 0,
      //       child: _BottomNavigation(),
      //     )
      //   ],
      // ),
      home: const ArticleScreen(),
    );
  }
}

// ignore: unused_element
class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: const Color(0xff9B8487).withOpacity(0.3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BottomNavigationItem(
                    iconeFileName: "Home.png",
                    activeIconeFileName: "Home.png",
                    title: "Home",
                  ),
                  _BottomNavigationItem(
                    iconeFileName: "Articles.png",
                    activeIconeFileName: "Articles.png",
                    title: "Articles",
                  ),
                  SizedBox(width: 8),
                  _BottomNavigationItem(
                    iconeFileName: "Search.png",
                    activeIconeFileName: "Search.png",
                    title: "Search",
                  ),
                  _BottomNavigationItem(
                    iconeFileName: "Menu.png",
                    activeIconeFileName: "Menu.png",
                    title: "Menu",
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 65,
              height: 85,
              alignment: Alignment.topCenter,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                    color: const Color(
                      0xff376AED,
                    ),
                    borderRadius: BorderRadius.circular(32.5),
                    border: Border.all(color: Colors.white, width: 4)),
                child: Image.asset("assets/img/icons/plus.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final String iconeFileName;
  final String activeIconeFileName;
  final String title;

  const _BottomNavigationItem(
      {required this.iconeFileName,
      required this.activeIconeFileName,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/img/icons/$iconeFileName"),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
