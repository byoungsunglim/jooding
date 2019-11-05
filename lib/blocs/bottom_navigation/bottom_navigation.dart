import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bottom_navigation_event.dart';
import 'bottom_navigation_state.dart';
import 'package:jooding/repositories/home_page.dart';
import 'package:jooding/repositories/input_page.dart';
import 'package:jooding/repositories/my_page.dart';
import 'package:jooding/models/account.dart';

import 'package:device_calendar/device_calendar.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final HomePage homePage;
  final InputPage inputPage;
  final MyPage myPage;
  int currentIndex = 0;

  BottomNavigationBloc({
    this.homePage,
    this.inputPage,
    this.myPage,
  })  : assert(homePage != null),
        assert(inputPage != null),
        assert(myPage != null);

  Future<List<Calendar>> _getHomePageData() async {
    List<Calendar> _calendars = homePage.data;
    if (_calendars == null) {
      await homePage.fetchData();
      _calendars = homePage.data;
    }
    return _calendars;
  }

  Future<String> _getInputPageData() async {
    String data = inputPage.data;
    if (data == null) {
      await inputPage.fetchData();
      data = inputPage.data;
    }
    return data;
  }

  Future<Account> _getMyPageData() async {
    Account data = myPage.data;
    if (data == null) {
      await myPage.fetchData();
      data = myPage.data;
    }
    return data;
  }

  @override
  BottomNavigationState get initialState => PageLoading();

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is AppStarted) {
      this.dispatch(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 0) {
        List<Calendar> data = await _getHomePageData();
        yield HomePageLoaded(data: data);
      }
      if (this.currentIndex == 1) {
        String data = await _getInputPageData();
        yield InputPageLoaded(text: data);
      }
      if (this.currentIndex == 2) {
        Account data = await _getMyPageData();
        yield MyPageLoaded(account: data);
      }
    }
  }
}
