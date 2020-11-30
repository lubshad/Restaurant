import 'package:flutter/material.dart';

import 'components/category_item_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: GestureDetector(onTap: () {}, child: Icon(Icons.search)),
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search ",
                ),
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Top Categories",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                childCount: 1),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => CategoryItemCard(),
                childCount: 10,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1),
            ),
          ),
        ],
      ),
    );
  }
}
