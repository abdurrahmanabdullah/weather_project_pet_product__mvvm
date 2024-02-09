import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_project_mvvm/core/models/book_model.dart';
import 'package:weather_project_mvvm/core/view_models/book_view_model.dart';
import 'package:weather_project_mvvm/ui/views/base_view.dart';

class BookExtension extends StatefulWidget {
  const BookExtension({
    Key? key,
  }) : super(key: key);

  @override
  State<BookExtension> createState() => _BookExtensionState();
}

class _BookExtensionState extends State<BookExtension> {
  final coreUrl =
      'https://api.hidayahbooks.hidayahsmart.solutions/static/book_cover/';
  bool isFreeDetails = false;
  List<Free?> freeBook = [];
  List<String?> freeBookCategoriesList = [];
  bool IsDisplayFreeGenre = false;
  @override
  Widget build(BuildContext context) {
    return BaseView<BookViewModel>(
        onModelReady: (model) => model.bookApiViewModel(),
        builder: (context, model, child) {
          freeBook = (model.book.isNotEmpty && model.book[0].output != null)
              ? model.book[0].output!
                  .where((output) => output?.free != null)
                  .map((output) => output?.free)
                  .toList()
              : [];

          freeBookCategoriesList = (model.book.isNotEmpty &&
                  model.book[0].output != null)
              ? model.book[0].output!
                  .where((element) =>
                      element.free != null &&
                      element.free!.bookCategories != null)
                  .map((e) => e.free!.bookCategories!)
                  .toSet()

                  ///---///A Set is a collection of unique elements, and converting the list to a Set automatically removes any duplicate entries.
                  .toList()
              : [];

          // for (String? targetGenre in freeBookCategoriesList) {
          //   print(targetGenre);
          //   for (Free? book in freeBook) {
          //     if (book?.bookCategories == targetGenre) {
          //       print(book?.name);
          //     }
          //   }
          // }

          return Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: GridView.builder(
                      itemCount: freeBook.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) {
                        // Check if the necessary properties are not null before accessing them
                        String imageUrl =
                            '$coreUrl${freeBook![index]!.imageNameF ?? 'No image'}';

                        // '$coreUrl${model.book?[0].output?[index].free?.imageNameF ?? 'No image'}';
                        String authorName = freeBook![index]!.name ?? 'unknown';

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              freeDetails(index);
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
                                        return child;
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      // Display an error message or placeholder image
                                      return const Text('Error loading image');
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    authorName,
                                    softWrap: true,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                    model.book?[0].output?[index].free?.state ??
                                        'unknown'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              ///=====check if detailsBookFunction is called and isDisplayGenre is not true
              if (isFreeDetails && IsDisplayFreeGenre != true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        // if (displayImage.isNotEmpty)
                        Image.network(
                          freeDisplayImage,
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
                          'Price ${freeDisplayPrice.toString()}',
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
                          freeDisplayName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Author: $freeDisplayAuthor'),
                        Text('Category: $freeCategory'),
                        const Text(
                          'Genre :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                for (int i = 0;
                                    i < freeBookCategoriesList.length;
                                    i++)
                                  InkWell(
                                    borderRadius: BorderRadius.circular(25),
                                    splashColor: Colors.blue,
                                    onTap: () {
                                      displayFree(i);
                                      // print(premiumBookCategoriesList[i]);
                                    },
                                    child: Text(
                                      '${freeBookCategoriesList[i]}    ',
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
              else if (IsDisplayFreeGenre == true)
                Column(
                  children: [
                    Text(
                      '$genreBookType সম্পর্কিত আরো বই',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
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
                    ),
                    Column(
                      children: [
                        Text(
                          'Book Name: $names',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Other widgets...
                        // Text(
                        //   'Book Name: ${namesList[index]}',
                        //   style: const TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        // Display the book name (namee)
                        // Text(
                        //   'Book Name: $namee',
                        //   style: const TextStyle(fontWeight: FontWeight.bold),
                        // ),

                        // Other widgets...
                      ],
                    ),

                    //
                  ],
                )
            ],
          );
        });
  }

  ///-----------  free details book
  String freeDisplayName = '';
  String freeDisplayImage = '';
  int freeDisplayPrice = 0;
  String freeName = '';
  String freeDisplayAuthor = '';
  String freeCategory = '';
  List<String> allGenreImages = [];
  void freeDetails(int index) {
    setState(() {
      freeDisplayImage = '$coreUrl${freeBook[index]?.imageNameF ?? 'No image'}';
      freeDisplayPrice = freeBook[index]?.price ?? 0;
      freeName = freeBook[index]?.authorName ?? 'Unknown';
      freeDisplayName = freeBook[index]?.name ?? 'Unknown';
      freeDisplayAuthor = freeBook[index]?.authorName ?? 'Unknown';
      freeCategory = freeBook[index]?.bookCategories ?? 'Unknown';
      isFreeDetails = true;
    });
  }

  ///-----Display Genre

  String genreImage = '';
  int genrePrice = 0;
  String genreBookType = '';
  String namee = '';
  List<String> genreImages = [];
  List<int> genrePrices = [];
  List<String> names = [];

  void displayFree(int index) {
    setState(() {
      String? targetGenre = freeBookCategoriesList[index];
      genreBookType = freeBookCategoriesList[index]!;
      for (Free? book in freeBook) {
        if (book?.bookCategories == targetGenre) {
          genreImage = '$coreUrl${book?.imageNameF ?? 'No image'}';
          genrePrice = book?.price ?? 0;
          String bookType = targetGenre ?? '';
          String name = book?.name ?? 'Unknown';

          names.add(name);
          print(names);
        }
      }

      IsDisplayFreeGenre = true;
    });
  }
}