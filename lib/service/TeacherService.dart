import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/Teacher.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/StudentService.dart';

class TeacherService{
  Future<Teacher> getTeacher(DocumentReference doc) async {
    try {
      DocumentReference refQuery = doc;
      Teacher teacher = await refQuery.get().then((doc) async {
        return Teacher.fromJson(doc.data);
      });
      return teacher;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<Teacher>> getAllTeacher() async{
    Student student = new Student();
    List<Teacher> list = new List<Teacher>();
     student = await  StudentService().getStudent().then((studentFromService) async{
       return studentFromService;
    });
     DocumentReference refQuery = student.school;
  
        CollectionReference collectionReferenceUniver = Firestore.instance.collection('Teacher');
      QuerySnapshot qs = await collectionReferenceUniver.where('school', isEqualTo: refQuery).getDocuments();
      
       for(DocumentSnapshot ds in qs.documents){
         Teacher teacher = Teacher.fromJson(ds.data);
        teacher.image =
          await GetImageService().getImage(teacher.image).then((url) async {
        return url;
      });
         list.add(teacher);
       }
       return list;
  }
}