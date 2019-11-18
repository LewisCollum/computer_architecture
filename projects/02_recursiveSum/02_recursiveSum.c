/*
  EE 466 Computer Architecture
  Fall 2019
  Instructor: Dr. Chen Liu
  Project 2: Recursive Calls
  Name: Lewis Collum
  Student ID: 0621539
  Major: EE & CE
  Email Address: colluml@clarkson.edu
  Date of the report: November 19, 2019
*/

#include <stdio.h>

extern long long int mysum(long long int n);

int main() {
  int willContinue = 1;
  while(willContinue) {
    // get user input for parameter n.
    int n;
    printf("Input (n): ");
    scanf("%d", &n);

    if (n >= 1) {
      // print result. Then ask if user wants to continue.
      printf("%d\nContinue? (1/0): ", mysum(n));
      scanf("%d", &willContinue);
    } else {
      printf("n must be larger than or equal to 1.\n");
    }
  }
  return 0;
}
