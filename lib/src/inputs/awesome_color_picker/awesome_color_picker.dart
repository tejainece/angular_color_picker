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
  set value(Color color) {
    _value = color.clone();
  }

  Color _value = white;

  Color get value => _value;

  int tab = 0;

  final _changeEmitter = StreamController<Color>();

  @Output()
  Stream<Color> get change => _changeEmitter.stream;
}