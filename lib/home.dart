import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jooding/repositories/home_page.dart';
import 'package:jooding/repositories/input_page.dart';
import 'package:jooding/repositories/my_page.dart';
import 'package:jooding/blocs/bottom_navigation/bottom_navigation_event.dart';
import 'package:jooding/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:jooding/ui/app_screen.dart';

class SimpleBlocDelegate extends StatefulWidget with BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  SimpleBlocDelegateState createState() => new SimpleBlocDelegateState();
}

// void main() {
//   BlocSupervisor.delegate = SimpleBlocDelegate();
//   runApp(App());
// }

class SimpleBlocDelegateState extends State<SimpleBlocDelegate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<BottomNavigationBloc>(
        builder: (context) => BottomNavigationBloc(
          homePage: HomePage(),
          inputPage: InputPage(),
          myPage: MyPage()
        )  ..dispatch(AppStarted()),
        child: AppScreen(),
      )
    );
  }
}