import 'dart:async';

import 'package:angular/angular.dart';

import 'package:lib_colors/lib_colors.dart';
import 'package:ng_bind/ng_bind.dart';

@Component(
  selector: 'color-text',
  styleUrls: ['color_text.css'],
  templateUrl: 'color_text.html',
  directives: [
    NgIf,
    TextBinder,
  ],
  providers: [],
)
class ColorText implements OnInit {
  @Input()
  set value(Color color) {
    _value = color.clone();
    _updateText();
  }

  Color _value = white;

  Color get value => _value;

  String text;

  @HostBinding('style.color')
  String get fontColor => (value.isDark && value.a > 0.3) ? 'white' : 'black';

  void _updateText() {
    switch (tab) {
      case 0:
        text = value.hex();
        break;
      case 1:
        text = value.toRgb.css;
        break;
      case 2:
        text = value.toHsl.css;
        break;
    }
  }

  int _tab = 0;

  set tab(int v) {
    _tab = v;
    _updateText();
  }

  int get tab => _tab;

  ColorText() {
    _updateText();
  }

  @override
  void ngOnInit() {
    _updateText();
  }

  void textChanged(String v) {
    try {
      Color newColor = Color.parse(v);
      _changeEmitter.add(newColor);
    } catch (e) {
      // TODO
    }
  }

  final _changeEmitter = StreamController<Color>();

  @Output()
  Stream<Color> get change => _changeEmitter.stream;
}
