import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/travel_repository.dart';
import 'viewmodels/travel_viewmodel.dart';
import 'screens/search_screen.dart';
import 'screens/swipe_screen.dart';
import 'screens/likes_screen.dart';
import 'components/bottom_nav_bar.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TravelRepository()),
        ChangeNotifierProxyProvider<TravelRepository, TravelViewModel>(
          create: (context) => TravelViewModel(context.read<TravelRepository>()),
          update: (context, repository, viewModel) => 
            viewModel ?? TravelViewModel(repository),
        ),
      ],
      child: MaterialApp(
        title: 'TravelSwipr',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _hasSearched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildCurrentScreen() {
    // Always show search screen first until search is completed
    if (_currentIndex == 0 && !_hasSearched) {
      return SearchScreen(
        onSearchComplete: () {
          setState(() {
            _hasSearched = true;
            _currentIndex = 1; // Move to swipe screen after search
          });
        },
      );
    }

    // After first search is done, normal navigation works
    switch (_currentIndex) {
      case 0:
        return SearchScreen(
          onSearchComplete: () {
            setState(() {
              _currentIndex = 1; // Move to swipe screen after search
            });
          },
        );
      case 1:
        return SwipeScreen();
      case 2:
        return LikesScreen();
      default:
        return SwipeScreen();
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
