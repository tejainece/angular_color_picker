import 'package:angular_color_picker/angular_color_picker.dart';
import 'package:lib_colors/lib_colors.dart';
import 'package:angular/angular.dart';
import 'main.template.dart' as ng;

@Component(
  selector: 'my-app',
  styles: [
    ':host {display: block; width: 250px; height: 100%; padding: 0px 5px; box-sizing: border-box;}',
  ],
  template:
      r'<awesome-color-picker [value]="color" (change)="color = $event"></awesome-color-picker>',
  directives: [AwesomeColorPicker],
)
class AppComponent {
  Color color = white;
}

void main() {
  runApp(ng.AppComponentNgFactory);
}
