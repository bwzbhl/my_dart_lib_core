//字符和正则表达式 
//https://dart.cn/guides/libraries/library-tour#strings-and-regular-expressions
void main() {
  str_reg();
  print('done');
}

void str_reg() {
  //检查一个字符串是否包含另一个字符串
  assert('Never add or even'.contains('add'));

  //检查字符串是否以特定字符串作为开头或结尾
  assert('Never add or even'.startsWith('Never'));
  assert('Never add or even'.endsWith('even'));

  //在字符串内查找特定字符串的位置
  assert('Never add or even'.indexOf('add') == 6);

  //Grab a substring.
  assert('Never add or even'.substring(6, 9) == 'add');

  //Split a string using a string pattern
  var parts = 'prograssive web apps'.split(' ');
  assert(parts.length == 3);
  assert(parts[0] == 'prograssive');

  //Get a UTF-16 code unit (as  a string) by index.
  assert('Never add or even'[0] == 'N');

  //Use split() with an empty string parameter to get
  //a list of all characters(as Strings);
  //good for iterating(迭代)
  for (final char in 'hello'.split('')) {
    print(char);
  }

  //Get all the UTF-16 code units in the string.
  var codeUnitList = 'Never add or even'.codeUnits.toList();
  assert(codeUnitList[0] == 78);

  //首字母？大小写转换
  assert('web apps'.toUpperCase() == 'WEB APPS');
  assert('WEB APPS'.toLowerCase() == 'web apps');

  //使用 trim() 移除首尾空格。使用 isEmpty 检查一个字符串是否为空（长度为 0）
  assert('  hello  '.trim() == 'hello');
  assert(''.isEmpty);
  assert('  '.isNotEmpty);

  //替换部分字符串  方法 replaceAll() 返回一个新字符串，并没有改变原始字符串
  var greetingTemplate = 'Hello, NAME!';
  var greeting = greetingTemplate.replaceAll(RegExp('NAME'), 'Bob');
  //greetingTemplate didn't change
  assert(greeting != greetingTemplate);

  //构建一个字符串:
  //要以代码方式生成字符串，可以使用 StringBuffer。在调用 toString() 之前， StringBuffer 不会生成新字符串对象。
  //writeAll() 的第二个参数为可选参数，用来指定分隔符，本例中使用空格作为分隔符。
  var sb = StringBuffer();
  sb
    ..write('Use a StringBuffer for ')
    ..writeAll(['efficient', 'string', 'creation'], ' ')
    ..write('.');

  var fullString = sb.toString();

  assert(fullString == 'Use a StringBuffer for efficient string creation.');

  //正则表达式 :
  //RegExp 类提供与 JavaScript 正则表达式相同的功能。使用正则表达式可以对字符串进行高效搜索和模式匹配
  //Here's a regular expression for one or more digits.
  var numbers = RegExp(r'\d+');

  var allCharacters = 'llamas live fifteen to twenty years';
  var someDigits = 'llamas live 15 to 20 years';

  //contains() can use a regular expression.
  assert(!allCharacters.contains(numbers));
  assert(someDigits.contains(numbers));

  //You can work directly with the RegExp class, too.
  //The Match class provides access to a regular expression match.

  //Check whether the reg exp has a match in a string.
  assert(numbers.hasMatch(someDigits));

  //Loop through all matches.
  for (final match in numbers.allMatches(someDigits)) {
    print(match.group(0)); //15, then 50
  }
}