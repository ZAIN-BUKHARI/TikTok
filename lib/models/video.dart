import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String videoUrl;
  String username;
  String thumbail;
  String uid;
  String id;
  String profilePhoto;
  String caption;
  String songname;
  List likes;
  int commentcount;
  int sharecount;

  Video({
    required this.thumbail,
    required this.videoUrl,
    required this.username,
    required this.uid,
    required this.id,
    required this.profilePhoto,
    required this.caption,
    required this.songname,
    required this.likes,
    required this.commentcount,
    required this.sharecount, 
  });

  Map<String, dynamic> fileJson() => {
    "username":username,
        "videoUrl": videoUrl,
         "thumbail": thumbail,
        "uid": uid,
        "id": id,
        "likes": likes,
        "sharecount": sharecount,
        "caption": caption,
        "commentcount": commentcount,
        "profilePhoto": profilePhoto,
        "songname": songname,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      videoUrl: snapshot['videoUrl'],
      username: snapshot['username'],
      thumbail: snapshot['thumbail'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      sharecount: snapshot['sharecount'],
      caption: snapshot['caption'],
      commentcount: snapshot['commentcount'],
      profilePhoto: snapshot['profilePhoto'],
      songname: snapshot['songname'],
    );
  }
}
