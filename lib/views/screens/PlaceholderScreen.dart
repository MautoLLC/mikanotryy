import 'package:flutter/material.dart';

import 'WebViewScreen.dart';

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            GestureDetector(
              onTap: (){
                                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => WebView(
                                                        Title: 'mauto.co',
                                                        Url:
                                                            "https://mauto.co/",
                                                      )),
                                            );
              },
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset('images/MikanoLogo.png', width: 150, height: 250,),
                  Transform.translate(offset: Offset(0, 15),child: Image.asset('images/MautoGreyLogo.png', width: 150, height: 250,)),
            Spacer(),
                ],
              ),
            ),
            Text('This Feature will be available soon'),
                                    Spacer(),
],

        ),
      ),
    );
  }
}
