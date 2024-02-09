import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/models/book_model.dart';
import 'package:weather_project_mvvm/core/services/book_api.dart';
import 'package:weather_project_mvvm/core/view_models/base_view_model.dart';
import 'package:weather_project_mvvm/locator.dart';

class BookViewModel extends BaseViewModel {
  final BookApi _bookApi = locator<BookApi>();

  ///for list
  List<BookModel> book = [];

  Future<void> bookApiViewModel() async {
    setViewState(ViewState.busy);
    final result = await _bookApi.bookapi();

    // List<Premium?> premiumBook = book[0]
    //         .output
    //         ?.where((output) => output?.premium != null)
    //         .map((output) => output?.premium)
    //         .toList() ??
    //     [];
    // List<Free?> FreeBook = book[0]
    //         .output
    //         ?.where((output) => output?.free != null)
    //         .map((output) => output?.free)
    //         .toList() ??
    //     [];

    book.add(result);

    setViewState(ViewState.idle);
  }
}
