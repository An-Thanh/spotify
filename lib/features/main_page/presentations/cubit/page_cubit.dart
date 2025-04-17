import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:spotify_clone/features/home_page/presentations/screens/home.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  bool isMiniPlayer = false;
  PageCubit() : super(PageInitial(
    selectedIndex: 0,
    isMiniPlayer: false
  ));
  List<Widget> pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ]; 
  void changePage(int index, bool isMiniPlayer){
    this.isMiniPlayer = isMiniPlayer;
    emit(PageInitial(
      selectedIndex: index,
      isMiniPlayer: isMiniPlayer
    ));
  }
}
