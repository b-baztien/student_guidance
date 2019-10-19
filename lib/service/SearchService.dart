import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/UniversityService.dart';

class SearchService {
  Future<List<FilterSeachItems>> getItemSearch() async{
        List<FilterSeachItems> list = new List<FilterSeachItems>();
        List<University> listUniversity;
        List<Faculty> listFaculty;
        List<Major> listMajor;
        Set<Faculty> setFaculty;
        Set<Major> setMajor;
      listUniversity = await UniversityService().getUniversity().then((universityFromService){
          return universityFromService;
        });
        for(University u in listUniversity){
          FilterSeachItems ff = new FilterSeachItems();
          ff.name = u.universityname;
          ff.type = 'University';
          list.add(ff);
        }
      listFaculty = await FacultyService().getAllFaculty().then((facultyFromService){
        return facultyFromService;
      });
      setFaculty.addAll(listFaculty);
        for(Faculty f in listFaculty){
             FilterSeachItems ff = new FilterSeachItems();
          ff.name =f.facultyName;
          ff.type = 'Faculty';
          list.add(ff);
        }
       listMajor = await MajorService().getAllMajor().then((majorFromService){
         return majorFromService;
       });
       setMajor.addAll(listMajor);
        for(Major m in setMajor){
          FilterSeachItems ff = new FilterSeachItems();
          ff.name =m.majorName;
          ff.type = 'Faculty';
          list.add(ff);
        }
        print(list.length);
        return list;
  }
}