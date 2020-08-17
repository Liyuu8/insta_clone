import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// view models
import 'package:insta_clone/view_models/search_view_model.dart';

// components
import 'package:insta_clone/view/common/components/user_card.dart';

class SearchUserDelegate extends SearchDelegate<User> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      brightness: Brightness.dark,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResults(context);
  }

  Widget _buildResults(BuildContext context) {
    final searchViewModel =
        Provider.of<SearchViewModel>(context, listen: false);
    searchViewModel.searchUsers(query);

    return ListView.builder(
      itemCount: searchViewModel.soughtUsers.length,
      itemBuilder: (context, int index) {
        final user = searchViewModel.soughtUsers[index];
        return UserCard(
          photoUrl: user.photoUrl,
          title: user.inAppUserName,
          subTitle: user.bio,
          onTap: () => close(context, user),
        );
      },
    );
  }
}
