import 'package:html/parser.dart';
import 'package:news_app/src/domain/entitites/news_entities.dart';
import 'dart:convert';


List<NewsModel> userFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));


List<NewsArticleModel> modelUserFromJson(String str) => List<NewsArticleModel>.from(
    json.decode(str).map((x) => NewsArticleModel.fromJson(x)));
String modelUserToJson(List<NewsArticleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

class NewsModel {
  final String status;
  final int total;
  List<NewsArticleModel> articles;
  NewsModel({
    required this.status,
    required this.total,
    required this.articles,
  });

  NewsEntities toEntity() => NewsEntities(
        status: status,
        total: total,
        articles: articles
            .map(
              (e) => e.toEntity(),
            )
            .toList(),
      );

  factory NewsModel.fromJson(Map<dynamic, dynamic> json) => NewsModel(
    status: json["status"],
    total: json["total"],
    articles: List<NewsArticleModel>.from(json["articles"]!.map((x) => NewsArticleModel.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "status": status,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    "total": total,
  };
}

class NewsArticleModel {
  final int id;
  final String author;
  final String title;
  final String description;
  final String link;
  final String banner;
  final DateTime date;
  final String category;
  NewsArticleModel({
    required this.id,
    required this.category,
    required this.author,
    required this.title,
    required this.description,
    required this.banner,
    required this.date,
    required this.link,
  });

  NewsArticleEntities toEntity() => NewsArticleEntities(
    id:id,
        author: author,
        title: title,
        description: description,
    link: link,
    banner: banner,
    date: date,
    category: category,
      );

  factory NewsArticleModel.fromJson(Map<dynamic, dynamic> json) => NewsArticleModel(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    // yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    banner: json['_embedded']['wp:featuredmedia'][0]['media_details']
    ['sizes'] ==
        null
        ? ''
        : json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']
    ['full']['source_url'],
    author: json['yoast_head_json']['author'],
    title: _parseHtmlString(json['title']['rendered']),
    category: json['_embedded']['wp:term'][0]
        .lastWhere((term) => term['taxonomy'] == 'category')['name'],
    description: _parseHtmlString(json['content']['rendered']),
    link: json['link'],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    // "yoast_head_json": yoastHeadJson.toJson(),
    "author": author,
    "title": title,
    "category": category,
    "description": description,
    "link": link,
    "banner": banner,
  };
}

// @JsonSerializable(explicitToJson: true)
// class NewsArticleSourceModel {
//   @JsonKey(name: "id", defaultValue: "")
//   final String id;
//   @JsonKey(name: "name", defaultValue: "")
//   final String name;
//
//   NewsArticleSourceModel({
//     required this.id,
//     required this.name,
//   });
//
//   NewsArticleSourceEntities toEntity() =>
//       NewsArticleSourceEntities(id: id, name: name);
//
//   factory NewsArticleSourceModel.fromJson(Map<String, dynamic> json) =>
//       _$NewsArticleSourceModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$NewsArticleSourceModelToJson(this);
// }
