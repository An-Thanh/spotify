import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';
import 'package:spotify_clone/features/home_page/presentations/bloc/play_list/play_list_cubit.dart';
import 'package:spotify_clone/features/home_page/presentations/bloc/play_list/play_list_state.dart';
import 'package:spotify_clone/features/home_page/presentations/bloc/song/news_song_cubit.dart';
import 'package:spotify_clone/features/home_page/presentations/bloc/song/news_song_state.dart';
import 'package:spotify_clone/features/main_page/presentations/cubit/page_cubit.dart';
import 'package:spotify_clone/routes/app_route.dart';

class NewSongs extends StatelessWidget {
  NewSongs({super.key});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewsSongCubit()..getNewsSong()),
        BlocProvider(create: (_) => PlayListCubit()..getPlayList()),
      ],
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<NewsSongCubit, NewsSongState>(
              builder: (context, state) {
                if (state is NewsSongLoadingState) {
                  return const SizedBox(
                    height: 240,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is NewsSongLoadedState &&
                    state.songs.isNotEmpty) {
                  return SizedBox(
                    height: 240,
                    child: _songs(state.songs, context),
                  );
                } else {
                  return const SizedBox(); 
                }
              },
            ),
            const SizedBox(height: 30),
            _playlistSection(context),
          ],
        ),
      ),
    );
  }

  Widget _playlistSection(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      builder: (context, state) {
        if (state is PlayListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlayListLoadedState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: context.isDarkMode ? Colors.white: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle "See More" action
                        },
                        child: Text(
                          'See More',
                          style: TextStyle(
                            fontSize: 14,
                            color: context.isDarkMode ? Colors.white.withOpacity(0.2): Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.songs.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final song = state.songs[index];
                    return GestureDetector(
                      child: _playlistItem(song, context),
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.displayed_song, arguments: song).then((value){
                            context.read<PageCubit>().changePage(0, true);
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is PlayListErrorState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }

  Widget _playlistItem(SongEntity song, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.isDarkMode
                          ? AppColors.darkBackground.withOpacity(0.9)
                          : AppColors.greyDark,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white ,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  song.artist,
                  style:  TextStyle(
                    fontSize: 12,
                    color: context.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              song.duration.toString(),
              style: TextStyle(
                fontSize: 12,
                color: context.isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.favorite_border,
              color: context.isDarkMode ? Colors.white70 : Colors.black54,
              size: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget _songs(List<SongEntity> songs, BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: songs.length,
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.displayed_song, arguments: songs[index]).then((value){
              context.read<PageCubit>().changePage(0, true);
            });
          },
          child: _buildSongCard(songs[index], context)
        );
      },
    );
  }

  Widget _buildSongCard(SongEntity song, BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(song.cover),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    transform: Matrix4.translationValues(10, 10, 0),
                    margin: const EdgeInsets.all(8),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? AppColors.darkBackground.withOpacity(0.9)
                          : AppColors.greyDark,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )),
          ),
          const SizedBox(height: 10),
          Text(
            song.title.trim(),
            style:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:context.isDarkMode? Colors.white : Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            song.artist.trim(),
            style: TextStyle(
              fontSize: 10,
              color: context.isDarkMode ?  Colors.white70: Colors.black54, 
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
