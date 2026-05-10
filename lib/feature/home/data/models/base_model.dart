class BaseModel<T> {
  final String? status;
  final String? creator;
  final String? source;
  final T? animes;
  final Pagination? pagination;

  const BaseModel({
    this.status,
    this.creator,
    this.source,
    this.animes,
    this.pagination,
  });

  BaseModel<T> copyWith({
    String? status,
    String? creator,
    String? source,
    T? animes,
    Pagination? pagination,
  }) {
    return BaseModel<T>(
      status: status ?? this.status,
      creator: creator ?? this.creator,
      source: source ?? this.source,
      animes: animes ?? this.animes,
      pagination: pagination ?? this.pagination,
    );
  }

  factory BaseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return BaseModel<T>(
      status: json['status'] as String?,
      creator: json['creator'] as String?,
      source: json['source'] as String?,
      animes: json['animes'] != null ? fromJsonT(json['animes']) : null,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'status': status,
      'creator': creator,
      'source': source,
      'animes': animes != null ? toJsonT(animes as T) : null,
      'pagination': pagination?.toJson(),
    };
  }
}

class Pagination {
  final int? currentPage;
  final bool? hasNext;
  final int? lastVisiblePage;

  const Pagination({this.currentPage, this.hasNext, this.lastVisiblePage});

  Pagination copyWith({int? currentPage, bool? hasNext, int? lastVisiblePage}) {
    return Pagination(
      currentPage: currentPage ?? this.currentPage,
      hasNext: hasNext ?? this.hasNext,
      lastVisiblePage: lastVisiblePage ?? this.lastVisiblePage,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] as int?,
      hasNext: json['has_next'] as bool?,
      lastVisiblePage: json['last_visible_page'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'has_next': hasNext,
      'last_visible_page': lastVisiblePage,
    };
  }
}
