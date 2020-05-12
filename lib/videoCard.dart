import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {

	VideoPlayerController _controller;
	Future<void> _initialVideoPlayerFuture;

	@override
  void initState() {
	_controller = VideoPlayerController.network(
		'https://www.youtube.com/watch?v=VDB1OHb5SGg'
	);

	_initialVideoPlayerFuture = _controller.initialize();
	_controller.setLooping(true);
	_controller.setVolume(1);
    super.initState();
  }


	Widget makeFeed({userName, userImage, feedTime, feedText, feedVideo}) {
		return Container(
			margin: EdgeInsets.only(bottom: 20),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Row(
								children: <Widget>[
									Container(
										width: 50,
										height: 50,
										decoration: BoxDecoration(
											shape: BoxShape.circle,
											image: DecorationImage(
												image: NetworkImage(userImage),
												fit: BoxFit.cover
											)
										),
									),
									SizedBox(width: 10,),
									Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Text(userName, style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
											SizedBox(height: 3,),
											Text(feedTime, style: TextStyle(fontSize: 15, color: Colors.grey),),
										],
									)
								],
							),
							IconButton(
								icon: Icon(Icons.more_horiz, size: 30, color: Colors.grey[600],),
								onPressed: () {},
							)
						],
					),
					SizedBox(height: 20,),
					Text(feedText, style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
					SizedBox(height: 20,),
					feedVideo != '' ? GestureDetector(
						child: FutureBuilder(
							future: _initialVideoPlayerFuture,
							builder: (context, snapshot) {
								if (snapshot.connectionState == ConnectionState.done) {
									return AspectRatio(
										aspectRatio: _controller.value.aspectRatio,
										child: VideoPlayer(_controller),
									);
								}
								else {
									return Center(
										child: CircularProgressIndicator(),
									);
								}
							},
						),
						onTap: () {
							setState(() {
								if(_controller.value.isPlaying){
									_controller.pause();
								}
								else {
									_controller.play();
								}
							});
						},
					) : Container(),
					SizedBox(height: 20,),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Row(
								children: <Widget>[
									makeLike(),
									Transform.translate(
										offset: Offset(-5, 0),
										child: makeLove()
									),
									SizedBox(width: 5,),
									Text("2.5K", style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
								],
							),
							Text("400 Comments", style: TextStyle(fontSize: 13, color: Colors.grey[800]),)
						],
					),
					SizedBox(height: 20,),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							makeLikeButton(isActive: true),
							makeCommentButton(),
							makeShareButton(),
						],
					)
				],
			),
		);
	}

	Widget makeLike() {
		return Container(
			width: 25,
			height: 25,
			decoration: BoxDecoration(
				color: Colors.blue,
				shape: BoxShape.circle,
				border: Border.all(color: Colors.white)
			),
			child: Center(
				child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
			),
		);
	}

	Widget makeLove() {
		return Container(
			width: 25,
			height: 25,
			decoration: BoxDecoration(
				color: Colors.red,
				shape: BoxShape.circle,
				border: Border.all(color: Colors.white)
			),
			child: Center(
				child: Icon(Icons.favorite, size: 12, color: Colors.white),
			),
		);
	}

	Widget makeLikeButton({isActive}) {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
			decoration: BoxDecoration(
				border: Border.all(color: Colors.grey[200]),
				borderRadius: BorderRadius.circular(50),
			),
			child: Center(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Icon(Icons.thumb_up, color: isActive ? Colors.blue : Colors.grey, size: 18,),
						SizedBox(width: 5,),
						Text("Like", style: TextStyle(color: isActive ? Colors.blue : Colors.grey),)
					],
				),
			),
		);
	}

	Widget makeCommentButton() {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
			decoration: BoxDecoration(
				border: Border.all(color: Colors.grey[200]),
				borderRadius: BorderRadius.circular(50),
			),
			child: Center(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Icon(Icons.chat, color: Colors.grey, size: 18),
						SizedBox(width: 5,),
						Text("Comment", style: TextStyle(color: Colors.grey),)
					],
				),
			),
		);
	}

	Widget makeShareButton() {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
			decoration: BoxDecoration(
				border: Border.all(color: Colors.grey[200]),
				borderRadius: BorderRadius.circular(50),
			),
			child: Center(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Icon(Icons.share, color: Colors.grey, size: 18),
						SizedBox(width: 5,),
						Text("Share", style: TextStyle(color: Colors.grey),)
					],
				),
			),
		);
	}

  @override
  Widget build(BuildContext context) {
    return makeFeed(
		feedVideo: 'https://www.youtube.com/watch?v=VDB1OHb5SGg',
		userName: "Iresh Sharma",
		userImage: 'https://images.pexels.com/photos/2909067/pexels-photo-2909067.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
		feedTime: "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
		feedText: 'Hey hi this is the new design'
	);
  }
}


//hello i made this

