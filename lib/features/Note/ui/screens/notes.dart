



import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/shared/addCategory.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/Bookmark/ui/widgets/category.dart';
import 'package:bookmarker/features/Note/ui/screens/notes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/note_cubit.dart';




class notes extends StatefulWidget {
  notes({Key? key}) : super(key: key);

  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => NoteCubit()..fetchUserNotes_categories(),
      child: BlocConsumer<NoteCubit, NoteState>(listener: (context, state) {
        
      }, builder: (context, state) {
        final cubit = BlocProvider.of<NoteCubit>(context);
    return  Scaffold(
      // AppBar
       appBar: AppBar(
        backgroundColor:Color(0xFFC9EDEB),
        elevation: 0,
        title:  Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colors.coco,
                        ),
                      ),
      ),
     body: SafeArea(
       child: Container(
        decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage('images/background.png'),fit: BoxFit.cover)
            ),
         child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 //SizedBox(height: 14),
           
              // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search Note',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Icon(Icons.tune, color: Colors.grey),
                        ],
                      ),
                    ),
            
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                                        onPressed: () {
                                showColorPickerDialog(context,notecubit: cubit );
                                 
                                        },
                                        icon: Icon(
                                          Icons.add_box_outlined,
                                          size: context.fontSize(30),
                                        )
                    )
                        ],
                      ),
                    ),
                     SizedBox(height: 16),
                  if (cubit.categories.length==0)... {
                               Center(
                                child: Text("No Categories"),
                              )
                            }
                  else
                    Container(
                      height: 1500,
                      child: GridView.builder(
                          itemCount: cubit.categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    //   Navigator.pushNamed(context, MyRouter.category);
                                  },
                                  child: GestureDetector(
                                      onTap: () {
                                        context.navigateTo(NoteList(category_name: cubit.categories[index]["category_name"].toString(),));
                                      },
                                      child: category(
                                        CategoryColor: cubit.categories[index]["category_color"].toString(),
                                        categoryName: cubit.categories[index]["category_name"].toString(),
                                        categoryCount: cubit.categories[index]["notes_count"].toString(),
                                      ))),
                            );
                          }),
                    )              
           
                 
                 
                 ],
                ),
              ),
            
            ],
          ),
       ),
     ),
    );
      }),
    );
  }
}

