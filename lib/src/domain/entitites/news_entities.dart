import 'package:equatable/equatable.dart';
import 'package:news_app/src/data/models/news_model.dart';

class NewsEntities extends Equatable {
  final String status;
  final int total;
  final List<NewsArticleEntities> articles;
  const NewsEntities({
    required this.status,
    required this.total,
    required this.articles,
  });

  NewsModel toModel() => NewsModel(
        status: status,
        total: total,
        articles: articles.map((e) => e.toModel()).toList(),
      );

  @override
  List<Object> get props => [status, total, articles];
}

class NewsArticleEntities extends Equatable {
  final int id;
  final DateTime date;
  // final YoastHeadJson yoastHeadJson;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;
  const NewsArticleEntities({
    required this.id,
    required this.date,
    // required this.yoastHeadJson,
    required this.category,
    required this.title,
    required this.banner,
    // this.source,  this.date,
    required this.author,
    required this.description,
    required this.link,
  });

  NewsArticleModel toModel() => NewsArticleModel(
        id: id,
        date: date,
        // yoastHeadJson: yoastHeadJson.toModel(),
        category: category,
        author: author,
        title: title,
        description: description,
        link: link,
        banner: banner,
      );

  @override
  List<Object> get props {
    return [
      id, date,
      // yoastHeadJson,
      category, author, title, description, link, banner
    ];
  }
}

// class NewsArticleSourceEntities extends Equatable {
//   final String id;
//   final String name;
//   const NewsArticleSourceEntities({
//     required this.id,
//     required this.name,
//   });
//
//   NewsArticleSourceModel toModel() =>
//       NewsArticleSourceModel(id: id, name: name);
//   @override
//   List<Object> get props => [id, name];
// }
