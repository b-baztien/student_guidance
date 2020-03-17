import 'package:firebase_storage/firebase_storage.dart';

class GetImageService {
  Future<String> getImage(String path) async {
    String url;
    try {
      if (path.isNotEmpty) {
        StorageReference ref = FirebaseStorage.instance.ref().child(path);
        url = await ref.getDownloadURL().then((image) async {
          return image.toString();
        });
      }
    } catch (e) {
      rethrow;
    }
    return url;
  }

  /*Future<String> getImageDocument(DocumentSnapshot path) async {
    String url;
    try {
      if (path.isNotEmpty) {
        StorageReference ref = FirebaseStorage.instance.ref().child(path);
        url = await ref.getDownloadURL().then((image) async {
          return image.toString();
        });
      }
      return url;
    } catch (e) {
      rethrow;
    }
  }*/

  Future<List<String>> getListImage(List<dynamic> listAlbum) async {
    List<String> album = new List<String>();
    try {
      List<String> list = new List<String>();
      for (int i = 0; i < listAlbum.length; i++) {
        list.add(listAlbum[i]);
      }
      for (String img in list) {
        String url;
        StorageReference ref = FirebaseStorage.instance.ref().child(img);
        url = await ref.getDownloadURL().then((image) async {
          return image.toString();
        });
        album.add(url);
      }

      return album;
    } catch (e) {
      rethrow;
    }
  }
}
