class AppEndPoints {
  static const String baseUrl = 'https://dog.ceo/api';
  static const String allBreeds = '$baseUrl/breeds/list/all';
  static String randomImageByBreed(String breed) =>
      '$baseUrl/breed/$breed/images/random';
  static String randomFiveImageBySearchBreed(String breed) =>
      '$baseUrl/breed/$breed/images/random/5';
}
