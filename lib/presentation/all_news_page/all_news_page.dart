import 'package:NewsApp/presentation/all_news_page/widget/all_news_drawer.dart';
import 'package:NewsApp/presentation/all_news_page/widget/featured_news_list.dart';
import 'package:NewsApp/presentation/all_news_page/widget/latest_news_list.dart';
import 'package:NewsApp/presentation/current_news_page/current_news_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/all_news_bloc.dart';

class AllNewsPage extends StatelessWidget {
  const AllNewsPage({
    Key? key,
    required this.name,
    required this.email,
    this.imageUrl,
  }) : super(key: key);
  final String name;
  final String email;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllNewsBloc>(
      create: (context) => AllNewsBloc()..add(FetchAllNewsEvent()),
      child: BlocBuilder<AllNewsBloc, AllNewsState>(
        builder: (context, state) {
          return Scaffold(
            drawer: AllNewsDrawer(
              email: email,
              name: name,
              imageUrl: imageUrl,
            ),
            backgroundColor: MyConstants.backgroundColor,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              actions: state is AllNewsLoaded
                  ? [
                      TextButton(
                        onPressed: () {
                          context.read<AllNewsBloc>().add(MarkAllRead());
                        },
                        child: Text(
                          "Mark all read",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: MyConstants.fontFamily),
                        ),
                      ),
                    ]
                  : null,
              title: Padding(
                padding: EdgeInsets.only(left: 70.w),
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 18.sp,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 17.w,
                      vertical: 40.h,
                    ),
                    children: [
                      Text(
                        "Featured",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: MyConstants.fontFamily,
                        ),
                      ),
                      SizedBox(height: 20.h),
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
                      SizedBox(height: 20.h),
                      Text(
                        "Latest news",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          fontFamily: MyConstants.fontFamily,
                        ),
                      ),
                      SizedBox(height: 20.h),
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
