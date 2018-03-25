import 'package:crypto_shadow/database/database_client.dart';
import 'package:crypto_shadow/model/portfolio.dart';
import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_page.dart';
import 'package:flutter/services.dart';
import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';
import 'package:flutter/material.dart';
import 'package:crypto_shadow/theme.dart' as Theme;


class AddCoinPage extends StatefulWidget {
  @override
  AddCoinPageState createState() => new AddCoinPageState();
}

class AddCoinPageState extends State<AddCoinPage> {

  String data;

  final TextEditingController _controllerSymbol = new TextEditingController();
  final TextEditingController _controllerPriceUSD = new TextEditingController();
  final TextEditingController _controllerAmount = new TextEditingController();

  DatabaseClient db = new DatabaseClient();

  void save(BuildContext context) async{

    await db.create();
    Portfolio portfolio = new Portfolio();
    portfolio.symbol = _controllerSymbol.text;
    portfolio.priceUSD = _controllerPriceUSD.text;
    portfolio.amount = _controllerAmount.text;
    portfolio = await db.insertPortfolio(portfolio);
    await db.close();

    Navigator.of(context).push(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new PortfolioPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        new FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors2.appBarGradientStart, Theme.Colors2.appBarGradientEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),

        child: new Column(
          children: <Widget>[
            new GradientAppBarWithBack("Add Portfolio"),

            new Container(
              margin: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),

              decoration: new BoxDecoration(
                color: new Color(0xFFFFFFFF),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: new Color(0xFFee0979),
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),

              child: new Column(children: <Widget>[
                new Stack(
                    alignment: const Alignment(1.0, 0.5),
                    children: <Widget>[
                      new TextField(
                        controller: _controllerSymbol,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        style: Theme.TextStyles.commonTextStyle,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                          hintStyle: Theme.TextStyles.commonTextStyle,
                          labelStyle: Theme.TextStyles.commonTextStyle,
                          labelText: "Symbol",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                ),
                new Separator(),
                new Stack(
                    alignment: const Alignment(1.0, 0.5),
                    children: <Widget>[
                      new TextField(
                        controller: _controllerPriceUSD,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style: Theme.TextStyles.commonTextStyle,

                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                          hintStyle: Theme.TextStyles.commonTextStyle,
                          labelStyle: Theme.TextStyles.commonTextStyle,
                          labelText: "Buy Price in USD",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                ),
                new Separator(),
                new Stack(
                    alignment: const Alignment(1.0, 0.5),
                    children: <Widget>[
                      new TextField(
                        controller: _controllerAmount,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style: Theme.TextStyles.commonTextStyle,

                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                          hintStyle: Theme.TextStyles.commonTextStyle,
                          labelStyle: Theme.TextStyles.commonTextStyle,
                          labelText: "Amount Bought",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                ),

              ],),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: new MaterialButton(
                minWidth: 200.0,
                onPressed: () => save(context),
                child: new Text('Save', style: Theme.TextStyles.commonTextStyleWhite,),
                color: Theme.Colors2.colorBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}