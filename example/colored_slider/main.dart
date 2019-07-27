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
      '<colored-slider [painter]="redPaint" (change)="redChanged" [value]="rgb.r/255" [renderOn]="rgb"></colored-slider>'
      '<colored-slider [painter]="greenPaint" (change)="greenChanged" [value]="rgb.g/255" [renderOn]="rgb"></colored-slider>'
      '<colored-slider [painter]="bluePaint" (change)="blueChanged" [value]="rgb.b/255" [renderOn]="rgb"></colored-slider>',
  directives: [ColoredSlider],
)
class AppComponent {
  Painter redPaint;
  Painter greenPaint;
  Painter bluePaint;

  Rgb rgb = white;

  AppComponent() {
    _updatePainters();
  }

  void _updatePainters() {
    redPaint = redPainter(rgb);
    greenPaint = greenPainter(rgb);
    bluePaint = bluePainter(rgb);
  }

  void redChanged(double v) {
    rgb = rgb.clone(r: (v * 255).toInt());
    _updatePainters();
  }

  void greenChanged(double v) {
    rgb = rgb.clone(g: (v * 255).toInt());
    _updatePainters();
  }

  void blueChanged(double v) {
    rgb = rgb.clone(b: (v * 255).toInt());
    _updatePainters();
  }
}

void main() {
  runApp(ng.AppComponentNgFactory);
}
