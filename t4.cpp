#include <iostream>

using namespace std;

int multiply(int a, int b){
    int acumula = 0;
    int vezes = b;

    // se B é negativo, troca o sinal
    if(b < 0)
    vezes = 0 - vezes;

    // acumula A, B vezes
    while(vezes!=0){
    acumula = acumula + a;
    vezes = vezes - 1;
    }

    // se B é negativo, trocamos o sinal do resultado
    if(b < 0)
    acumula = 0 - acumula;
    return acumula;
}

int main() {
    // Definindo os vetores A e B
    int A[] = {10, -2, 3, -5, 12, 6, -7, 8}; 
    int B[] = {11, -3, 5, 22, -4, 9, -8, 19}; 

    // Tamanho dos vetores
    int n = 8; 

    // Inicializando os vetores C e D
    int C[n] = {};
    int D[n] = {};

    //inicializando variavéis
    int max = C[0];
    int SM = 0;

    // Calculando os vetores C e D
    for (int i = 0; i < n; ++i) {
        C[i] = A[i] + B[i];
        D[i] = A[i] - B[i]; 
      
    }

    // verificando o valor máximo entre os elementos de C e D
    for(int i = 0; i < n; i++){
        if(C[i] > max)
            max = C[i];

        if(D[i] > max)
            max = D[i];
    }

    // Calculando o somatório dos elementos de C e D
    for(int i = 0; i < n; i++){
        SM += C[i] + D[i];
    }

    //calculo final 
    SM = multiply(SM, max);


    // Imprimindo os resultados (nao sera traduzido para assembly)
    cout << "C = {";
    for (int i = 0; i < n; ++i) {
        cout << C[i];
        if (i < n - 1) {
            cout << ", ";
        }
    }
    cout << "}\n";

    cout << "D = {";
    for (int i = 0; i < n; ++i) {
        cout << D[i];
        if (i < n - 1) {
            cout << ", ";
        }
    }
    cout << "}\n";

    cout << "max:" << max << endl;
    cout << "SM = " << SM << "\n";

    return 0;
}
