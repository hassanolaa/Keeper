import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/Bookmark/ui/widgets/category.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/bookmark_cubit.dart';

class BookmarksList extends StatefulWidget {
   BookmarksList({super.key,required this.category_name});
  String category_name;

  @override
  State<BookmarksList> createState() => _BookmarksListState();
}

class _BookmarksListState extends State<BookmarksList> {



   void launchURL(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookmarkCubit()..getBookmarks(widget.category_name),
        child: BlocConsumer<BookmarkCubit, BookmarkState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = BlocProvider.of<BookmarkCubit>(context);

              return Scaffold(
                body: MobView(
                  widget: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/background.png'),
                            fit: BoxFit.cover)),
                    child:
                    state is GetBookmarksLoading
                        ? Center(
                      child: CircularProgressIndicator())
                        : state is GetBookmarksError
                        ? Center(
                      child: Text(state.message),
                        ):
                      cubit.bookmarks.isEmpty
                          ? Center(
                        child: Text('No bookmarks in this category'),
                      )
                          :  
                     ListView.builder(
                        itemCount: cubit.bookmarks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              style: ListTileStyle.list,
                              tileColor: Colors.white,
                              title: Text(cubit.bookmarks[index]['title']),
                              subtitle: Text(cubit.bookmarks[index]['description']),
                              leading: Icon(Icons.delete),
                              trailing: IconButton(onPressed: (){
                              launchURL(Uri.parse(cubit.bookmarks[index]['url']));
                              }, icon: Icon(Icons.open_in_new)),
                              
                            ),
                          );
                        }),
                  ),
                ),
              );
            }));
  }
}
