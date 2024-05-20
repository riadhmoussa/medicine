class MLTopHospitalData {
  String? image;
  String? title;
  String? subtitle;
  String? city;
  String? rating;
  String? fees;
  String? service;

  MLTopHospitalData({this.image, this.title, this.subtitle, this.city, this.rating, this.fees, this.service});
}

List<MLTopHospitalData> generateFakeHospitalData() {
  List<MLTopHospitalData> fakeData = [];
  for (int i = 1; i <= 10; i++) {
    fakeData.add(
      MLTopHospitalData(
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSspQRax0bOcAh4ruNDkoYClFeVFb2UX5myg33fPfXttg&s",
        title: 'Hôpital $i',
        subtitle: 'Description de l\'hôpital $i',
        city: 'Ville $i',
        rating: '${i % 5 + 1}.0', // Random rating between 1.0 and 5.0
        fees: '${i * 50}', // Random fees
        service: 'Service $i',
      ),
    );
  }
  return fakeData;
}
