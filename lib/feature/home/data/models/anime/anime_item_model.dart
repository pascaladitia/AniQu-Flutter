class AnimeItemModel {
  AnimeItemModel({
    String? title,
    String? slug,
    String? poster,
    String? episode,
    String? statusOrDay,
    String? type,
  }) {
    _title = title;
    _slug = slug;
    _poster = poster;
    _episode = episode;
    _statusOrDay = statusOrDay;
    _type = type;
  }

  AnimeItemModel.fromJson(dynamic json) {
    _title = json['title'];
    _slug = json['slug'];
    _poster = json['poster'];
    _episode = json['episode'];
    _statusOrDay = json['status_or_day'];
    _type = json['type'];
  }

  String? _title;
  String? _slug;
  String? _poster;
  String? _episode;
  String? _statusOrDay;
  String? _type;

  AnimeItemModel copyWith({
    String? title,
    String? slug,
    String? poster,
    String? episode,
    String? statusOrDay,
    String? type,
  }) => AnimeItemModel(
    title: title ?? _title,
    slug: slug ?? _slug,
    poster: poster ?? _poster,
    episode: episode ?? _episode,
    statusOrDay: statusOrDay ?? _statusOrDay,
    type: type ?? _type,
  );

  String? get title => _title;

  String? get slug => _slug;

  String? get poster => _poster;

  String? get episode => _episode;

  String? get statusOrDay => _statusOrDay;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['slug'] = _slug;
    map['poster'] = _poster;
    map['episode'] = _episode;
    map['status_or_day'] = _statusOrDay;
    map['type'] = _type;
    return map;
  }

  factory AnimeItemModel.fromMap(Map<String, dynamic> map) {
    return AnimeItemModel(
      title: map['title'] as String,
      slug: map['slug'] as String,
      poster: map['poster'] as String,
      episode: map['episode'] as String,
      statusOrDay: map['status_or_day'] as String,
      type: map['type'] as String
    );
  }
}
