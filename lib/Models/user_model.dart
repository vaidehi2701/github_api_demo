class UserModel {
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  UserModel(this.login, this.avatarUrl, this.htmlUrl);

  Map toJson() =>
      {'login': login, 'avatar_url': avatarUrl, 'html_url': htmlUrl};

  UserModel.fromJson(Map json)
      : login = json['login'],
        avatarUrl = json['avatar_url'],
        htmlUrl = json['html_url'];
}
