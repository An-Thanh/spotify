import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';
import 'package:spotify_clone/features/song_player/presentations/cubit/song_player_cubit.dart';
import 'package:spotify_clone/features/song_player/presentations/cubit/song_player_state.dart';
import 'package:spotify_clone/features/song_player/presentations/screens/song_player.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoaded) {
          SongEntity song = state.currentSong;
          bool isPlaying = state.isPlaying;
          Duration position = state.position;
          Duration duration = state.duration;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SongPlayer(
                    displayed_song: song,
                    isnewSong: false,
                  ),
                ),
              );
            },
            child: Stack(clipBehavior: Clip.none, children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? AppColors.greyDark
                        : AppColors.greyLight.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // Hình ảnh bài hát
                            const SizedBox(width: 62),
                            // Tiêu đề bài hát và nghệ sĩ
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.title.trim(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    song.artist.trim(),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            // Nút phát/tạm dừng
                            IconButton(
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: () {
                                context.read<SongPlayerCubit>().playOrPauseSong();
                              },
                            ),
                          ],
                        ),
                        // Slider hiển thị tiến trình phát nhạc
                        Slider(
                          value: position.inSeconds.toDouble(),
                          max: duration.inSeconds.toDouble(),
                          activeColor: AppColors.primary,
                          inactiveColor: Colors.grey,
                          onChanged: (value) {
                            context
                                .read<SongPlayerCubit>()
                                .seekTo(Duration(seconds: value.toInt()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -15, // Đẩy ảnh lên trên Container
                left: 16, // Căn lề trái
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    song.cover,
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ]),
          );
        } else {
          return const SizedBox.shrink(); // Không hiện nếu chưa có bài hát nào
        }
      },
    );
  }
}
