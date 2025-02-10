import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class noteDetails extends StatefulWidget {
  noteDetails({super.key, this.title, this.content});
  String? title;
  String? content;

  @override
  State<noteDetails> createState() => _noteDetailsState();
}

class _noteDetailsState extends State<noteDetails> {
  HtmlEditorController controller = HtmlEditorController();
  var markdown = '';
 
void setText() {
  
  
  
  // Check if widget.content is not null or empty
  if (widget.content != null && widget.content!.isNotEmpty) {
    // Use a delay to ensure the WebView is initialized and the controller is ready
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        // Make sure the controller is initialized and ready before inserting HTML
        try {
          controller.insertHtml(widget.content!);
        } catch (e) {
          print('Error inserting HTML content: $e');
        }
      });
    });
  } else {
    print('Invalid or empty HTML content');
  }
}

  @override
  void initState() {
    super.initState();

   setText();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobView(
          widget: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            context.height_box(0.03),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    
                    child: Column(
                      children: [
                        Text(
                          widget.title!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Html(
                        //   data: widget.content!,
                        // ),
                      kIsWeb==true?  Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: colors.coco),
                          ),
                          child: HtmlEditor(
                            htmlToolbarOptions: HtmlToolbarOptions(
                              toolbarPosition:
                                  ToolbarPosition.aboveEditor, //by default
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
                        ):
                        SelectableText(
                          widget.content!,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
