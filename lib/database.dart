import 'package:cloud_firestore/cloud_firestore.dart' ;

class Movies{
  final String name;
  final String url;
  final String poster;

  Movies({
    required this.name,
    required this.url,
    required this.poster,
  });

  static getMovie(String name) async {
  return await FirebaseFirestore.instance
      .collection("movies")
      .where("name", isLessThanOrEqualTo: name.toString())
      .get();
}

  Map<String, dynamic> toJson() => {

    'name' : name,
    'url' : url,
    'poster' : poster,
  };

  static Movies fromJson(Map<String, dynamic> json) => Movies(
    name: json['name'],
    url: json['url'],
    poster: json['poster'],
  );
}

class Series{
  final seasons;
  final String poster;
  final String name;

  Series({
    required this.seasons,
    required this.poster,
    required this.name,
  });

  static getSeries(String name) async {
  return await FirebaseFirestore.instance
      .collection("series")
      .where("name", isLessThanOrEqualTo: name.toString())
      .get();
}

  Map<String, dynamic> toJson() => {

    'seasons' : seasons,
    'poster' : poster,
    'name' : name,
  };

  static Series fromJson(Map<String, dynamic> json) => Series(
    seasons: json['seasons'],
    poster: json['poster'],
    name: json['name'],
  );
}
