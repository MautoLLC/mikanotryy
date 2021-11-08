import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'WebViewScreen.dart';

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Spacer(),
                GestureDetector(
                                      onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WebView(
                          Title: "Mauto",
                          Url:
                              "https://Mauto.co",
                        )),);
                    },
                  child: Image.asset('images/MyMikanoLogo.png',
                      height: 85, fit: BoxFit.fill),
                ),
                    Text("This feature will be available soon"),
                    
                Spacer(),
                GestureDetector(
                                                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WebView(
                          Title: "Mauto",
                          Url:
                              "https://Mauto.co",
                        )),);
                    },
                  child: Transform.translate(
                    offset: Offset(0, -10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Powered by ",
                            style: boldTextStyle(size: 12, color: Colors.grey)),
                        Image.asset(
                          "images/MautoGreyLogo.png",
                          width: 32,
                          height: 32,
                          color: Colors.grey,
                        ),
                        
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
