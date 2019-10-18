import 'package:firebase_storage/firebase_storage.dart';

class GetImageService {
  Future<String> getImage(String path) async{
   
   String url;
   try{
     StorageReference ref = FirebaseStorage.instance.ref().child(path);
    url = await ref.getDownloadURL().then((image) async{
        return image.toString();
    });
   
    return url;
   }catch(e) {
      rethrow;
    }
   
 }
}