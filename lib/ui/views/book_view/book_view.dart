import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/models/book_model.dart';
import 'package:weather_project_mvvm/core/view_models/book_view_model.dart';
import 'package:weather_project_mvvm/ui/views/book_view/premium_book.dart';

import '../base_view.dart';
import 'free_book.dart';

class BookView extends StatefulWidget {
  const BookView({Key? key}) : super(key: key);

  @override
  State<BookView> createState() => _BookViewState();
}

enum Status { allBook, free, premium }

class _BookViewState extends State<BookView> {
  Status bookStatus = Status.allBook;
  bool isDetailsBookFunctionCalled = false;
  final coreUrl =
      'https://api.hidayahbooks.hidayahsmart.solutions/static/book_cover/';
  final bool _isHovered = false;
  List<Premium?> premiumBook = [];
  List<Free?> freeBook = [];

  @override
  Widget build(BuildContext context) {
    return BaseView<BookViewModel>(
      onModelReady: (model) => model.bookApiViewModel(),
      builder: (context, model, child) {
        premiumBook = (model.book.isNotEmpty && model.book[0].output != null)
            ? model.book[0].output!
                .where((output) => output.premium != null)
                .map((output) => output.premium)
                .toList()
            : [];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black12,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'BookStore',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // Expanded(
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       hintText: 'Search...',
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                // ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    TextFormField(
                        decoration: const InputDecoration(
                      hintText: 'Search...',
                    ));
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    model.state == ViewState.idle
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          bookStatus == Status.allBook
                                              ? Colors.black
                                              : Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      elevation: _isHovered
                                          ? 8.0
                                          : 4.0, // Adjust elevation as desired
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        bookStatus = Status.allBook;
                                      });
                                    },
                                    child: const Text("All books"),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: bookStatus == Status.free
                                          ? Colors.black
                                          : Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      elevation: _isHovered
                                          ? 8.0
                                          : 4.0, // Adjust elevation as desired
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        bookStatus = Status.free;
                                      });
                                    },
                                    child: const Text("Free books"),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          bookStatus == Status.premium
                                              ? Colors.black
                                              : Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      elevation: _isHovered
                                          ? 8.0
                                          : 4.0, // Adjust elevation as desired
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        bookStatus = Status.premium;
                                      });
                                    },
                                    child: const Text("Premium books"),
                                  ),
                                ],
                              ),

                              /// -------------------allBook
                              if (bookStatus == Status.allBook)
                                const Column(
                                  children: [
                                    ///----free book
                                    BookExtension(),

                                    ///---- premium
                                    PremiumBook()
                                  ],
                                ),

                              ///-------------------    ----free book
                              if (bookStatus == Status.free)
                                const BookExtension(),
                              //  ShowText = 'AllBook';
                              // if( ShowText =AllBook){}
                              ///--------premium book
                              if (bookStatus == Status.premium)
                                const PremiumBook()
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),

          ///----------BotomNavigation
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black12,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.facebook),
                label: 'facebook',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.share),
                label: 'Twitter',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: 'Instagram',
              ),
            ],
          ),
          bottomSheet: const Positioned(
            child: Text(
              '© 2023 Your Company. All rights reserved.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}