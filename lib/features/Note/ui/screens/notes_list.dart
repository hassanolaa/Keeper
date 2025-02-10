import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/Bookmark/ui/widgets/category.dart';
import 'package:bookmarker/features/Note/cubit/note_cubit.dart';
import 'package:bookmarker/features/Note/ui/screens/note_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';


class NoteList extends StatefulWidget {
   NoteList({super.key,required this.category_name});
  String category_name;

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {



  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NoteCubit()..getNotes(widget.category_name),
        child: BlocConsumer<NoteCubit, NoteState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = BlocProvider.of<NoteCubit>(context);

              return Scaffold(
                body: MobView(
                  widget: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/background.png'),
                            fit: BoxFit.cover)),
                    child:
                    state is GetNotesLoading
                        ? Center(
                      child: CircularProgressIndicator())
                        : state is GetNotesError
                        ? Center(
                      child: Text(state.message),
                        ):
                      cubit.Notes.isEmpty
                          ? Center(
                        child: Text('No Notes in this category'),
                      )
                          :  
                     ListView.builder(
                        itemCount: cubit.Notes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              style: ListTileStyle.list,
                              tileColor: Colors.white,
                              title: Text(cubit.Notes[index]['title']),
                              leading: Icon(Icons.delete),
                              trailing: IconButton(onPressed: (){
                                context.navigateTo(noteDetails(title: cubit.Notes[index]['title'],content: cubit.Notes[index]['content']));
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
