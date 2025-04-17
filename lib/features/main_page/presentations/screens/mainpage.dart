import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/features/home_page/presentations/screens/home.dart';
import 'package:spotify_clone/features/main_page/presentations/cubit/page_cubit.dart';
import 'package:spotify_clone/features/song_player/presentations/widget/mini_player.dart';

class NavBottomBar extends StatefulWidget {
  const NavBottomBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavBottomBarState createState() => _NavBottomBarState();
}

class _NavBottomBarState extends State<NavBottomBar> {
  List<Widget> pages = [
    const HomePage(),
    const Center(child: Text('search')),
    const Center(child: Text('favourite')),
    const Center(child: Text('profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        if(state is PageInitial) {
          return Scaffold(
          body: Stack(
            children: [
              pages[state.selectedIndex],
              if (state.isMiniPlayer)
              Align(
                alignment: Alignment.bottomCenter,
                child: MiniPlayer(),
              ),
            ]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: !context.isDarkMode ? Colors.white : Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: state.selectedIndex,
              onTap: (index){
                BlocProvider.of<PageCubit>(context).changePage(index, state.isMiniPlayer);
              } ,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home, color: Colors.green),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search, color: Colors.green),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite, color: Colors.green),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person, color: Colors.green),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
