import 'package:NewsApp/data/repo_impl/mock_auth_repo_impl.dart';
import 'package:NewsApp/presentation/all_news_page/widget/featured_news_list.dart';
import 'package:NewsApp/presentation/all_news_page/widget/latest_news_list.dart';
import 'package:NewsApp/presentation/current_news_page/current_news_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/all_news_bloc.dart';

class AllNewsPage extends StatelessWidget {
  const AllNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllNewsBloc>(
      create: (context) => AllNewsBloc()..add(FetchAllNewsEvent()),
      child: BlocBuilder<AllNewsBloc, AllNewsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyConstants.backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                icon: MyConstants.leading,
                onPressed: () {
                  MockAuthRepoImpl().checkUsersDb();
                },
              ),
              actions: state is AllNewsLoaded
                  ? [
                      TextButton(
                        onPressed: () {
                          context.read<AllNewsBloc>().add(MarkAllRead());
                        },
                        child: Text(
                          "Mark all read",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: MyConstants.fontFamily),
                        ),
                      ),
                    ]
                  : null,
              title: Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: MyConstants.fontFamily,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Builder(
              builder: (context) {
                if (state is AllNewsLoaded) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 40),
                    children: [
                      Text(
                        "Featured",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: MyConstants.fontFamily,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FeaturedList(
                        featuredNews: state.featuredNews,
                        onNewsTap: (article) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CurrentNewsPage(id: article.id),
                            ),
                          ).whenComplete(
                            () {
                              context.read<AllNewsBloc>().add(
                                    MarkFeaturedArticle(id: article.id),
                                  );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Latest news",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: MyConstants.fontFamily,
                        ),
                      ),
                      const SizedBox(height: 20),
                      LatestNewsList(
                        latestNews: state.latestNews,
                        onNewsTap: (article) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CurrentNewsPage(id: article.id),
                            ),
                          ).whenComplete(
                            () {
                              context.read<AllNewsBloc>().add(
                                    MarkArticleRead(id: article.id),
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
