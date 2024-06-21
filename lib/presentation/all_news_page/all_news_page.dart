import 'package:NewsApp/presentation/all_news_page/widget/featured_news_list.dart';
import 'package:NewsApp/presentation/all_news_page/widget/latest_news_item.dart';
import 'package:NewsApp/presentation/all_news_page/widget/latest_news_list.dart';
import 'package:NewsApp/presentation/current_news_page/current_news_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                icon: const Icon(Icons.menu),
                onPressed: () {},
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
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),
                        surfaceTintColor: Colors.grey,
                        backgroundColor: MyConstants.backgroundColor,
                        pinned: true,
                        floating: true,
                        collapsedHeight: 120,
                        snap: false,
                        expandedHeight: 320,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          titlePadding: const EdgeInsets.only(left: 30),
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Text(
                                  "Featured",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: MyConstants.fontFamily,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                LatestNewsItemWidget(
                                  title: state.featuredNews[1].title,
                                  imageSrc: state.featuredNews[1].imageUrl,
                                  loadTime:
                                      state.featuredNews[1].publicationDate,
                                ),
                              ],
                            ),
                          ),
                          background: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                              Padding(
                                padding: EdgeInsets.only(left: 17.w),
                                child: ContainerWithShades(
                                  child: FeaturedList(
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
                                                MarkFeaturedArticle(
                                                    id: article.id),
                                              );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SliverPersistentHeader(
                      //   pinned: true,
                      //   delegate: _SliverAppBarDelegate(
                      //     minHeight: 20.h,
                      //     maxHeight: 20.h,
                      //     child: Container(
                      //       color: MyConstants.backgroundColor,
                      //     ),
                      //   ),
                      // ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 16.0),
                          child: Text(
                            "Latest news",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.sp,
                              fontFamily: MyConstants.fontFamily,
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return LatestNewsList(
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
                            );
                          },
                          childCount: state.latestNews.length,
                        ),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
