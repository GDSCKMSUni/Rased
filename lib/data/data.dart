import '../models/post_model.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';

final User currentUser = User(
  name: 'Marwan',
  imageUrl: '',
);

final List<User> onlineUsers = [
  User(
    name: 'Mohammed',
    imageUrl: '',
  ),
  User(
    name: 'Ahmad',
    imageUrl: '',
  ),
];

final List<Post> posts = [
  Post(
    user: currentUser,
    caption:
        ':مسافرون عالقون في نقيل سماره والسبب،إنهيار صخري كبير سبب في قطع الطريق عن المسافرين والان ،يجري تقوم الجهات المختصة برفع الصخور من الطريق بعد تبليغها.',
    timeAgo: '58m',
    imageUrl: 'https://aden-alhadath.info/photos//122018/5c1be05d63196.jpeg',
    likes: 1202,
    comments: 184,
    shares: 96,
  ),
  Post(
    user: onlineUsers[0],
    caption: 'منخفض جوي خطير وغير مسبوق يجتاح العاصمة صنعاء',
    timeAgo: '58m',
    imageUrl: 'https://mujtahid.net/wp-content/uploads/2022/07/imgid541428.jpg',
    likes: 1202,
    comments: 184,
    shares: 96,
  ),
  Post(
    user: onlineUsers[1],
    caption:
        'أمطار غزيرة تتسبب بتهدم أربعة منازل في صنعاء، وارتفاع منسوب الماء في السائلة باب اليمن وعليه نرجو من جميع السائقين الحذر وان يسلوك طريقاً اخر',
    timeAgo: '58m',
    imageUrl:
        'https://almawqeapost.net/upimages/news/Almawqea2022-08-07-01-19-06-551011.jpg',
    likes: 1202,
    comments: 184,
    shares: 96,
  ),
];
