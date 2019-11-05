import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jooding/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:jooding/blocs/bottom_navigation/bottom_navigation_event.dart';
import 'package:jooding/blocs/bottom_navigation/bottom_navigation_state.dart';
import 'package:jooding/ui/pages/pages.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBloc bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation with BLoC'),
      ),
      body: BlocBuilder<BottomNavigationEvent, BottomNavigationState>(
        bloc: bottomNavigationBloc,
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomePageLoaded) {
            return HomePage(data: state.data);
          }
          if (state is InputPageLoaded) {
            return InputPage(text: state.text);
          }
          if (state is MyPageLoaded) {
            return MyPage(account: state.account);
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationEvent, BottomNavigationState>(
          bloc: bottomNavigationBloc,
          builder: (BuildContext context, BottomNavigationState state) {
            return BottomNavigationBar(
              currentIndex: bottomNavigationBloc.currentIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.black),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle, color: Colors.black),
                  title: Text('Input'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle, color: Colors.black),
                  title: Text('My'),
                ),
              ],
              onTap: (index) => bottomNavigationBloc.dispatch(PageTapped(index: index)),
            );
          }
      ),
    );
  }
}