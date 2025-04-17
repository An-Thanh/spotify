import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  final CollectionReference _songsCollection =
      FirebaseFirestore.instance.collection('songs');

  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data =
          await _songsCollection.orderBy('releaseDate', descending: true).limit(4).get();
      if (data.docs.isNotEmpty) {
        for (var element in data.docs) {
          songs.add(SongEntity(
            id: element.id,
            title: element['title'],
            artist: element['artist'],
            cover: element['cover'],
            url: element['url'],
            duration: element['duration'],
            releaseDate: element['releaseDate'],
          ));
        }
        return Right(songs);
      } else {
        return const Left('No songs found');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      // Lấy tài liệu tại vị trí thứ 3
      var snapshot = await _songsCollection
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
      var lastDocument = snapshot.docs.last;

      // Truy vấn từ tài liệu thứ 3 trở đi
      var data = await _songsCollection
          .orderBy('releaseDate', descending: true)
          .startAfterDocument(lastDocument).limit(50)
          .get();
      if (data.docs.isNotEmpty) {
        for (var element in data.docs) {
          songs.add(SongEntity(
            id: element.id,
            title: element['title'],
            artist: element['artist'],
            cover: element['cover'],
            url: element['url'],
            duration: element['duration'],
            releaseDate: element['releaseDate'],
          ));
        }
        return Right(songs);
      } else {
        return const Left('No songs found');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
