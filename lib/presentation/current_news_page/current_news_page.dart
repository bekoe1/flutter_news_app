import 'package:era_developers_test_flutter/utils/constants.dart';
import 'package:era_developers_test_flutter/utils/container_with_shades.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  clipBehavior: Clip.none,
                  forceElevated: true,
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                      color:
                          state is ArticleLoaded ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  expandedHeight: state is ArticleLoaded ? 495 : null,
                  floating: true,
                  pinned: true,
                  flexibleSpace: state is ArticleLoaded
                      ? LayoutBuilder(
                          builder: (context, constraints) => FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            titlePadding: constraints.maxHeight > 100
                                ? const EdgeInsets.fromLTRB(48, 20, 96, 40)
                                : const EdgeInsets.fromLTRB(48, 0, 48, 10),
                            title: Text(
                              state.article.title,
                              maxLines: constraints.maxHeight > 100 ? 2 : 1,
                              style: TextStyle(
                                fontFamily: MyConstants.fontFamily,
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            background: DecoratedBox(
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
                              child: Image.network(
                                state.article.imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
                state is ArticleLoaded
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 21,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                state.article.description ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: MyConstants.fontFamily,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ContainerWithShades(
                                width: 372,
                                height: 190,
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
