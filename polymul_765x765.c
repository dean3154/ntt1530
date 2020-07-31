#include <stdint.h>

extern void fft17(void* f, void* fpad);
extern void fft9(void* fpad);
extern void polymul_10x10_153(void* fpad, void* gpad);
extern void ifft9(void* fpad);
extern void ifft17(void* fpad, void* h);
// input  : int16_t f[765], int16_t g[765]
// output : int16_t h[1530], h[0]~h[1528] = f * g, h[1529] = 0
void polymul_765x765(int16_t* h, int16_t* f, int16_t* g){
    int16_t fpad[1530], gpad[1530];
    fft17(f, fpad);
    fft9(fpad);
    fft17(g, gpad);
    fft9(gpad);
    polymul_10x10_153(fpad, gpad);
    ifft9(fpad);
    ifft17(fpad, h);
}