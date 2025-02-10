import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/shared/addCategory.dart';
import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/core/theming/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../splash&navi/ui/navi.dart';
import '../../cubit/cubit/add_bookmark_note_cubit.dart';

class addBookmark extends StatefulWidget {
  const addBookmark({super.key});

  @override
  State<addBookmark> createState() => _addBookmarkState();
}

class _addBookmarkState extends State<addBookmark> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  String? selectedCategory;

@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBookmarkNoteCubit()..fetchBookmarkCategories(),
      child: BlocConsumer<AddBookmarkNoteCubit, AddBookmarkNoteState>(listener: (context, state) {
        if (state is BookmarkCreated) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Bookmark created successfully'),
            backgroundColor: colors.coco,
          ));
            context.navigateTo(navi());
        
        } else if (state is AddBookmarkNoteError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: colors.liveText,
          ));
        } else if (state is AddBookmarkNoteError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: colors.liveText,
          ));
        }else if (state is AddCategoryLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Category added successfully'),
            backgroundColor: colors.coco,
          ));
        } else if (state is AddCategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: colors.liveText,
          ));
        }
        
      }, builder: (context, state) {
        final cubit = BlocProvider.of<AddBookmarkNoteCubit>(context);
    
    return Scaffold(
      body: MobView(
        widget: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                context.height_box(0.1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            context.height_box(0.03),
                            Text(
                              'Add Bookmark',
                              style: TextStyle(
                                fontSize: context.fontSize(30),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            context.height_box(0.03),
                            // title
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: TextFormField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  labelStyle: TextStyle(
                                    color: colors.coco,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.coco, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.coco, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Bookmark title';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // url
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: TextFormField(
                                controller: _urlController,
                                decoration: InputDecoration(
                                  hintText: 'Link',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  labelStyle: TextStyle(
                                    color: colors.coco,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.coco, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.coco, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a URL';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // select category
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 300.0,
                                    child: DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select a category';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Category',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        labelStyle: TextStyle(
                                          color: colors.coco,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: colors.coco, width: 1.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: colors.coco, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Select a category',style: TextStyle(color: Colors.grey),),
                                          value: null,
                                        ),
                                        for (var category in cubit.categories)
                                          DropdownMenuItem(
                                            child: Text(category['category_name'].toString()),
                                            value: category['category_name'],
                                          )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: IconButton(
                                          onPressed: () {
                                           showColorPickerDialog(context, addbookmarkcategory: cubit);
                                          },
                                          icon: Icon(
                                            Icons.add_box_outlined,
                                            size: context.fontSize(30),
                                          )))
                                ],
                              ),
                            ),
                            // description
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: TextFormField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  hintText: 'Description (optional)',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  labelStyle: TextStyle(
                                    color: colors.coco,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.coco, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.coco, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            // Add button
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                   
                                    cubit.createBookmark(
                                        selectedCategory!,
                                        _titleController.text,
                                        _urlController.text,
                                        _descriptionController.text);
                                  }
                                },
                                child: Text('Add',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 50.0),
                                  backgroundColor: colors.coco.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    }));
  }
}
