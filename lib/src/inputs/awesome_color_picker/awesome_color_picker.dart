import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_color_picker/angular_color_picker.dart';
import 'package:angular_color_picker/src/controls/color_text/color_text.dart';

import 'package:lib_colors/lib_colors.dart';

@Component(
  selector: 'awesome-color-picker',
  styleUrls: ['awesome_color_picker.css'],
  templateUrl: 'awesome_color_picker.html',
  directives: [
    NgFor,
    NgIf,
    ColorText,
    RgbSlider,
    HslSlider,
  ],
  providers: [],
)
class AwesomeColorPicker {
  @Input()
  set value(color) {
    if(color is String) color = Color.parse(color);
    _value = color.clone();
  }

  Color _value = white;

  Color get value => _value;

  int tab = 0;

  void valueChanged(Color value) {
    _changeEmitter.add(value);
  }

  final _changeEmitter = StreamController<Color>();

  @Output()
  Stream<Color> get change => _changeEmitter.stream;
}
