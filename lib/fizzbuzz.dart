String fizzbuzz (int min, int max){
  String fizz = 'Fizz';
  String buzz = 'Buzz';
  String result= '';

  for (int number = min; number <= max; number ++) {

    result += number % 15 == 0 ? fizz + buzz + ' '
            : number % 3 == 0 ? fizz + ' '
            : number % 5 == 0 ? buzz + ' '
            : number.toString() + ' ';
  }
  return result;
}