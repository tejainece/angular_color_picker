import 'package:lib_colors/lib_colors.dart';
import 'package:angular/angular.dart';
import 'main.template.dart' as ng;

import 'package:angular_color_picker/angular_color_picker.dart';

@Component(
  selector: 'my-app',
  styles: [
    ':host {display: block; width: 100%; height: 100%; padding: 0px 5px; box-sizing: border-box;}',
  ],
  template:
      r'<rgb-slider [value]="color" (change)="color = $event"></rgb-slider>',
  directives: [RgbSlider],
)
class AppComponent {
  Color color = white;
}

void main() {
  runApp(ng.AppComponentNgFactory);
}
