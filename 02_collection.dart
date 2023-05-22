//集合 https://dart.cn/guides/libraries/library-tour#collections
void main() {
  list_sample();
  set_sample();
  map_sample();
  public_collection_methods();
  print('done');
}

//===========List 列表===========
void list_sample() {
  //Create an empty list of strings.
  var grains = <String>[];
  assert(grains.isEmpty);

  //Creat a list using a list literal.通过字面量来创建和初始化
  var fruits = ['apples', 'oranges'];
  fruits.add('kiwis'); //Add to a list.
  fruits.addAll(['grapes', 'bananas']); //Add multiple items to a list.

  assert(fruits.length == 5); //Get the list length

  //Remove a single item
  var appleIndex = fruits.indexOf('apples');
  fruits.removeAt(appleIndex);
  assert(fruits.length == 4);

  //Remove all elements from a list
  fruits.clear();
  assert(fruits.isEmpty);

  //You can also creat a List using one of the constructors
  var vegetables = List.filled(99, 'broccoli');
  assert(vegetables.every((v) => v == 'broccoli'));

  fruits = ['apples', 'oranges'];
  //Access a list item by index
  assert(fruits[0] == 'apples');

  // Find an item in a list
  assert(fruits.indexOf('apples') == 0);

  //使用 sort() 方法排序一个 list 。你可以提供一个排序函数用于比较两个对象。
  //比较函数在 小于 时返回 \ <0，相等 时返回 0，bigger 时返回 > 0
  //下面示例中使用 compareTo() 函数，该函数在 Comparable 中定义，并被 String 类实现
  var fruit2 = ['bananas', 'apples', 'oranges'];

  //Sort a list
  fruit2.sort((a, b) => a.compareTo(b));
  assert(fruit2[0] == 'apples');

  //列表是参数化类型（泛型），因此可以指定 list 应该包含的元素类型：
  //This list should contain only strings
  var fruits3 = <String>[];

  fruits3.add('apples');
  var fruit = fruits3[0];
  assert(fruit is String);
}

//=========set 无序的。元素唯一的=======
void set_sample() {
  var ingredients = <String>{};

  //Add new items to it
  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.length == 3);

  //Adding a duplicate item has no effect
  ingredients.add('gold');
  assert(ingredients.length == 3);

  ingredients.remove('gold');
  assert(ingredients.length == 2);

  //You can also create sets using one of the constructors
  var atomicNumbers = Set.from([79, 22, 54]);

  // 使用 contains() 和 containsAll() 来检查一个或多个元素是否在 set 中：
  assert(ingredients.contains('titanium'));
  assert(ingredients.containsAll(['titanium', 'xenon']));

  // Create the intersection of two sets. 交集
  var nobleGases = Set.from(['xenon', 'argon']);
  var intersection = ingredients.intersection(nobleGases);
  assert(intersection.length == 1);
  assert(intersection.contains('xenon'));
}

//=========Maps  无序的 key-value （键值对）集合========
void map_sample() {
  //Maps often use strings as keys.
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  // Maps can be built from a constructor.
  var searchTerms = Map();

  // Maps are parameterized types; you can specify what
  // types the key and value should be.
  var nobleGases1 = Map<int, String>();

  //通过大括号语法可以为 map 添加，获取，设置元素。使用 remove() 方法从 map 中移除键值对
  nobleGases1 = {54: 'xenon'};

  // Retrieve a value with a key.
  assert(nobleGases1[54] == 'xenon');

  // Check whether a map contains a key.
  assert(nobleGases1.containsKey(54));

  // Remove a key and its value.
  nobleGases1.remove(54);
  assert(!nobleGases1.containsKey(54));

  //Get all the keys as an unordered collection(an Iterable)
  var keys = hawaiianBeaches.keys;
  assert(keys.length == 3);
  assert(Set.from(keys).contains('Oahu'));

  //Get all the values as an unordered collection(an Iterable of Lists)
  var values = hawaiianBeaches.values;
  assert(values.length == 3);
  assert(values.any((v) => v.contains('Waikiki')));

  //使用 containsKey() 方法检查一个 map 中是否包含某个key 。因为 map 中的 value 可能会是 null ，
  //所有通过 key 获取 value，并通过判断 value 是否为 null 来判断 key 是否存在是不可靠的。
  assert(hawaiianBeaches.containsKey('Oahu'));
  assert(!hawaiianBeaches.containsKey('Florida'));

  //如果当且仅当该 key 不存在于 map 中，且要为这个 key 赋值，可使用
  //putIfAbsent() 方法。该方法需要一个方法返回这个 value
  var teamAssignments = <String, String>{};
  String pickToughestKid() {
    return "pickToughestKid";
  }
  teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());
  assert(teamAssignments['Catcher'] != null);
}

//========公共集合方法=========
//List, Set, 和 Map 共享许多集合中的常用功能。其中一些常见功能由 Iterable 类定义，这些函数由 List 和 Set 实现
void public_collection_methods() {
  //isEmpty 和 isNotEmpty检查 list， set 或 map 对象中是否包含元素 
  var coffees = <String>[];
  var teas = ['green', 'black', 'chamomile', 'earl grey'];
  assert(coffees.isEmpty);
  assert(teas.isNotEmpty);

  //使用 forEach() 可以让 list， set 或 map 对象中的每个元素都使用一个方法
  teas.forEach((tea) => print('I drink $tea'));

  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  //当在 map 对象上调用 `forEach() 方法时，函数必须带两个参数（key 和 value)
  hawaiianBeaches.forEach((k, v) {
    print('I want to visit $k and swim at $v');
    // I want to visit Oahu and swim at
    // [Waikiki, kailua, Waimanalo], etc.
  });

  //Iterable 提供 map() 方法，这个方法将所有结果返回到一个对象中
  var loudTeas = teas.map((tea) => tea.toUpperCase());
  loudTeas.forEach(print);

  //使用 map().toList() 或 map().toSet() ，可以强制在每个项目上立即调用函数
  loudTeas = teas.map((tea) => tea.toUpperCase()).toList();

  // Chamomile is not caffeinated
  bool isDecaffeinated(String teaName) => teaName == 'chamomile';

  //用 Iterable 的 where() 方法可以获取所有匹配条件的元素
  var decaffeinatedTeas = teas.where((tea) => isDecaffeinated(tea));
  //or teas.where(isDecaffeinated)

  //使用 Iterable 的 any() 和 every() 方法可以检查部分或者所有元素是否匹配某个条件

  //Use any() to check whether at least one item in the
  //collection satisfies a condition.
  assert(teas.any(isDecaffeinated));

  //Use every() to check whether all the items in a
  //collection satisfy a condition.
  assert(!teas.every(isDecaffeinated));
}