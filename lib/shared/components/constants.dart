




 //base url : https://newsapi.org/
//method url: v2/everything?
//queries: q=tesla&from=2022-05-12&sortBy=publishedAt&apiKey=a28f31daaf9f47eaa2d544f2bd2a4b20



 //base url: https://newsapi.org/
 // method url : v2/everything?
 //queries: q=apple&from=2022-06-25&to=2022-06-25&sortBy=popularity&apiKey=a28f31daaf9f47eaa2d544f2bd2a4b20




 //https://newsapi.org/v2/everything?q=tesla&apiKey=a28f31daaf9f47eaa2d544f2bd2a4b20

 import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/login/shop_login_screen.dart';

void signOut(context)
 {
   CacheHelper.removeData(key: 'token').then((value)
   {
     navigateAndFinish(context, ShopLoginScreen());
   });
 }

 // method جاهزه بنستخدمها عشان تطلع كل الداتا من غير ما تنقص

 void printfullText(String text)
 {
   final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
   pattern.allMatches(text).forEach((element) => print(element.group(0)));
 }

 String token='';

 String uId='';