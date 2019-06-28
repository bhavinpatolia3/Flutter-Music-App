import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttery/gestures.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

class AudioRadialSeekBar extends StatefulWidget {
  final String albumArtUri;
  final String songTitle;

  AudioRadialSeekBar({this.albumArtUri, String albumArtUrl, this.songTitle});

  @override
  AudioRadialSeekBarState createState() {
    return AudioRadialSeekBarState();
  }
}

class AudioRadialSeekBarState extends State<AudioRadialSeekBar> {
  double _seekPercent;

  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayhead,
        WatchableAudioProperties.audioSeeking,
      ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        double playbackProgress = 0.0;
        if (player.audioLength != null && player.position != null) {
          playbackProgress = player.position.inMilliseconds /
              player.audioLength.inMilliseconds;
        }

        _seekPercent = player.isSeeking ? _seekPercent : null;

        return RadialSeekBar(
          progress: playbackProgress,
          seekPercent: _seekPercent,
          onSeekRequested: (double seekPercent) {
            setState(() => _seekPercent = seekPercent);

            final seekMillis =
                (player.audioLength.inMilliseconds * seekPercent).round();
            player.seek(Duration(milliseconds: seekMillis));
          },
        );
      },
    );
  }
}

class RadialSeekBar extends StatefulWidget {
  final double progress;
  final double seekPercent;
  final Function(double) onSeekRequested;
  final Widget child;

  RadialSeekBar({
    this.progress = 0.0,
    this.seekPercent = 0.0,
    this.onSeekRequested,
    this.child,
  });

  @override
  RadialSeekBarState createState() {
    return RadialSeekBarState();
  }
}

class RadialSeekBarState extends State<RadialSeekBar> {
  double _progress = 0.0;
  PolarCoord _startDragCoord;
  double _startDragPercent;
  double _currentDragPercent;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;
  }

  @override
  void didUpdateWidget(RadialSeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _progress = widget.progress;
  }

  void _onDragStart(PolarCoord coord) {
    _startDragCoord = coord;
    _startDragPercent = _progress;
  }

  void _onDragUpdate(PolarCoord coord) {
    final dragAngle = coord.angle - _startDragCoord.angle;
    final dragPercent = -dragAngle / (pi);

    setState(
        () => _currentDragPercent = (_startDragPercent + dragPercent) % 1.0);
  }

  void _onDragEnd() {
    if (widget.onSeekRequested != null) {
      widget.onSeekRequested(_currentDragPercent);
    }

    setState(() {
      _currentDragPercent = null;
      _startDragCoord = null;
      _startDragPercent = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double thumbPosition = _progress;
    double progressDrag = _progress;
    if (_currentDragPercent != null) {
      thumbPosition = _currentDragPercent;
      progressDrag = _currentDragPercent;
    } else if (widget.seekPercent != null) {
      thumbPosition = widget.seekPercent;
      progressDrag = widget.seekPercent;
    }

    return RadialDragGestureDetector(
      onRadialDragStart: _onDragStart,
      onRadialDragUpdate: _onDragUpdate,
      onRadialDragEnd: _onDragEnd,
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent, // needed
          child: Center(
            child: Container(
              width: 150.0,
              height: 250.0,
              child: RadialProgressBar(
                trackColor: Colors.grey[400],
                progressColor: Colors.black,
                thumbColor: Colors.black,
                progressPercent: progressDrag,
                thumbPositionPercent: thumbPosition,
                innerPadding: EdgeInsets.all(0.0),
                outerPadding: EdgeInsets.all(0.0),
                thumbSize: 8.0,
              ),
            ),
          )),
    );
  }
}

class RadialProgressBar extends StatefulWidget {
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final double thumbPositionPercent;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;

  final Widget child;

  RadialProgressBar(
      {this.trackWidth = 5.0,
      this.trackColor = Colors.grey,
      this.progressWidth = 5.0,
      this.progressColor = Colors.black,
      this.progressPercent = 0.0,
      this.thumbSize = 8.0,
      this.thumbColor = Colors.blue,
      this.thumbPositionPercent = 0.0,
      this.outerPadding = const EdgeInsets.all(0.0),
      this.innerPadding = const EdgeInsets.all(0.0),
      this.child});

  @override
  RadialProgressBarState createState() {
    return RadialProgressBarState();
  }
}

class RadialProgressBarState extends State<RadialProgressBar> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: RadialSeekBarPainter(
          trackWidth: widget.trackWidth,
          trackColor: widget.trackColor,
          progressWidth: widget.progressWidth,
          progressColor: widget.progressColor,
          progressPercent: widget.progressPercent,
          thumbColor: widget.thumbColor,
          thumbSize: widget.thumbSize,
          thumbPositionPercent: widget.thumbPositionPercent),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter {
  final double trackWidth;
  final Paint trackPaint;
  final double progressWidth;
  final double progressPercent;
  final Paint progressPaint;
  final double thumbSize;
  final double thumbPositionPercent;
  final Paint thumbPaint;

  RadialSeekBarPainter(
      {@required this.trackWidth,
      @required trackColor,
      @required this.progressWidth,
      @required progressColor,
      @required this.progressPercent,
      @required this.thumbSize,
      @required thumbColor,
      @required this.thumbPositionPercent})
      : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progressPaint = Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round,
        thumbPaint = Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness = max(trackWidth, max(progressWidth, thumbSize));
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) + outerThickness / 2;

    final start = pi;
    //Draw Half Circle.
    canvas.drawArc(
      new Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi,
      -start,
      false,
      trackPaint,
    );

    //painting the  progress
    final progressAngle = -pi * progressPercent;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    final double startAngle = -pi;
    canvas.drawArc(rect, startAngle, progressAngle, false, progressPaint);

    // paint the thumb circle
    final double thumbAngle = -pi * thumbPositionPercent;
    final Offset thumbCenter =
        center + Offset(-cos(thumbAngle) * radius, -sin(thumbAngle) * radius);
    final thumbRadius = thumbSize;
    canvas.drawCircle(thumbCenter, thumbRadius, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
