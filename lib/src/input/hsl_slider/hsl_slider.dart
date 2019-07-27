import 'dart:async';

import 'package:angular/angular.dart';
import 'package:ng_bind/ng_bind.dart';
import 'package:angular_color_picker/src/colored_slider/colored_slider.dart';

import 'package:lib_colors/lib_colors.dart';

@Component(
  selector: 'hsl-slider',
  styleUrls: ['hsl_slider.css'],
  templateUrl: 'hsl_slider.html',
  directives: [
    NgFor,
    NgIf,
    NumBinder,
    ColoredSlider,
  ],
  providers: [],
)
class HslSlider implements AfterViewInit {
  Painter huePaint;
  Painter saturationPaint;
  Painter lightnessPaint;

  @Input()
  set value(Color color) {
    _value = color.toHsl;
    _updatePainters();
  }

  Hsl _value = white.toHsl;

  Hsl get value => _value;

  HslSlider() {
    huePaint = (double v) => Hsl(h: v * 360);
    _updatePainters();
  }

  @override
  void ngAfterViewInit() {
    _updatePainters();
  }

  void _updatePainters() {
    saturationPaint = (double v) => Hsl(h: value.h, s: v * 100);
    lightnessPaint = lightnessPainter(value);
  }

  void hueChanged(v) {
    if(v < 0) v = 0;
    if(v > 1.0) v = 1.0;
    final newV = value.clone(h: v * 360);
    _changeEmitter.add(newV);
  }

  void saturationChanged(v) {
    if(v < 0) v = 0;
    if(v > 1.0) v = 1.0;
    final newV = value.clone(s: v * 100);
    _changeEmitter.add(newV);
  }

  void lightnessChanged(v) {
    if(v < 0) v = 0;
    if(v > 1.0) v = 1.0;
    final newV = value.clone(l: v * 100);
    _changeEmitter.add(newV);
  }

  final _changeEmitter = StreamController<Hsl>();

  @Output()
  Stream<Hsl> get change => _changeEmitter.stream;
}

Painter huePainter(Color color) {
  final hsl = color.toHsl;
  return (double x) => Hsl(h: 360 * x, s: hsl.s, l: hsl.l, a: 1.0);
}

Painter saturationPainter(Color color) {
  final hsl = color.toHsl;
  return (double x) => Hsl(h: hsl.h, s: 100 * x, l: hsl.l, a: 1.0);
}

Painter lightnessPainter(Color color) {
  final hsl = color.toHsl;
  return (double x) => Hsl(h: hsl.h, s: hsl.s, l: 100 * x, a: 1.0);
}
