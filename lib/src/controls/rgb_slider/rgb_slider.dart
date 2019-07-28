import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_color_picker/src/colored_slider/colored_slider.dart';
import 'package:angular_color_picker/src/controls/opacity_slider/opacity_slider.dart';

import 'package:lib_colors/lib_colors.dart';
import 'package:ng_bind/ng_bind.dart';

@Component(
  selector: 'rgb-slider',
  styleUrls: ['rgb_slider.css'],
  templateUrl: 'rgb_slider.html',
  directives: [
    NgFor,
    NgIf,
    NumBinder,
    ColoredSlider,
    OpacitySlider,
  ],
  providers: [],
)
class RgbSlider implements AfterViewInit {
  Painter redPaint;
  Painter greenPaint;
  Painter bluePaint;

  @Input()
  set value(Color color) {
    _value = color.toRgb;
    _updatePainters();
  }

  Rgb _value = white;

  Rgb get value => _value;

  RgbSlider() {
    _updatePainters();
  }

  @override
  void ngAfterViewInit() {
    _updatePainters();
  }

  void _updatePainters() {
    redPaint = redPainter(value);
    greenPaint = greenPainter(value);
    bluePaint = bluePainter(value);
  }

  void redChanged(v) {
    if (v < 0) v = 0;
    if (v > 1.0) v = 1.0;
    final newV = value.clone(r: (v * 255).toInt());
    _changeEmitter.add(newV);
  }

  void greenChanged(v) {
    if (v < 0) v = 0;
    if (v > 1.0) v = 1.0;
    final newV = value.clone(g: (v * 255).toInt());
    _changeEmitter.add(newV);
  }

  void blueChanged(v) {
    if (v < 0) v = 0;
    if (v > 1.0) v = 1.0;
    final newV = value.clone(b: (v * 255).toInt());
    _changeEmitter.add(newV);
  }

  void opacityChanged(double v) {
    if (v < 0) v = 0;
    if (v > 1.0) v = 1.0;
    final newV = value.clone(a: v);
    _changeEmitter.add(newV);
  }

  final _changeEmitter = StreamController<Rgb>();

  @Output()
  Stream<Rgb> get change => _changeEmitter.stream;
}

Painter redPainter(Color color) {
  final rgb = color.toRgb;
  return (double x) => Rgb(r: (255 * x).toInt(), g: rgb.g, b: rgb.b, a: 1.0);
}

Painter greenPainter(Color color) {
  final rgb = color.toRgb;
  return (double x) => Rgb(r: rgb.r, g: (255 * x).toInt(), b: rgb.b, a: 1.0);
}

Painter bluePainter(Color color) {
  final rgb = color.toRgb;
  return (double x) => Rgb(r: rgb.r, g: rgb.g, b: (255 * x).toInt(), a: 1.0);
}
