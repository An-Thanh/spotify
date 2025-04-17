enum SearchType{
  track,
  artist,
  album,
  playlist
}

extension SearchTypeExtension on SearchType{
  String get name{
    switch (this) {
      case SearchType.track:
        return 'track';
      case SearchType.artist:
        return 'artist';
      case SearchType.album:
        return 'album';
      case SearchType.playlist:
        return 'playlist';
      default:
        return '';
    }
  }
}