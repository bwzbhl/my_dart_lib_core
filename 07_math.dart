//数学和随机数 https://dart.cn/guides/libraries/library-tour#dartmath---math-and-random
import 'dart:math';

void main() {
  trigonometry_sample();
  minmax_sample();
  constant_sample();
  random_sample();
  print('Done');
}

//三角函数 https://dart.cn/guides/libraries/library-tour#trigonometry
void trigonometry_sample() {
  //  !!!!这些函数参数单位是弧度，不是角度！
  // Cosine
  assert(cos(pi) == -1.0);

  // Sine
  var degrees = 30;
  var radians = degrees * (pi / 180);
  // radians is now 0.52359.
  var sinOf30degrees = sin(radians);
  // sin 30° = 0.5
  assert((sinOf30degrees - 0.5).abs() < 0.01);
}

//最大值和最小值 https://dart.cn/guides/libraries/library-tour#maximum-and-minimum
void minmax_sample() {
  assert(max(1, 1000) == 1000);
  assert(min(1, -1000) == -1000);
}

//数学常数 https://dart.cn/guides/libraries/library-tour#math-constants
void constant_sample() {
  // See the Math library for additional constants.
  print(e); // 2.718281828459045
  print(pi); // 3.141592653589793
  print(sqrt2); // 1.4142135623730951
}

//随机数 https://dart.cn/guides/libraries/library-tour#random-numbers
void random_sample() {
  var random = Random();
  print(random.nextDouble()); // Between 0.0 and 1.0: [0, 1)
  print(random.nextInt(10)); // Between 0 and 9.

  random = Random();
  print(random.nextBool()); // true or false
}