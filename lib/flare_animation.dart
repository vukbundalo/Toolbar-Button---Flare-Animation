import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

enum AnimationToPlay{
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped,
}

class FlareAnimation extends StatefulWidget {
  @override
  _FlareAnimationState createState() => _FlareAnimationState();
}

class _FlareAnimationState extends State<FlareAnimation> {
  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;

  //create out flare controlls
  final FlareControls animationControls = FlareControls();

  bool isOpen = false;

  //width and height retrieved from the art board values in the animation (assets/button-animation.flr)
  static const double animationHeight = 251;
  static const double animationWidth = 295;




  @override
  Widget build(BuildContext context) {
    return Container(
        height: animationHeight,
        width: animationWidth,
        child: GestureDetector(
          onTapUp: (tapInfo){
            setState(() {
            var localTouchPosition = (context.findRenderObject() as RenderBox)
            .globalToLocal(tapInfo.globalPosition);

            //Where did we touch animated button?
            var topHalfTouched = localTouchPosition.dy < animationHeight / 2;
            var leftSideTouched = localTouchPosition.dx < animationWidth / 2.5;
            var rightSideTouched = localTouchPosition.dx > (animationWidth / 3.1) * 2;
            var middleTouched = !leftSideTouched && !rightSideTouched;

            //TODO Add code to deactivate right and left side of the button, only button should activate the animation

            if (leftSideTouched && topHalfTouched){
              _setAnimationToPlay(AnimationToPlay.CameraTapped);
            } else if(middleTouched && topHalfTouched){
              _setAnimationToPlay(AnimationToPlay.PulseTapped);
            } else if(rightSideTouched && topHalfTouched){
              _setAnimationToPlay(AnimationToPlay.ImageTapped);
              } else{
              if (isOpen){
                _setAnimationToPlay(AnimationToPlay.Deactivate);
              } else{
                _setAnimationToPlay(AnimationToPlay.Activate);
              }
              isOpen = !isOpen;
            }



            });
          },
          child: FlareActor(
            'assets/button-animation.flr',
            animation: _getAnimationName(_animationToPlay),
            controller: animationControls,
          ),
        ),
      );
  }


  String _getAnimationName(AnimationToPlay animationToPlay){
    switch(animationToPlay){
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation){
    var isTappedAnimation = _getAnimationName(animation).contains('_tapped');
    if (isTappedAnimation && _lastPlayedAnimation == AnimationToPlay.Deactivate){
      return;
    }

    animationControls.play(_getAnimationName(animation));

    //Remember out last played animation
    _lastPlayedAnimation = animation;
  }
}