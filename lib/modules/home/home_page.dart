import 'package:api/modules/home/home_controller.dart';
import 'package:api/modules/home/home_repository.dart';
import 'package:api/shared/models/post.dart';
import 'package:api/shared/widgets/item_list_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final future = HomeRepository().getPosts();

  @override
  void initState() {
    controller.getPosts();
    controller.listen((status) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Controller",
                  ),
                  Tab(
                    text: "FutureBuilder",
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              controller.status == HomeStatus.success
                  ? ListView.builder(
                      itemCount: controller.posts.length,
                      itemBuilder: (_, index) => ItemListTileWidget(
                        title: controller.posts[index].title ?? "",
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              FutureBuilder<List<Post>>(
                  future: future,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final posts = snapshot.data!;
                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (_, index) => ItemListTileWidget(
                          title: posts[index].title ?? "",
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ])));
  }
}
