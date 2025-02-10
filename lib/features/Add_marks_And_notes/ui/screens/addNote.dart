import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/shared/addCategory.dart';
import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/features/home/ui/screens/profile.dart';
import 'package:bookmarker/features/splash&navi/ui/navi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/core/theming/colors.dart';

import '../../cubit/cubit/add_bookmark_note_cubit.dart';

class addnote extends StatefulWidget {
  const addnote({super.key});

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  HtmlEditorController controller = HtmlEditorController();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  String selectedCategory = '';

  // @override
  // void initState() {
  //   super.initState();

  //   // Use a delay to ensure the WebView is initialized
  //   Future.delayed(Duration(milliseconds: 500), () async {
  //     controller.insertHtml(
  //       '''<p>fgfdbdfb</p><h1><b><font face="Courier New">fdfdsfsdfsdf</font></b></h1>''',
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddBookmarkNoteCubit()..fetchNoteCategories(),
        child: BlocConsumer<AddBookmarkNoteCubit, AddBookmarkNoteState>(
            listener: (context, state) {
          if (state is NoteCreated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Note created successfully'),
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
          } else if (state is AddCategoryLoaded) {
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
                    children: [
                      context.height_box(0.02),
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
                                    'Add Note',
                                    style: TextStyle(
                                      fontSize: context.fontSize(20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  context.height_box(0.015),
                                  // title
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a note title';
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
                                                    color: colors.coco,
                                                    width: 1.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: colors.coco,
                                                    width: 1.0),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            items: [
                                              DropdownMenuItem(
                                                child: Text(
                                                  'Select a category',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                value: null,
                                              ),
                                              for (var category
                                                  in cubit.categories)
                                                DropdownMenuItem(
                                                  child: Text(
                                                      category['category_name']
                                                          .toString()),
                                                  value:
                                                      category['category_name'],
                                                ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedCategory =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: IconButton(
                                                onPressed: () {
                                                  showColorPickerDialog(context,
                                                      addnotecategory: cubit);
                                                },
                                                icon: Icon(
                                                  Icons.add_box_outlined,
                                                  size: context.fontSize(30),
                                                )))
                                      ],
                                    ),
                                  ),
                                  // description
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: colors.coco),
                                    ),
                                    child: HtmlEditor(
                                      htmlToolbarOptions: HtmlToolbarOptions(
                                        toolbarPosition: ToolbarPosition
                                            .aboveEditor, //by default
                                        toolbarType: ToolbarType.nativeGrid,
                                      ),
                                      controller: controller, //required
                                      htmlEditorOptions: HtmlEditorOptions(
                                        hint: "Your text here...",
                                      ),
                                      otherOptions: OtherOptions(
                                        height: 400,
                                      ),
                                    ),
                                  ),

                                  // Add button
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.createNote(
                                              selectedCategory,
                                              _titleController.text,
                                              await controller.getText());
                                        }
                                      },
                                      child: Text('Add',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            Size(double.infinity, 50.0),
                                        backgroundColor:
                                            colors.coco.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
