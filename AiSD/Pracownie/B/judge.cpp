#include <cstdio>

#include <themis/judge.h>
/* podpina:
 * FILE *input --- plik .in
 *      *correct --- plik .out
 *      *answer --- odpowiedź użytkownika
 */

#define FAIL 42
#define SUCCESS 0

const int SIZE = 1000000;
char inp[SIZE][3];
char usr[SIZE][3];
int n;

inline bool legal(int x, int y) {
	return x >= 0 && x < n && y >= 0 && y < 3;
}

int dx[] = {-1, -2, -2, -1, 1, 2, 2, 1};
int dy[] = {-2, -1, 1, 2, 2, 1, -1, -2};

int main() {
	int correctAns;
	fscanf(correct, "%d", &correctAns);

	int userAns;
	fscanf(answer, "%d ", &userAns);
	
	if (correctAns != userAns) {
		return FAIL;
	}
	
	fscanf(input, "%d ", &n);
	
	for (int i = 0; i < n; i++)
		fscanf(input, "%c%c%c ", &inp[i][0], &inp[i][1], &inp[i][2]);

	int usrCnt = 0;	
	for (int i = 0; i < n; i++) {
		fscanf(answer, "%c%c%c ", &usr[i][0], &usr[i][1], &usr[i][2]);
		for (int j = 0; j < 3; j++) {
			if (usr[i][j] == 'x') {
				if (inp[i][j] != 'x')
					return FAIL;
			} else if (usr[i][j] == '.') {
				if (inp[i][j] != '.')
					return FAIL;
			} else if (usr[i][j] == 'S') {
				if (inp[i][j] != '.')
					return FAIL;
				else
					usrCnt++;
			} else 
				return FAIL;
		}	
	}

	if (usrCnt != userAns)
		return FAIL;
	
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < 3; j++) {
			if (usr[i][j] != 'S')
				continue;
				
			for (int k = 0; k < 8; k++) {
				int ip = i + dx[k];
				int jp = j + dy[k];
				if (legal(ip, jp) && usr[ip][jp] == 'S')
					return FAIL;
			}
		}
	}

	return SUCCESS;
}
