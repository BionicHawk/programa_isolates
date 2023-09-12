import 'dart:isolate';
import 'dart:async';
import 'dart:math';

const int iterations = 10000;
const int numberOfIsolates = 5;
const int eachIso = iterations ~/ numberOfIsolates;

int sumatory = 0;

//  Punto de entrada del programa
void main() async {
  List<int> sums = [];

  // Generando los isolates con la parte de la sumatoria cada uno
  for (int i = 0; i < numberOfIsolates; i++) {
    sums.add(await Isolate.run(getSum));
  }

  // Variable que almacena el promedio de la sumatoria
  int average = 0;

  // Una vez que se obtengan los valores de las sumatorias se hara una sumatoria unica
  for (var sum in sums) {
    sumatory += sum;
  }

  // Se calcula el promedio con una división entera
  average = sumatory ~/ iterations;

  print("The average of the $iterations numbers generated is: $average");
}

/* Genera una parte de la promesa usando un Future que dara el resultado de una
   parte de la sumatoria en algún momento de la ejecución del programa */
Future<int> getSum() async {
  int sum = 0;

  for (int i = 0; i < eachIso; i++) {
    sum += Random().nextInt(1000);
  }

  return sum;
}
