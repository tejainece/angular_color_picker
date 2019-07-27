import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:lib_colors/lib_colors.dart';

@Component(
  selector: 'colored-slider',
  styleUrls: ['colored_slider.css'],
  templateUrl: 'colored_slider.html',
  directives: [
    NgFor,
    NgIf,
  ],
  providers: [],
)
class ColoredSlider implements AfterViewInit {
  final _renderer = _Renderer();

  @Input()
  set painter(Painter painter) {
    _renderer.painter = painter;
  }

  @Input()
  set renderOn(_) {
    _renderer.render();
  }

  double _value = 0;

  @Input()
  set value(num v) => _value = v.toDouble();

  double get value => _value;

  final _changeEmitter = StreamController<double>();

  @Output()
  Stream<double> get change => _changeEmitter.stream;

  @ViewChild('canvas')
  CanvasElement canvas;

  ColoredSlider();

  @override
  void ngAfterViewInit() {
    _renderer.onCanvas(canvas);
    _renderer.render();
  }

  _PickingState _picking;

  void _endPicking() async {
    if(_picking == null) return;

    final picking = _picking;
    _picking = null;
    await picking.release();
  }

  void start(MouseEvent event) {
    _endPicking();

    _picking = _PickingState();
    _picking.addSubs(document.onMouseUp.listen((MouseEvent event1) {
      _endPicking();
    }));
    _picking.addSubs(document.onMouseLeave.listen((MouseEvent event1) {
      _endPicking();
    }));
    clicked(event);
  }

  void clicked(MouseEvent event) {
    if (_picking != null) {
      int width = (event.target as Element).offsetWidth;
      _changeEmitter.add(event.offset.x / width);
    }
  }

  void end(MouseEvent event) {
    clicked(event);
    _endPicking();
  }
}

class _PickingState {
  final subs = <StreamSubscription>[];

  void addSubs(StreamSubscription sub) => subs.add(sub);

  void release() async {
    while (subs.isNotEmpty) {
      await subs.removeLast().cancel();
    }
  }
}

typedef Painter = Color Function(double x);

class _Renderer {
  CanvasElement canvas;
  CanvasRenderingContext2D context;

  Painter painter;

  void onCanvas(CanvasElement c) {
    canvas = c;
    context = canvas.getContext('2d');
  }

  void render() {
    if (canvas == null) return;

    ImageData image = context.createImageData(canvas.width, canvas.height);
    final width = image.width;
    final height = image.height;
    final buffer = image.data;

    double delta = 1 / (width - 1);

    for (int i = 0; i < width; i++) {
      final color = painter(i * delta).toRgb;

      for (int j = 0; j < height; j++) {
        final start = (j * (width * 4)) + (i * 4);
        buffer[start] = color.r;
        buffer[start + 1] = color.g;
        buffer[start + 2] = color.b;
        buffer[start + 3] = (color.a * 255).toInt();
      }
    }

    context.putImageData(image, 0, 0);
  }
}
