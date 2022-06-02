
import 'package:flutter/material.dart';
import 'package:flutter_notes/helper/note_provider.dart';
import 'package:flutter_notes/screens/note_edit_screen.dart';
import 'package:flutter_notes/utils/constants.dart';
import 'package:flutter_notes/widgets/list_item.dart';
import 'package:provider/provider.dart';


class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Consumer<NoteProvider>(
                child: noNotesUI(context),
                builder: (context, noteprovider, child) =>
                    noteprovider.items.length <= 0
                        ? child
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: noteprovider.items.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return header();
                              } else {
                                final i = index - 1;
                                final item = noteprovider.items[i];

                                return ListItem(
                                  item.id,
                                  item.title,
                                  item.content,
                                  item.imagePath,
                                  item.date,
                                );
                              }
                            },
                          ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  goToNoteEditScreen(context);
                },
                child: Icon(Icons.add),
              ),
            );
          }
        }
        return Container();
      },
    );
  }

  Widget header() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: headerColor,
        ),
        height: 100.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Riko Airlan Ramadhan',
              style: headerRideStyle,
            ),
            Text(
              'Notes App',
              style: headerNotesStyle,
            )
          ],
        ),
      ),
    );
  }



  Widget noNotesUI(BuildContext context) {
    return ListView(
      children: [
        header(),
        Column(
          children: [

          ],
        ),
      ],
    );
  }

  void goToNoteEditScreen(BuildContext context) {
    Navigator.of(context).pushNamed(NoteEditScreen.route);
  }
}
