#include <stdio.h>

extern long long int mysum(long long int n);

int main() {
	int willContinue = 1;
	while(willContinue) {
		int n;
		printf("Input (n): ");
		scanf("%d", &n);

		if (n >= 1) {
			printf("%d\nContinue? (1/0): ", mysum(n));
			scanf("%d", &willContinue);
		} else {
			printf("n must be larger than or equal to 1.\n");
		}
	}
	return 0;
}
