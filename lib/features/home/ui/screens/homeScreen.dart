import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/splash&navi/ui/navi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/shared/addCategory.dart';
import '../../../Note/ui/screens/note_details.dart';
import '../../cubit/user_cubit.dart';
import '../widgets/carousel.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  HtmlEditorController controller = HtmlEditorController();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  String? selectedCategory;

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
      create: (context) => UserCubit()
        ..getUserBookmarks_categories()
        ..getUserNotes_categories(),
      child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
              if (state is NoteCreated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Note created successfully'),
              backgroundColor: colors.coco,
            ));
            context.navigateTo(navi());
          }else if (state is BookmarkCreated){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Bookmark created successfully'),
              backgroundColor: colors.coco,
            ));
            context.navigateTo(navi());
          } 
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<UserCubit>(context);

            return Scaffold(
              // AppBar
              appBar: AppBar(
                //leading:SizedBox() ,
                backgroundColor: Color(0xFFC9EDEB),
                elevation: 0,
                title: Container(
                  height: 80,
                  child: Image.asset(
                    'images/logo_png.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // centerTitle: true,
                actions: [
                  Row(
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                            color: cubit.Bookmarks
                                ? Color.fromARGB(255, 189, 189, 189)
                                : colors.coco,
                            fontSize: 20),
                      ),
                      Switch(
                        value: cubit.Bookmarks,
                        onChanged: (value) {
                          cubit.switchBookmarks();
                        },
                        activeColor: colors.coco,
                        inactiveThumbColor: colors.coco,
                      ),
                      Text(
                        'Bookmarks',
                        style: TextStyle(
                            color: cubit.Bookmarks
                                ? colors.coco
                                : Color.fromARGB(255, 189, 189, 189),
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Container(
                    width: context.width(0.06),
                  )
                ],
              ),
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          fit: BoxFit.cover)),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // row of two buttons "add" and "view"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //view
                                GestureDetector(
                                  onTap: () {
                                    cubit.setview_true();
                                  },
                                  child: Container(
                                    width: context.width(0.5),
                                    height: context.height(0.1),
                                    decoration: BoxDecoration(
                                        color: cubit.view ? colors.coco : null,
                                        border: Border.all(
                                            color: cubit.view
                                                ? Colors.transparent
                                                : colors.coco,
                                            width: 2)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 30,
                                          color: cubit.view
                                              ? Colors.white
                                              : colors.coco,
                                        ),
                                        Text(
                                          'View',
                                          style: TextStyle(
                                              color: cubit.view
                                                  ? Colors.white
                                                  : colors.coco,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // open
                                GestureDetector(
                                  onTap: () {
                                    cubit.setview_false();
                                  },
                                  child: Container(
                                    width: context.width(0.5),
                                    height: context.height(0.1),
                                    decoration: BoxDecoration(
                                        color: cubit.view ? null : colors.coco,
                                        border: Border.all(
                                            color: cubit.view
                                                ? colors.coco
                                                : Colors.transparent,
                                            width: 2)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline,
                                          size: 30,
                                          color: cubit.view
                                              ? colors.coco
                                              : Colors.white,
                                        ),
                                        Text(
                                          'Add',
                                          style: TextStyle(
                                              color: cubit.view
                                                  ? colors.coco
                                                  : Colors.white,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            cubit.Bookmarks == true
                                ? cubit.view
                                    ?
                                    // view bookmarks
                                    viewBookmarks(cubit)
                                    :
                                    // add bookmarks
                                    addBookmark(context, cubit)
                                : cubit.view
                                    ?
                                    // view notes
                                    viewNotes(cubit)
                                   : // add note
                                   addNote(context, cubit),
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

  Padding addNote(BuildContext context, UserCubit cubit) {
    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                context.height_box(0.03),
                                                Text(
                                                  'Add Note',
                                                  style: TextStyle(
                                                    fontSize:
                                                        context.fontSize(20),
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                                context.height_box(0.015),
                                                // title
                                                Padding(
                                                  padding:
                                                      EdgeInsets.all(10.0),
                                                  child: TextFormField(
                                                    controller:
                                                        _titleController,
                                                    decoration:
                                                        InputDecoration(
                                                      hintText: 'Title',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      labelStyle: TextStyle(
                                                        color: colors.coco,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(
                                                                color: colors
                                                                    .coco,
                                                                width: 1.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(
                                                                color: colors
                                                                    .coco,
                                                                width: 1.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0),
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
                                                  padding:
                                                      EdgeInsets.all(20.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 300.0,
                                                        child:
                                                            DropdownButtonFormField(
                                                          validator: (value) {
                                                            if (value ==
                                                                null) {
                                                              return 'Please select a category';
                                                            }
                                                            return null;
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Category',
                                                            hintStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            labelStyle:
                                                                TextStyle(
                                                              color:
                                                                  colors.coco,
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: colors
                                                                      .coco,
                                                                  width: 1.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: colors
                                                                      .coco,
                                                                  width: 1.0),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          items: [
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                'Select a category',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              value: null,
                                                            ),
                                                            for (var category
                                                                in cubit
                                                                    .notes_categories)
                                                              DropdownMenuItem(
                                                                child: Text(category[
                                                                        'category_name']
                                                                    .toString()),
                                                                value: category[
                                                                    'category_name'],
                                                              ),
                                                          ],
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedCategory =
                                                                  value
                                                                      .toString();
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: IconButton(
                                                              onPressed: () {
                                                                showColorPickerDialog(
                                                                    context,
                                                                    usercubitNotes:
                                                                        cubit);
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .add_box_outlined,
                                                                size: context
                                                                    .fontSize(
                                                                        30),
                                                              )))
                                                    ],
                                                  ),
                                                ),
                                                // description
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                        color: colors.coco),
                                                  ),
                                                  child: HtmlEditor(
                                                    htmlToolbarOptions:
                                                        HtmlToolbarOptions(
                                                      toolbarPosition:
                                                          ToolbarPosition
                                                              .aboveEditor, //by default
                                                      toolbarType: ToolbarType
                                                          .nativeGrid,
                                                    ),
                                                    controller:
                                                        controller, //required
                                                    htmlEditorOptions:
                                                        HtmlEditorOptions(
                                                      hint:
                                                          "Your text here...",
                                                    ),
                                                    otherOptions:
                                                        OtherOptions(
                                                      height: 400,
                                                    ),
                                                  ),
                                                ),

                                                // Add button
                                                Padding(
                                                  padding:
                                                      EdgeInsets.all(20.0),
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_formKey
                                                          .currentState!
                                                          .validate()) {
                                                        cubit.createNote(
                                                            selectedCategory!,
                                                            _titleController
                                                                .text,
                                                            await controller
                                                                .getText());

                                                  _titleController.clear();
                                                  controller.clear();
                                                  _descriptionController.clear();
                                                        
                                                      }
                                                    },
                                                    child: Text('Add',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        )),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize: Size(
                                                          double.infinity,
                                                          50.0),
                                                      backgroundColor: colors
                                                          .coco
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
  }

  Column addBookmark(BuildContext context, UserCubit cubit) {
    return Column(
      children: [
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
                            borderSide:
                                BorderSide(color: colors.coco, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colors.coco, width: 1.0),
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
                            borderSide:
                                BorderSide(color: colors.coco, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colors.coco, width: 1.0),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    'Select a category',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  value: null,
                                ),
                                for (var category in cubit.Bookmarks_categories)
                                  DropdownMenuItem(
                                    child: Text(
                                        category['category_name'].toString()),
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
                                    showColorPickerDialog(context,
                                        usercubit: cubit);
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
                            borderSide:
                                BorderSide(color: colors.coco, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colors.coco, width: 1.0),
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

                            _titleController.clear();
                            _descriptionController.clear();
                            _urlController.clear();
                            
                                
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
    );
  }

  Column viewBookmarks(UserCubit cubit) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    hintText: cubit.Bookmarks_categories.isEmpty
                        ? "Select category"
                        : cubit.Bookmarks_categories[0]['category_name']
                            .toString(),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(
                      color: colors.coco,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colors.coco, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colors.coco, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: [
                    // DropdownMenuItem(
                    //   child: Text('Select a category',style: TextStyle(color: Colors.grey),),
                    //   value: null,
                    // ),
                    for (var category in cubit.Bookmarks_categories)
                      DropdownMenuItem(
                        child: Text(category['category_name'].toString()),
                        value: category['category_name'],
                      )
                  ],
                  onChanged: (value) {
                    setState(() {
                      cubit.getBookmarks(value.toString());
                    });
                  },
                ),
              ),
              // Expanded(
              //     child: IconButton(
              //         onPressed: () {
              //        //  showColorPickerDialog(context, addbookmarkcategory: cubit);
              //         },
              //         icon: Icon(
              //           Icons.add_box_outlined,
              //           size: context.fontSize(30),
              //         )))
            ],
          ),
        ),
        // bookmarks
        cubit.Bookmarks_list == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : cubit.Bookmarks_list.isEmpty
                ? Center(
                    child: Text('No bookmarks found'),
                  )
                : ListView.separated(
                    itemCount: cubit.Bookmarks_list!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cubit.Bookmarks_list[index]['title']),
                        subtitle:
                            Text(cubit.Bookmarks_list[index]['description']),
                        onTap: () {
                          launchURL(
                              Uri.parse(cubit.Bookmarks_list[index]['url']));
                        },
                        trailing: IconButton(
                            onPressed: () {
                              launchURL(Uri.parse(
                                  cubit.Bookmarks_list[index]['url']));
                            },
                            icon: Icon(Icons.open_in_new)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
      ],
    );
  }

  Column viewNotes(UserCubit cubit) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    hintText: cubit.notes_categories.isEmpty
                        ? "Select category"
                        : cubit.notes_categories[0]['category_name'].toString(),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(
                      color: colors.coco,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colors.coco, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colors.coco, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: [
                    // DropdownMenuItem(
                    //   child: Text('Select a category',style: TextStyle(color: Colors.grey),),
                    //   value: null,
                    // ),
                    for (var category in cubit.notes_categories)
                      DropdownMenuItem(
                        child: Text(category['category_name'].toString()),
                        value: category['category_name'],
                      )
                  ],
                  onChanged: (value) {
                    setState(() {
                      cubit.getNotes(value.toString());
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        // notes
        cubit.Notes_list == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : cubit.Notes_list.isEmpty
                ? Center(
                    child: Text('No notes found'),
                  )
                : ListView.separated(
                    itemCount: cubit.Notes_list!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cubit.Notes_list[index]['title']),
                        onTap: () {
                          context.navigateTo(noteDetails(
                              title: cubit.Notes_list[index]['title'],
                              content: cubit.Notes_list[index]['content']));
                        },
                        trailing: IconButton(
                            onPressed: () {
                              context.navigateTo(noteDetails(
                                  title: cubit.Notes_list[index]['title'],
                                  content: cubit.Notes_list[index]['content']));
                            },
                            icon: Icon(Icons.open_in_new)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
      ],
    );
  }
}
