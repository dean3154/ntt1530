#include <stdint.h>

extern void fft17(void* f, void* fpad);
extern void fft17_byte(void* g, void* gpad);
extern void fft9(void* fpad);
extern void polymul_10x10_153(void* fpad, void* gpad);
extern void polymul_10x10_153_mr(void* fpad, void* gpad);
extern void ifft9(void* fpad);
extern void ifft17(void* fpad, void* h);
extern void ifft17_mr(void* fpad, void* h);
extern void mod_reduce(void* h, void* hpad);
// input  : int16_t f[761], int8_t g[761]
// output  : int16_t h[761]
// h = f * g mod x^761 -x -1 mod 4591
void polymul_761x761_modp(int16_t* h, int16_t* f, int8_t* g){
    int16_t fpad[1530], gpad[1530];
    fft17(f, fpad);
    fft9(fpad);
    fft17_byte(g, gpad);
    fft9(gpad);
    // polymul_10x10_153(fpad, gpad);
    polymul_10x10_153_mr(fpad, gpad);
    ifft9(fpad);
    // ifft17(fpad, gpad);
    ifft17_mr(fpad, gpad);
    mod_reduce(h, gpad);
}