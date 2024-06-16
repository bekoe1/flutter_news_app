
import 'models/article.dart';


abstract class AbstractNewsRepository {
  Future<List<Article>> getLatestArticles();
  Future<List<Article>> getFeaturedArticles();
  Future<Article> getArticle(String id);
}
