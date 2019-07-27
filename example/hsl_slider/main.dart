import 'package:lib_colors/lib_colors.dart';
import 'package:angular/angular.dart';
import 'main.template.dart' as ng;

import 'package:angular_color_picker/angular_color_picker.dart';

@Component(
  selector: 'my-app',
  styles: [
    ':host {display: block; width: 250px; height: 100%; padding: 0px 5px; box-sizing: border-box;}',
  ],
  template:
      r'<hsl-slider [value]="color" (change)="color = $event"></hsl-slider>',
  directives: [HslSlider],
)
class AppComponent {
  Color color = white;
}

void main() {
  runApp(ng.AppComponentNgFactory);
}
