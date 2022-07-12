class UserModel {
  String? nama;
  String? avatar;
  String? alamat;
  String? email;
  String? pekerjaan;
  String? quote;
  String? id;

  UserModel(
      {this.nama,
      this.avatar,
      this.alamat,
      this.email,
      this.pekerjaan,
      this.quote,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    avatar = json['avatar'];
    alamat = json['alamat'];
    email = json['email'];
    pekerjaan = json['pekerjaan'];
    quote = json['quote'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['avatar'] = this.avatar;
    data['alamat'] = this.alamat;
    data['email'] = this.email;
    data['pekerjaan'] = this.pekerjaan;
    data['quote'] = this.quote;
    data['id'] = this.id;
    return data;
  }
}
