// 工具类 https://dart.cn/guides/libraries/library-tour#utility-classes
// 异常 https://dart.cn/guides/libraries/library-tour#exceptions
void main() {
  compare_sample();
  hash_samplpe();
  handleFooException_sample();
  interable_sample();
  print('have done');
}

//核心库包含各种工具类，可用于排序，映射值以及迭代。

//=========比较对象=========
// 如果实现了 Comparable 接口，也就是说可以将该对象与另一个对象进行比较，通常用于排序
class Line implements Comparable<Line> {
  final int length;
  const Line(this.length);

  @override
  //compareTo() 方法在 小于 时返回 < 0，在 相等 时返回 0，在 大于 时返回 > 0
  int compareTo(Line other) => length - other.length;
} 

void compare_sample() {
  var short = const Line(1);
  var long = const Line(100);
  assert(short.compareTo(long) < 0);
}

//=============Implementing map keys =============(
//在 Dart 中每个对象会默认提供一个整数的哈希值，因此在 map 中可以作为 key 来使用，
//重写 hashCode 的 getter 方法来生成自定义哈希值。如果重写 hashCode 的 getter 方法，那么可能还需要重写 == 运算符。
//相等的（通过 == ）对象必须拥有相同的哈希值。哈希值并不要求是唯一的，但是应该具有良好的分布形态。)
class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);

  // Override hashCode using the static hashing methods
  // provided by the `Object` class.
  @override
  int get hashCode => Object.hash(firstName, lastName);

  // You should generally implement operator `==` if you
  // override `hashCode`.
  @override
  bool operator ==(Object other) {
    return other is Person &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }
}

void hash_samplpe() {
  var p1 = Person('Bob', 'Smith');
  var p2 = Person('Bob', 'Smith');
  var p3 = 'not a person';
  assert(p1.hashCode == p2.hashCode);
  assert(p1 == p2);
  assert(p1 != p3);
}

//===========迭代===============
//Iterable 和 Iterator 类支持 for-in 循环。当创建一个类的时候，继承或者实
//现 Iterable，可以为该类提供用于 for-in 循环的 Iterators。
//实现 Iterator 来定义实际的遍历操作。
void interable_sample() {
  var kidsBooks = {
    'Matilda': 'Roald Dahl',
    'Green Eggs and Ham': 'Dr Seuss',
    'Where the Wild Things Are': 'Maurice Sendak'
  };
  for (var book in kidsBooks.keys) {
    print('$book was written by ${kidsBooks[book]}');
  }
}

/*
class Process {
  // Represents a process...
}

class ProcessIterator implements Iterator<Process> {
  @override
  Process get current => ...
  @override
  bool moveNext() => ...
}

// A mythical class that lets you iterate through all
// processes. Extends a subclass of [Iterable].
class Processes extends IterableBase<Process> {
  @override
  final Iterator<Process> iterator = ProcessIterator();
}

void main() {
  // Iterable objects can be used with for-in.
  for (final process in Processes()) {
    // Do something with the process.
  }
}
*/

// 异常 https://dart.cn/guides/libraries/library-tour#exceptions
// 两个最常见的错误：NoSuchMethodError 当方法的接受对象（可能为null）没有实现该方法时抛出
// ArgumentError 当方法在接受到一个不合法参数时抛出
// 通过抛出一个应用特定的异常，来表示应用发生了错误。

//通过实现 Exception 接口来自定义异常:定义一个自定义异常FooException
class FooException implements Exception {
  final String? msg;

  const FooException([this.msg]);

  @override
  String toString() => msg ?? 'FooException';
}

void testFoo(int x) {
  if (x < 0) {
    //throw关键字用来明确地抛出异常，
    throw new FooException();
  }
}

void handleFooException_sample() {
  //应该处理引发的异常，以防程序突然退出
  try {
    testFoo(-1);
  } catch (e) {
    print(e.toString());
  }
}



