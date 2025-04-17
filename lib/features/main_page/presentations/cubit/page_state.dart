// ignore_for_file: must_be_immutable

part of 'page_cubit.dart';

@immutable
sealed class PageState {}

final class PageInitial extends PageState {
  bool isMiniPlayer =false;
  int selectedIndex = 0;
  PageInitial({
    required this.selectedIndex,
    required this.isMiniPlayer
  });
}
