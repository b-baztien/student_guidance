class University{
  final String universiyname;
  final String address;
  final String url;
  final String phoneNO;
  final String universitydetail;
  final String zone;
  final String view;
  University(
    {
      this.universiyname,this.address,this.phoneNO,this.universitydetail,this.url,this.view,this.zone
    }
  );
}

List universitys = [
    University(
      universiyname: "Test"
    )
];