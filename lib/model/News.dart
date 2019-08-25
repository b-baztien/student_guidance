class News {
  final String newsID;
  final String topic;
  final String detail;
  final String photo;
  News({this.newsID,this.detail,this.photo,this.topic});
}
List getListNews = [
  News(
    topic: "News1",
    detail:"test_detail_news1",
    photo: "assets/images/news_1.jpg"
  ),
  News(
      topic: "News2",
    detail:"test_detail_news2",
    photo: "assets/images/news_2.jpg"
  ),
    News(
      topic: "News3",
    detail:"test_detail_news3",
    photo: "assets/images/news_3.jpg"
  )
];

List<String> images = [
  "assets/images/news_1.jpg",
  "assets/images/news_2.jpg",
  "assets/images/news_3.jpg",
];
List<String> title = [
  "Hounted Ground",
  "Fallen In Love",
  "The Dreaming Moon",
];