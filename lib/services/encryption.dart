



import 'package:encrypt/encrypt.dart';
String encryption(String plainText) {

  final key = Key.fromUtf8("MAKV2SPBNI992121");
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}

 decryption(String plainText) {

  final key = Key.fromUtf8("MAKV2SPBNI992121");
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  final decrypted = encrypter.decrypt(Encrypted.from64(plainText), iv: iv);

  return decrypted;
}