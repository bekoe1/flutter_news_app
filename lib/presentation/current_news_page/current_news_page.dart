import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/current_news_bloc.dart';

class CurrentNewsPage extends StatelessWidget {
  const CurrentNewsPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentNewsBloc>(
      create: (context) => CurrentNewsBloc()..add(ArticleFetchEvent(id: id)),
      child: BlocBuilder<CurrentNewsBloc, CurrentNewsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyConstants.backgroundColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12.r),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  forceElevated: true,
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    icon: Icon(
                      MyConstants.leading.icon,
                      size: MyConstants.leading.size,
                      color:
                          state is ArticleLoaded ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  expandedHeight: state is ArticleLoaded ? 495.h : null,
                  floating: true,
                  pinned: true,
                  shadowColor: Colors.grey,
                  flexibleSpace: state is ArticleLoaded
                      ? LayoutBuilder(
                          builder: (context, constraints) => FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            titlePadding: constraints.maxHeight > 100.h
                                ? EdgeInsets.fromLTRB(48.w, 20.h, 96.w, 40.h)
                                : EdgeInsets.fromLTRB(48.h, 0, 48.w, 10.h),
                            title: Text(
                              state.article.title,
                              maxLines: constraints.maxHeight > 100.h ? 2 : 1,
                              style: TextStyle(
                                fontFamily: MyConstants.fontFamily,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            background: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 20,
                                    offset: const Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12.r),
                                ),
                                child: Image.network(
                                  state.article.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
                state is ArticleLoaded
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 21.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                state.article.description ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: MyConstants.fontFamily,
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 50.h),
                              ContainerWithShades(
                                width: 372,
                                height: 150,
                                child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuw4kqeW6XFwFz2iacuC4QGjkDprQh4QPdJg&s"),
                              ),
                              SizedBox(height: 50.h),
                              ContainerWithShades(
                                width: 372,
                                height: 150,
                                child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuw4kqeW6XFwFz2iacuC4QGjkDprQh4QPdJg&s"),
                              ),
                              SizedBox(height: 50.h),
                              ContainerWithShades(
                                width: 372,
                                height: 150,
                                child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuw4kqeW6XFwFz2iacuC4QGjkDprQh4QPdJg&s"),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
