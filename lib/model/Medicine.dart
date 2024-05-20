class Medicine {
  String uid;
  String image;
  String name;
  String reference;
  double price;

  Medicine({required this.uid, required this.image, required this.name, required this.reference, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'image': image,
      'name': name,
      'reference': reference,
      'price': price,
    };
  }
}
