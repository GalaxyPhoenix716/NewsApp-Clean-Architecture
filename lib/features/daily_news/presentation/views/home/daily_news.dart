import 'package:clean_arch/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text('Daily News'));
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(title: Text('$index'),);
            },
            itemCount: state.articles!.length,
          );
        }

        return const SizedBox();
      },
    );
  }
}
