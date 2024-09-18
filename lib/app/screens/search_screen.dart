import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {}); // Update the UI when the text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.navbar_search_text)),
      ),
      body: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: tr(LocaleKeys.search_search_text),
                suffixIcon: _searchController.value.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: Icon(Icons.highlight_remove),
                      )
                    : null,
                prefixIcon: IconButton(
                  onPressed: () {
                    // Handle search icon press
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
