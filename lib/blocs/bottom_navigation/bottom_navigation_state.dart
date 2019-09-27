import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:jooding/models/account.dart';

@immutable
abstract class BottomNavigationState extends Equatable {
  BottomNavigationState([List props = const []]) : super(props);
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex}) : super([currentIndex]);

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class HomePageLoaded extends BottomNavigationState {
  final String text;

  HomePageLoaded({@required this.text}) : super([text]);

  @override
  String toString() => 'HomePageLoaded with text: $text';
}

class InputPageLoaded extends BottomNavigationState {
  final String text;

  InputPageLoaded({@required this.text}) : super([text]);

  @override
  String toString() => 'InputPageLoaded with text: $text';
}

class MyPageLoaded extends BottomNavigationState {
  final Account account;

  MyPageLoaded({@required this.account}) : super([account]);

  @override
  String toString() => 'MyPageLoaded with account: $account';
}