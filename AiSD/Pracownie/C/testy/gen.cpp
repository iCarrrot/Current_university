#include <cstdio>
#include <ctime>
#include <cstdlib>

int main(int argc, char ** argv) {
	if (argc < 7) {
		printf("usage: %s <tests> <prod1size> <nts> <prod2size> <ts> <n>\n", argv[0]);
		return 1;
	}
	
	int tests = atoi(argv[1]);
	int prod1size = atoi(argv[2]);
	int nts = atoi(argv[3]); // non terminal size
	int prod2size = atoi(argv[4]);
	int ts = atoi(argv[5]); // terminal size
	int n = atoi(argv[6]); // word size
	
	srand(time(0));
	
	printf("%d\n", tests);
	while (tests--) {
		printf("%d %d\n", prod1size, prod2size);
		for (int i = 0; i < prod1size; i++)
			printf("%c %c %c\n", rand() % nts + 'A', rand() % nts + 'A', rand() % nts + 'A');
	
		for (int i = 0; i < prod2size; i++)
			printf("%c %c\n", rand() % nts + 'A', rand() % ts + 'a');
	
		for (int i = 0; i < n; i++)
			printf("%c", rand() % ts + 'a');
	
		printf("\n");
	}
	
	return 0;
}
