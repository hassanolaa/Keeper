import 'package:bookmarker/features/Bookmark/cubit/bookmark_cubit.dart';
import 'package:bookmarker/features/home/cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import '../../features/Add_marks_And_notes/cubit/cubit/add_bookmark_note_cubit.dart';
import '../../features/Note/cubit/note_cubit.dart';

void showColorPickerDialog(BuildContext context,
    {UserCubit? usercubitNotes,UserCubit? usercubit,BookmarkCubit? bookmarkcubit, NoteCubit? notecubit , AddBookmarkNoteCubit? addbookmarkcategory, AddBookmarkNoteCubit? addnotecategory}) {
  final TextEditingController textController = TextEditingController();
  final List<String> colors = [
    "0xFFFF0000", // Red
    "0xFF00FF00", // Green
    "0xFF0000FF", // Blue
    "0xFFFFFF00", // Yellow
    "0xFFFFA500", // Orange
    "0xFF800080", // Purple
    "0xFFFFC0CB", // Pink
    "0xFF008080", // Teal
    "0xFF000000", // Black
    "0xFF00FFFF", // Cyan
  ];
  String? selectedColor; // Track the selected color

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('new category'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text Field
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Category name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // List of Colors
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: colors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        // Update the selected color
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(int.parse(color)),
                        radius: 20,
                        child: selectedColor == color
                            ? Icon(Icons.check,
                                color: Colors.white) // Show checkmark
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Handle Cancel
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Handle Submit
                  String enteredText = textController.text;
                  if (selectedColor != null && enteredText.length > 0) {
                    
                    // if bookmarkcubit is not null, add category to bookmark 
                    bookmarkcubit != null
                        ? bookmarkcubit.addCategory(enteredText, selectedColor!)
                        : null;
                    
                    // if notecubit is not null, add category to note
                    notecubit != null
                        ? notecubit.addCategory(enteredText, selectedColor!)
                        : null;

                    // if addbookmarknote is not null, add category to bookmark and note
                     addbookmarkcategory != null
                         ? addbookmarkcategory.addBookmarkCategory(enteredText, selectedColor!)
                         : null;    

                    // if addbookmarknote is not null, add category to bookmark and note
                      addnotecategory != null
                          ? addnotecategory.addNoteCategory(enteredText, selectedColor!)
                          : null;

                    // if usercubit is not null, add category to bookmark and note
                      usercubit != null
                          ? usercubit.addBookmarkCategory(enteredText, selectedColor!)
                          : null;

                    // if usercubitNotes is not null, add category to bookmark and note
                     usercubitNotes != null
                        ? usercubitNotes.addNoteCategory(enteredText, selectedColor!)
                        : null;      

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Category Added'),
                    ));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          'Please enter a category name and select a color'),
                    ));
                  }
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}
