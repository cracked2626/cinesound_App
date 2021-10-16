import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String title;
  final String shortInfo;
  final Timestamp publishedDate;
  final List<dynamic> thumbnailUrl;
  final String longDescription;
  final String productCateory;
  final String status;
  final int price;
  final String discount;
  final String productId;
  final double rating;
  final bool isFavourite;

  ItemModel({
    this.title,
    this.shortInfo,
    this.publishedDate,
    this.thumbnailUrl,
    this.longDescription,
    this.status,
    this.price,
    this.productCateory,
    this.discount,
    this.isFavourite,
    this.rating,
    this.productId,
  });

  factory ItemModel.fromDocument(DocumentSnapshot doc) {
    return ItemModel(
      title: doc['title'],
      shortInfo: doc['shortInfo'],
      publishedDate: doc['publishedDate'],
      thumbnailUrl: doc['thumbnailUrl'],
      longDescription: doc['longDescription'],
      status: doc['status'],
      price: doc['price'],
      discount: doc['discount'],
      productCateory: doc['product_Category'],
      isFavourite: doc['isFavourite'] == null ? false : doc['isFavourite'],
      rating: doc['isFavourite'] == null ? 0 : doc['isFavourite'],
      productId: doc.id,
    );
  }

  // ItemModel.fromJson(Map<String, dynamic> json) {
  //   title = json['title'];
  //   shortInfo = json['shortInfo'];
  //   publishedDate = json['publishedDate'];
  //   thumbnailUrl = json['thumbnailUrl'];
  //   longDescription = json['longDescription'];
  //   status = json['status'];
  //   price = json['price'];
  //   discount = json['product_Category'];
  //   product_Category = json['product_Category'];
  //   isFavourite= json['isFavourite'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['title'] = this.title;
  //   data['shortInfo'] = this.shortInfo;
  //   data['price'] = this.price;
  //   if (this.publishedDate != null) {
  //     data['publishedDate'] = this.publishedDate;
  //   }
  //   data['thumbnailUrl'] = this.thumbnailUrl;
  //   data['longDescription'] = this.longDescription;
  //   data['status'] = this.status;
  //   data['discount'] = this.discount;
  //   data['product_Category'] = this.product_Category;
  //   data['isFavourite'] = this.isFavourite;
  //
  //   return data;
  // }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
