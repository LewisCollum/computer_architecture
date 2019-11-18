/*
  Semester: Fall 2019
  Course: EE 466 - Computer Architecture
  Project: Fibonacci Series
  
  Author: Lewis Collum
  Student #: 0621539
  Major: EE/CE
  Email: colluml@clarkson.edu
  
  Report Due: October 28, 2019
*/

#define UART_BASE 0x09000000
#include <stdio.h>

extern void fibonacci(int n, unsigned long long* series);
static void fibonacciBounded(int n, unsigned long long* series);
static void print(const char * string);
static void printArrayWithSize(unsigned long long* const array, int size);
static void itoa(unsigned int n, char* const buffer);

void main() {
  int n = 20;
  unsigned long long series[n];
  fibonacciBounded(n, series);
  printArrayWithSize(series, n);
  while(1);
}

void fibonacciBounded(int n, unsigned long long* series) {
  n < 1? print("ERROR: n must be larger than 0."): fibonacci(n, series);
}

void printArrayWithSize(unsigned long long* const array, int size) {
  for (int i = 0; i < size; ++i) {
    char buffer[10];
    itoa(array[i], buffer);
    print(buffer);
    if (i != size-1) print(", ");
  }
  print("\n");
}

void print(const char* string) {
  while (*string)
    *((unsigned int*) UART_BASE) = *string++;
}

void itoa(unsigned int n, char* const buffer) {
  if (n == 0) {
    buffer[0] = '0';
    buffer[1] = '\0';
    return;
  }

  int size = 1;
  int nCopy = n;

  while (nCopy != 0) {
    nCopy /= 10;
    ++size;
  }

  for (int i = size-2; i >= 0; --i) {
    buffer[i] = n % 10 + '0';
    n /= 10;
  }

  buffer[size-1] = '\0';
}
