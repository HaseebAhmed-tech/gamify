import 'package:flutter/material.dart';

import '../widgets/scrollable_games_widget.dart';

import '../data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late int _selectedGame;

  @override
  void initState() {
    super.initState();
    _selectedGame = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, cons) {
        return Stack(
          children: <Widget>[
            _featuredGamesWidget(cons),
            _gradientBoxWidget(cons),
            _topBarWidget(cons),
            Positioned(bottom: 0, child: _topLayerWidget(cons)),
          ],
        );
      }),
    );
  }

  Widget _featuredGamesWidget(BoxConstraints cons) {
    return SizedBox(
        height: cons.maxHeight * 0.50,
        width: cons.maxWidth,
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              _selectedGame = index;
            });
          },
          scrollDirection: Axis.horizontal,
          children: featuredGames.map((game) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(game.coverImage.url),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _gradientBoxWidget(BoxConstraints cons) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: cons.maxHeight * 0.68,
        width: cons.maxWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(35, 45, 59, 1.0),
              Colors.transparent,
            ],
            stops: [0.8, 1.0],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Widget _topLayerWidget(BoxConstraints cons) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: cons.maxWidth * 0.05, vertical: cons.maxHeight * 0.005),
      child: SizedBox(
        height: cons.maxHeight * 0.7,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _featuredGamesInfoWidget(cons),
              Padding(
                padding: EdgeInsets.symmetric(vertical: cons.maxHeight * 0.01),
                child: ScrollableGamesWidget(
                    cons.maxHeight * 0.24, cons.maxWidth, true, games),
              ),
              _featuredGameBannerWidget(cons),
              ScrollableGamesWidget(
                  cons.maxHeight * 0.22, cons.maxWidth, false, games2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBarWidget(BoxConstraints cons) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: cons.maxWidth * 0.05, vertical: cons.maxHeight * 0.02),
      height: cons.maxHeight * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: cons.maxWidth * 0.03,
              ),
              const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 30,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _featuredGamesInfoWidget(BoxConstraints cons) {
    return SizedBox(
      height: cons.maxHeight * 0.15,
      width: cons.maxWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            featuredGames[_selectedGame].title,
            maxLines: 2,
            style: TextStyle(
                color: Colors.white, fontSize: cons.maxHeight * 0.040),
          ),
          // SizedBox(height: cons.maxHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: featuredGames.map((game) {
              bool isActive = game.title == featuredGames[_selectedGame].title;
              double circleRadius = cons.maxHeight * 0.004;
              return Container(
                margin: EdgeInsets.only(right: cons.maxWidth * 0.015),
                height: circleRadius * 2,
                width: circleRadius * 2,
                decoration: BoxDecoration(
                  color: isActive ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _featuredGameBannerWidget(BoxConstraints cons) {
    return Container(
      height: cons.maxHeight * 0.13,
      width: cons.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(featuredGames[3].coverImage.url),
        ),
      ),
    );
  }
}
