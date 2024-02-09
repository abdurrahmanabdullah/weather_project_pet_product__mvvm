import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_project_mvvm/core/models/book_model.dart';
import 'package:weather_project_mvvm/core/view_models/book_view_model.dart';
import 'package:weather_project_mvvm/ui/views/base_view.dart';

class PremiumBook extends StatefulWidget {
  const PremiumBook({Key? key}) : super(key: key);

  @override
  State<PremiumBook> createState() => _PremiumBookState();
}

class _PremiumBookState extends State<PremiumBook> {
  final coreUrl =
      'https://api.hidayahbooks.hidayahsmart.solutions/static/book_cover/';

  List<Premium?> premiumBook = [];
  List<String> premiumBookCategoriesList = [];
  bool isDetailsBookFunctionCalled = false;
  bool IsDisplayGenre = false;
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

        premiumBookCategoriesList = (model.book.isNotEmpty &&
                model.book[0].output != null)
            ? model.book[0].output!
                .where((element) =>
                    element.premium != null &&
                    element.premium!.bookCategories != null)
                .map((e) => e.premium!.bookCategories!)
                .toSet()

                ///---///A Set is a collection of unique elements, and converting the list to a Set automatically removes any duplicate entries.
                .toList()
            : [];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: GridView.builder(
                itemCount: premiumBook.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  String imageUrl =
                      '$coreUrl${premiumBook[index]?.imageNameF ?? 'No image'}';
                  String name = premiumBook[index]?.name ?? 'unknown';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        premiumDetailsBook(index);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Image.network(
                              imageUrl,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image loaded
                                }
                                return const CircularProgressIndicator();
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('Error loading image');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              name,
                              softWrap: true,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                              'Price : ${premiumBook[index]?.price ?? 'unknown'}')
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            ///=====check if detailsbookFunction is called and isdisplayGenre is not true
            if (isDetailsBookFunctionCalled && IsDisplayGenre != true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      if (displayImage.isNotEmpty)
                        Image.network(
                          displayImage,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Error loading image');
                          },
                        ),
                      Text(
                        'Price ${displayPrice.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          const playStoreUrl =
                              'https://play.google.com/store/apps/details?id=com.example.weather_project_mvvm';
                          try {
                            await launch(playStoreUrl);
                          } catch (error) {
                            print('Error launching URL: $error');
                          }
                        },
                        child: const Text('Read More'),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Author: $displayAuthor'),
                      Text('Category: $category'),
                      const Text(
                        'Genre :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              for (int i = 0;
                                  i < premiumBookCategoriesList.length;
                                  i++)
                                InkWell(
                                  borderRadius: BorderRadius.circular(25),
                                  splashColor: Colors.blue,
                                  onTap: () {
                                    displayGenre(i);
                                    // print(premiumBookCategoriesList[i]);
                                  },
                                  child: Text(
                                    '${premiumBookCategoriesList[i]}    ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            else if (IsDisplayGenre == true)
              Column(
                children: [
                  Center(
                      child: Text(
                    '$genreBookType সম্পর্কিত আরো বই',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    genreImage,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Error loading image');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Price $genrePrice',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                  //
                ],
              )
          ],
        );
      },
    );
  }

  ///----------- details book
  String displayName = '';
  String displayImage = '';
  int displayPrice = 0;
  String name = '';
  String displayAuthor = '';
  String category = '';
  void premiumDetailsBook(int index) {
    setState(() {
      displayImage = '$coreUrl${premiumBook[index]?.imageNameF ?? 'No image'}';
      displayPrice = premiumBook[index]?.price ?? 1;
      name = premiumBook[index]?.authorName ?? 'Unknown';
      displayName = premiumBook[index]?.name ?? 'Unknown';
      displayAuthor = premiumBook[index]?.authorName ?? 'Unknown';
      category = premiumBook[index]?.bookCategories ?? 'Unknown';
      isDetailsBookFunctionCalled = true; // Fix the assignment
    });
  }

  ///-----Display Genre

  String genreImage = '';
  int genrePrice = 0;
  String genreBookType = '';
  void displayGenre(int index) {
    setState(() {
      if (premiumBookCategoriesList[index] ==
          premiumBook[index]!.bookCategories) {
        genreImage = '$coreUrl${premiumBook[index]?.imageNameF ?? 'No image'}';
        genrePrice = premiumBook[index]?.price ?? 1;
        genreBookType = premiumBookCategoriesList[index];
        IsDisplayGenre = true;
      }
    });
  }
}