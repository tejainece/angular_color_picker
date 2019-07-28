import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_color_picker/angular_color_picker.dart';

import 'package:lib_colors/lib_colors.dart';
import 'package:ng_bind/ng_bind.dart';

@Component(
  selector: 'awesome-color-picker',
  styleUrls: ['awesome_color_picker.css'],
  templateUrl: 'awesome_color_picker.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
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

  Rgb _value = white;

  Rgb get value => _value;

  final _changeEmitter = StreamController<Rgb>();

  @Output()
  Stream<Rgb> get change => _changeEmitter.stream;
}