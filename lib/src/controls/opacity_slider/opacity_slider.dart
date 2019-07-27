import 'dart:async';

import 'package:angular/angular.dart';
import 'package:ng_bind/ng_bind.dart';
import 'package:angular_color_picker/src/colored_slider/colored_slider.dart';

import 'package:lib_colors/lib_colors.dart';

@Component(
  selector: 'opacity-slider',
  styleUrls: ['opacity_slider.css'],
  templateUrl: 'opacity_slider.html',
  directives: [
    NgFor,
    NgIf,
    NumBinder,
    ColoredSlider,
  ],
  providers: [],
)
class OpacitySlider implements AfterViewInit {
  Painter paint;

  @Input()
  double value = 1.0;

  Color _color = white;

  @Input()
  set color(Color color) {
    _color = color.toRgb;
    _updatePainters();
  }

  Color get color => _color;

  OpacitySlider() {
    _updatePainters();
  }

  @override
  void ngAfterViewInit() {
    _updatePainters();
  }

  void _updatePainters() {
    paint = opacityPainter(_color);
  }

  void opacityChanged(v) {
    if(v < 0) v = 0;
    if(v > 1.0) v = 1.0;
    _changeEmitter.add(v);
  }

  final _changeEmitter = StreamController<double>();

  @Output()
  Stream<double> get change => _changeEmitter.stream;
}

Painter opacityPainter(Color color) {
  final rgb = color.toRgb;
  return (double x) => Rgb(r: rgb.r, g: rgb.g, b: rgb.b, a: x);
}
