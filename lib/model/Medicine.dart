class Medicine {
  String uid;
  String image;
  String name;
  String reference;
  double price;
  String category;

  Medicine({required this.uid, required this.image, required this.name, required this.reference, required this.price, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'image': image,
      'name': name,
      'reference': reference,
      'price': price,
      'category': category,
    };
  }
}

