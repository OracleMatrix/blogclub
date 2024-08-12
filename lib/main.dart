import 'package:blogclub/article.dart';
import 'package:blogclub/gen/fonts.gen.dart';
import 'package:blogclub/home.dart';
import 'package:blogclub/profile.dart';
import 'package:blogclub/splash.dart';
import 'package:flutter/cupertino.dart';
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
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const int homeIndex = 0;
const int articleIndex = 1;
const int searchIndex = 2;
const int menuIndex = 3;
const double bottomNavigationHeight = 65;

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _articleKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _menuKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    articleIndex: _articleKey,
    searchIndex: _searchKey,
    menuIndex: _menuKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: bottomNavigationHeight,
              child: IndexedStack(
                index: selectedScreenIndex,
                children: [
                  _Navigator(_homeKey, homeIndex, const HomeScreen()),
                  _Navigator(_articleKey, articleIndex, const ArticleScreen()),
                  _Navigator(_searchKey, searchIndex, const SearchScreen()),
                  _Navigator(_menuKey, menuIndex, const ProfileScreen()),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomNavigation(
                (index) {
                  setState(() {
                    _history.remove(selectedScreenIndex);
                    _history.add(selectedScreenIndex);
                    selectedScreenIndex = index;
                  });
                },
                selectedScreenIndex,
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedScreenIndex != index,
                child: child,
              ),
            ),
          );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Search Screen",
                    style: Theme.of(context).textTheme.headlineMedium,
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

// ignore: unused_element
class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedIndex;
  const _BottomNavigation(
    this.onTap,
    this.selectedIndex,
  );

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
              height: bottomNavigationHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: const Color(0xff9B8487).withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BottomNavigationItem(
                    isActive: selectedIndex == homeIndex,
                    onTap: () {
                      onTap(homeIndex);
                    },
                    icon: CupertinoIcons.house_fill,
                    activeIcon: CupertinoIcons.house,
                    title: "Home",
                  ),
                  _BottomNavigationItem(
                    isActive: selectedIndex == articleIndex,
                    onTap: () {
                      onTap(articleIndex);
                    },
                    icon: CupertinoIcons.book,
                    activeIcon: CupertinoIcons.book_fill,
                    title: "Articles",
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  _BottomNavigationItem(
                    isActive: selectedIndex == searchIndex,
                    onTap: () {
                      onTap(searchIndex);
                    },
                    icon: CupertinoIcons.search,
                    activeIcon: CupertinoIcons.search,
                    title: "Search",
                  ),
                  _BottomNavigationItem(
                    isActive: selectedIndex == menuIndex,
                    onTap: () {
                      onTap(menuIndex);
                    },
                    icon: CupertinoIcons.circle_grid_3x3,
                    activeIcon: CupertinoIcons.circle_grid_3x3_fill,
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
  final IconData icon;
  final IconData activeIcon;
  final String title;
  final Function() onTap;
  final bool isActive;

  const _BottomNavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.onTap,
    required this.isActive,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? themeData.colorScheme.primary : Colors.grey,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: themeData.textTheme.labelSmall!.apply(
                color: isActive
                    ? themeData.colorScheme.primary
                    : themeData.textTheme.bodySmall!.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
