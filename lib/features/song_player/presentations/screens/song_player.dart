import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';
import 'package:spotify_clone/features/main_page/presentations/cubit/page_cubit.dart';
import 'package:spotify_clone/features/song_player/presentations/cubit/song_player_cubit.dart';
import 'package:spotify_clone/features/song_player/presentations/cubit/song_player_state.dart';

class SongPlayer extends StatefulWidget {
  final SongEntity displayed_song;
  final bool isnewSong;

  const SongPlayer({super.key, required this.displayed_song, required this.isnewSong});

  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {

  @override
  Widget build(BuildContext context) {
    if(widget.isnewSong) {
      context.read<SongPlayerCubit>().loadSong(widget.displayed_song);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
              color: context.isDarkMode ? Colors.white : Colors.black,
              Icons.arrow_circle_left_outlined),
        ),
        centerTitle: true,
        title: Text(
          'Now playing',
          style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
        child: Column(children: [
          _songCover(context, widget.displayed_song),
          const SizedBox(height: 30),
          _songDetail(context, widget.displayed_song),
          const SizedBox(height: 30),
          _songPlayer(widget.displayed_song, context)
        ]),
      ),
    );
  }

  Widget _songDetail(BuildContext context, SongEntity song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  song.artist,
                  style: TextStyle(
                    fontSize: 20,
                    color: context.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
        Icon(
          Icons.favorite_border,
          color: context.isDarkMode ? Colors.white70 : Colors.black54,
          size: 35,
        ),
      ],
    );
  }

  Widget _songPlayer(SongEntity song, BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
      if (state is SongPlayerLoading) {
        return const CircularProgressIndicator();
      } else if (state is SongPlayerLoaded) {
        final position = state.position.inSeconds.toDouble();
        final duration = state.duration.inSeconds.toDouble();

        return Column(
          children: [
            Slider(
              thumbColor: context.isDarkMode ? Colors.white : Colors.black,
              value: position.clamp(0.0, duration),
              min: 0.0,
              max: duration,
              onChanged: (value) {
                // Optionally seek to new position:
                if(position != duration) {
                  context.read<SongPlayerCubit>().seekTo(Duration(seconds: value.toInt()));
                }
                else{
                  context.read<SongPlayerCubit>().seekTo(Duration.zero);
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(
                    state.position
                  )
                ),
                Text(
                  formatDuration(
                    state.duration
                  )
                )
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                context.read<SongPlayerCubit>().playOrPauseSong();
              },
              child: Container(
                height: 60,
                width:  60,
                child: Icon(
                  context.read<SongPlayerCubit>().player.playing ? Icons.pause : Icons.play_arrow
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary
                ),
              ),
            )
          ],
        );
        return CircularProgressIndicator();
      }
      else {
         return Container();
      }
    });
  }

  String formatDuration(Duration duration){
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }

  Widget _songCover(BuildContext context, SongEntity song) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(song.cover),
            )),
        height: MediaQuery.of(context).size.height / 2.4);
  }
}
