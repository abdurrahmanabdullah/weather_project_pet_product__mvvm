class BookModel {
  List<Output>? output;
  int? totalBook;

  BookModel({this.output, this.totalBook});

  BookModel.fromJson(Map<String, dynamic> json) {
    if (json['output'] != null) {
      output = <Output>[];
      json['output'].forEach((v) {
        output!.add(new Output.fromJson(v));
      });
    }
    totalBook = json['total_book'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.output != null) {
      data['output'] = this.output!.map((v) => v.toJson()).toList();
    }
    data['total_book'] = this.totalBook;
    return data;
  }
}

class Output {
  Free? free;
  Premium? premium;

  Output({this.free, this.premium});

  Output.fromJson(Map<String, dynamic> json) {
    free = json['free'] != null ? new Free.fromJson(json['free']) : null;
    premium =
        json['premium'] != null ? new Premium.fromJson(json['premium']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.free != null) {
      data['free'] = this.free!.toJson();
    }
    if (this.premium != null) {
      data['premium'] = this.premium!.toJson();
    }
    return data;
  }
}

class Free {
  String? authorName;
  String? bookCategories;
  int? id;
  String? imageNameF;
  String? name;
  double? price;
  String? publisherName;
  String? state;
  bool? status;
  String? storeDate;
  String? summary;
  int? totalPage;
  String? translatorName;
  String? uuid;

  Free(
      {this.authorName,
      this.bookCategories,
      this.id,
      this.imageNameF,
      this.name,
      this.price,
      this.publisherName,
      this.state,
      this.status,
      this.storeDate,
      this.summary,
      this.totalPage,
      this.translatorName,
      this.uuid});

  Free.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    bookCategories = json['book_categories'];
    id = json['id'];
    imageNameF = json['image_name_f'];
    name = json['name'];
    price = json['price'];
    publisherName = json['publisher_name'];
    state = json['state'];
    status = json['status'];
    storeDate = json['store_date'];
    summary = json['summary'];
    totalPage = json['total_page'];
    translatorName = json['translator_name'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_name'] = this.authorName;
    data['book_categories'] = this.bookCategories;
    data['id'] = this.id;
    data['image_name_f'] = this.imageNameF;
    data['name'] = this.name;
    data['price'] = this.price;
    data['publisher_name'] = this.publisherName;
    data['state'] = this.state;
    data['status'] = this.status;
    data['store_date'] = this.storeDate;
    data['summary'] = this.summary;
    data['total_page'] = this.totalPage;
    data['translator_name'] = this.translatorName;
    data['uuid'] = this.uuid;
    return data;
  }
}

class Premium {
  String? authorName;
  String? bookCategories;
  String? imageNameF;
  String? language;
  String? name;
  double? price;
  String? publisherName;
  String? state;
  bool? status;
  String? storeDate;
  int? totalPage;
  String? translatorName;
  String? uuid;

  Premium(
      {this.authorName,
      this.bookCategories,
      this.imageNameF,
      this.language,
      this.name,
      this.price,
      this.publisherName,
      this.state,
      this.status,
      this.storeDate,
      this.totalPage,
      this.translatorName,
      this.uuid});

  Premium.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    bookCategories = json['book_categories'];
    imageNameF = json['image_name_f'];
    language = json['language'];
    name = json['name'];
    price = json['price'];
    publisherName = json['publisher_name'];
    state = json['state'];
    status = json['status'];
    storeDate = json['store_date'];
    totalPage = json['total_page'];
    translatorName = json['translator_name'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_name'] = this.authorName;
    data['book_categories'] = this.bookCategories;
    data['image_name_f'] = this.imageNameF;
    data['language'] = this.language;
    data['name'] = this.name;
    data['price'] = this.price;
    data['publisher_name'] = this.publisherName;
    data['state'] = this.state;
    data['status'] = this.status;
    data['store_date'] = this.storeDate;
    data['total_page'] = this.totalPage;
    data['translator_name'] = this.translatorName;
    data['uuid'] = this.uuid;
    return data;
  }
}