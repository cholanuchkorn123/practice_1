class AppwriteConstant {
  static const String dataBaseId = '647c23e24bd56646f429';
  static const String projectId = '647c21bc2ca2419f062a';
  static const String endpoint = 'http://172.28.224.1/v1';
  static const String usersCollection = '647d90bdde293da9c639';
  static const String tweetCollection = '64843440012b2cef8343';
  static const String imagesBucket = '64847b9d816c4e694eb2';

  static String imageUrl(String imageId) =>
      '$endpoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
