.p2align 2,,3
.syntax unified

.data
buffer: .space 128

.text
buffer_bridge:
    .word buffer
wpad:
    .word 935519
    .word 40500057
    .word 86900888
    .word 61146163
    .word 4158194321
    .word 28375972
    .word 25823139
    .word 4251253512
    .word 4220778258

.global ntt17_rader_byte
.type ntt17_rader_byte, %function
ntt17_rader_byte:
@ ntt17_rader_byte(int8_t* f, int16_t* fpad
    push {r2-r12, lr}
    vpush {s16-s20}
    add.w r2, r0, #40
    add.w r3, r0, #88
    ldr.w lr, buffer_bridge
    adr r4, wpad
    vldm r4, {s4-s12}
    @ s0 for input address
    vmov s1, r1 @ output address
    vmov s2, r2 @ loop1 end
    vmov s3, r3 @ loop2 end
    vmov s20, lr
ntt17_rader_byte_body1:
    ldr.w r1, [r0, #540]
    ldr.w r2, [r0, #180]
    ldr.w r3, [r0, #450]
    ldr.w r4, [r0, #360]
    ldr.w r5, [r0, #630]
    ldr.w r6, [r0, #720]
    ldr.w r7, [r0, #270]
    ldr.w r8, [r0, #90]
    ldr.w r9, [r0], #4
    sbfx r10, r9, #0, #8 @ a0
    sbfx r11, r9, #8, #8 @ a1
    pkhbt r10, r10, r11, lsl #16 @ a0a1
    sbfx r11, r9, #16, #8 @ a2
    sbfx r12, r9, #24, #8 @ a3
    pkhbt r11, r11, r12, lsl #16 @ a2a3
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    sadd8 r9, r9, r6
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8 @ b0b1b2b3
    vmov s0, r0
    vmov s13, r10
    vmov s14, r11
    vmov s19, r9
    sbfx r9, r7, #0, #8
    sbfx r10, r8, #0, #8
    pkhbt r9, r9, r10, lsl #16 @ a3a1 : 1
    sbfx r10, r7, #8, #8
    sbfx r11, r8, #8, #8
    pkhbt r10, r10, r11, lsl #16 @ a3a1 : 2
    sbfx r11, r7, #16, #8
    sbfx r12, r8, #16, #8
    pkhbt r11, r11, r12, lsl #16 @ a3a1 : 3
    sbfx r12, r7, #24, #8
    sbfx r0, r8, #24, #8
    pkhbt r12, r12, r0, lsl #16 @ a3a1 : 4
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    str.w r11, [lr, #92]
    str.w r12, [lr, #124]
    mov.w r0, #0
    ssub8 r0, r0, r4 @ -a4
    sbfx r7, r0, #0, #8 @ -a4 : 1
    sbfx r8, r0, #8, #8 @ -a4 : 2
    sbfx r9, r0, #16, #8 @ -a4 : 3
    sbfx r10, r0, #24, #8 @ -a4 : 4
    sbfx r11, r3, #0, #8 @ a5 : 1
    sbfx r12, r3, #8, #8 @ a5 : 2
    pkhbt r7, r11, r7, lsl #16 @ a5 -a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 -a4 : 2
    sbfx r0, r3, #16, #8 @ a5 : 3
    sbfx r3, r3, #24, #8 @ a5 : 4
    pkhbt r9, r0, r9, lsl #16 @ a5 -a4 : 3
    pkhbt r10, r3, r10, lsl #16 @ a5 -a4 : 4
    str.w r7, [lr, #20]
    str.w r8, [lr, #52]
    str.w r9, [lr, #84]
    str.w r10, [lr, #116]
    sbfx r7, r4, #0, #8 @ a4 : 1
    sbfx r8, r4, #8, #8 @ a4 : 2
    sbfx r9, r4, #16, #8 @ a4 : 3
    sbfx r10, r4, #24, #8 @ a4 : 4
    pkhbt r7, r11, r7, lsl #16 @ a5 a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 a4 : 2
    pkhbt r9, r0, r9, lsl #16 @ a5 a4 : 3
    pkhbt r10, r3, r10, lsl #16 @ a5 a4 : 4
    ldr.w r3, [lr, #28] @ a3 a1 : 1
    ldr.w r4, [lr, #60] @ a3 a1 : 2
    ldr.w r11, [lr, #92] @ a3 a1 : 3
    ldr.w r12, [lr, #124] @ a3 a1 : 4
    sadd16 r0, r7, r3 @ a5 a4 + a3 a1 : 1
    ssub16 r3, r7, r3 @ a5 a4 - a3 a1 : 1
    sadd16 r7, r8, r4 @ a5 a4 + a3 a1 : 2
    ssub16 r4, r8, r4 @ a5 a4 - a3 a1 : 2
    sadd16 r8, r9, r11 @ a5 a4 + a3 a1 : 3
    ssub16 r11, r9, r11 @ a5 a4 - a3 a1 : 3
    sadd16 r9, r10, r12 @ a5 a4 + a3 a1 : 4
    ssub16 r12, r10, r12 @ a5 a4 - a3 a1 : 4
    str.w r0, [lr, #4]
    str.w r3, [lr, #12]
    str.w r7, [lr, #36]
    str.w r4, [lr, #44]
    str.w r8, [lr, #68]
    str.w r11, [lr, #76]
    str.w r9, [lr, #100]
    str.w r12, [lr, #108]
    mov.w r0, #0
    sbfx r7, r6, #0, #8 @ a8 : 1
    sbfx r8, r6, #8, #8 @ a8 : 2
    sbfx r9, r6, #16, #8 @ a8 : 3
    sbfx r10, r6, #24, #8 @ a8 : 4
    sbfx r3, r5, #0, #8 @ a7 : 1
    sbfx r4, r5, #8, #8 @ a7 : 2
    sbfx r11, r5, #16, #8 @ a7 : 3
    sbfx r12, r5, #24, #8 @ a7 : 4
    pkhbt r7, r3, r7, lsl #16 @ a7 a8 : 1
    pkhbt r8, r4, r8, lsl #16 @ a7 a8 : 2
    pkhbt r9, r11, r9, lsl #16 @ a7 a8 : 3
    pkhbt r10, r12, r10, lsl #16 @ a7 a8 : 4
    ssub16 r3, r0, r7 @ -a7 -a8 : 1
    ssub16 r4, r0, r8 @ -a7 -a8 : 2
    ssub16 r5, r0, r9 @ -a7 -a8 : 3
    ssub16 r6, r0, r10 @ -a7 -a8 : 4
    str.w r3, [lr, #24]
    str.w r4, [lr, #56]
    str.w r5, [lr, #88]
    str.w r6, [lr, #120]
    sbfx r3, r1, #0, #8 @ a6 : 1
    sbfx r4, r1, #8, #8 @ a6 : 2
    sbfx r5, r1, #16, #8 @ a6 : 3
    sbfx r6, r1, #24, #8 @ a6 : 4
    sbfx r11, r2, #0, #8 @ a2 : 1
    sbfx r12, r2, #8, #8 @ a2 : 2
    pkhbt r3, r3, r11, lsl #16 @ a6 a2 : 1
    pkhbt r4, r4, r12, lsl #16 @ a6 a2 : 2
    sbfx r11, r2, #16, #8 @ a2 : 3
    sbfx r12, r2, #24, #8 @ a2 : 4
    pkhbt r5, r5, r11, lsl #16 @ a6 a2 : 3
    pkhbt r6, r6, r12, lsl #16 @ a6 a2 : 4
    ssub16 r1, r0, r3 @ -a6 -a2 : 1
    ssub16 r2, r0, r4 @ -a6 -a2 : 2
    ssub16 r11, r0, r5 @ -a6 -a2 : 3
    ssub16 r12, r0, r6 @ -a6 -a2 : 4
    sadd16 r0, r3, r7 @ a6 a2 + a7 a8 : 1
    ssub16 r7, r3, r7 @ a6 a2 - a7 a8 : 1
    sadd16 r3, r4, r8 @ a6 a2 + a7 a8 : 2
    ssub16 r8, r4, r8 @ a6 a2 - a7 a8 : 2
    sadd16 r4, r5, r9 @ a6 a2 + a7 a8 : 3
    ssub16 r9, r5, r9 @ a6 a2 - a7 a8 : 3
    sadd16 r5, r6, r10 @ a6 a2 + a7 a8 : 4
    ssub16 r10, r6, r10 @ a6 a2 - a7 a8 : 4
    str.w r1, [lr, #16]
    str.w r2, [lr, #48]
    str.w r11, [lr, #80]
    str.w r12, [lr, #112]
    str.w r7, [lr, #8]
    str.w r8, [lr, #40]
    str.w r9, [lr, #72]
    str.w r10, [lr, #104]
    ldr.w r6, [lr, #4]
    ldr.w r7, [lr, #36]
    ldr.w r8, [lr, #68]
    ldr.w r9, [lr, #100]
    sadd16 r11, r5, r9 @ 2x2 mod x^2 - 1 : 4
    ssub16 r12, r5, r9 @ 2x2 mod x^2 + 1 : 4
    sadd16 r9, r4, r8 @ 2x2 mod x^2 - 1 : 3
    ssub16 r10, r4, r8 @ 2x2 mod x^2 + 1 : 3
    ssub16 r8, r3, r7 @ 2x2 mod x^2 + 1 : 2
    sadd16 r7, r3, r7 @ 2x2 mod x^2 - 1 : 2
    sadd16 r1, r0, r6 @ 2x2 mod x^2 - 1 : 1
    ssub16 r2, r0, r6 @ 2x2 mod x^2 + 1 : 1
    vmov r3, s5
    vmov r4, s6
    vmov r5, s4
    mov.w r6, #4591
    smuad r0, r1, r3
    smuadx lr, r1, r3
    smmulr r1, r0, r5
    mls r0, r1, r6, r0
    smmulr r1, lr, r5
    mls lr, r1, r6, lr
    pkhbt r1, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 1
    smuad r0, r7, r3
    smuadx lr, r7, r3
    smmulr r7, r0, r5
    mls r0, r7, r6, r0
    smmulr r7, lr, r5
    mls lr, r7, r6, lr
    pkhbt r7, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 2
    smuad r0, r9, r3
    smuadx lr, r9, r3
    smmulr r9, r0, r5
    mls r0, r9, r6, r0
    smmulr r9, lr, r5
    mls lr, r9, r6, lr
    pkhbt r9, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 3
    smuad r0, r11, r3
    smuadx lr, r11, r3
    smmulr r11, r0, r5
    mls r0, r11, r6, r0
    smmulr r11, lr, r5
    mls lr, r11, r6, lr
    pkhbt r11, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 4
    smusd r0, r2, r4
    smuadx lr, r2, r4
    smmulr r2, r0, r5
    mls r0, r2, r6, r0
    smmulr r2, lr, r5
    mls lr, r2, r6, lr
    pkhbt r2, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 1
    smusd r0, r8, r4
    smuadx lr, r8, r4
    smmulr r8, r0, r5
    mls r0, r8, r6, r0
    smmulr r8, lr, r5
    mls lr, r8, r6, lr
    pkhbt r8, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 2
    smusd r0, r10, r4
    smuadx lr, r10, r4
    smmulr r10, r0, r5
    mls r0, r10, r6, r0
    smmulr r10, lr, r5
    mls lr, r10, r6, lr
    pkhbt r10, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 3
    smusd r0, r12, r4
    smuadx lr, r12, r4
    smmulr r12, r0, r5
    mls r0, r12, r6, r0
    smmulr r12, lr, r5
    mls lr, r12, r6, lr
    pkhbt r12, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 4
@ r1, r2, r7, r8, r9, r10, r11, r12
    sadd16 r3, r1, r2
    ssub16 r4, r1, r2 @ r3 r4 = 4x4 mod x^4 - 1 : 1
    sadd16 r1, r7, r8
    ssub16 r2, r7, r8 @ r1 r2 = 4x4 mod x^4 - 1 : 2
    sadd16 r7, r9, r10
    ssub16 r8, r9, r10 @ r7 r8 = 4x4 mod x^4 - 1 : 3
    sadd16 r9, r11, r12
    ssub16 r10, r11, r12 @ r9 r10 = 4x4 mod x^4 - 1 : 4
    vmov lr, s20
    @ str.w r3, [lr]
    @ str.w r4, [lr, #4]
    @ str.w r1, [lr, #32]
    @ str.w r2, [lr, #36]
    str.w r7, [lr, #64]
    str.w r8, [lr, #68]
    str.w r9, [lr, #96]
    str.w r10, [lr, #100]
@ r5 = qinv, r6 = 4591
    vmov r11, s7 @ w0w1
    vmov r12, s8 @ w2w3
    ldr.w r7, [lr, #8] @ a0a1
    ldr.w r8, [lr, #12] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 1
    @ r3, r4, r7, r8
    sadd16 r9, r3, r7
    sadd16 r10, r4, r8
    ssub16 r7, r3, r7
    ssub16 r8, r4, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 1
    str.w r9, [lr]
    str.w r10, [lr, #4]
    str.w r7, [lr, #8]
    str.w r8, [lr, #12]
    ldr.w r7, [lr, #40] @ a0a1
    ldr.w r8, [lr, #44] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 2
    @ r1, r2, r7, r8
    sadd16 r9, r1, r7
    sadd16 r10, r2, r8
    ssub16 r7, r1, r7
    ssub16 r8, r2, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 2
    str.w r9, [lr, #32]
    str.w r10, [lr, #36]
    str.w r7, [lr, #40]
    str.w r8, [lr, #44]
    ldr.w r1, [lr, #72]
    ldr.w r2, [lr, #76]
    ldr.w r3, [lr, #104]
    ldr.w r4, [lr, #108]
    smuadx r7, r1, r11 @ a0b1 + a1b0
    smuadx r8, r2, r12 @ a2b3 + a3b2
    sub.w r7, r7, r8 @ c1
    smuadx r8, r1, r12
    smladx r8, r2, r11, r8 @ c3
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c1)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r9, r0, r12 @ a0b2 - a3b3
    smlad r9, r1, r11, r9 @ c2
    smusd r10, r0, r11 @ a0b0 - a3b1
    smuad r2, r1, r12 @ a2b2 + a1b3
    sub.w r10, r10, r2 @ c0
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c0)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c2)
    pkhbt r1, r9, r7, lsl #16
    pkhbt r2, r10, r8, lsl #16 @ r1 r2 = 4x4 mod x^4 + 1 : 3
    smuadx r7, r3, r11 @ a0b1 + a1b0
    smuadx r8, r4, r12 @ a2b3 + a3b2
    sub.w r7, r7, r8 @ c1
    smuadx r8, r3, r12
    smladx r8, r4, r11, r8 @ c3
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c1)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c3)
    pkhbt r0, r3, r4 @ a0a3
    pkhtb r3, r3, r4 @ a2a1
    smusd r9, r0, r12 @ a0b2 - a3b3
    smlad r9, r3, r11, r9 @ c2
    smusd r10, r0, r11 @ a0b0 - a3b1
    smuad r4, r3, r12 @ a2b2 + a1b3
    sub.w r10, r10, r4 @ c0
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c0)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c2)
    pkhbt r3, r9, r7, lsl #16
    pkhbt r4, r10, r8, lsl #16 @ r3 r4 = 4x4 mod x^4 + 1 : 4
    ldr.w r5, [lr, #64]
    ldr.w r6, [lr, #68]
    ldr.w r7, [lr, #96]
    ldr.w r8, [lr, #100]
    @ r5, r6, r1, r2
    @ r7, r8, r3, r4
    sadd16 r9, r5, r1
    sadd16 r10, r6, r2
    ssub16 r11, r5, r1
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    sadd16 r2, r8, r4
    ssub16 r3, r7, r3
    ssub16 r4, r8, r4
    str.w r9, [lr, #64]
    str.w r10, [lr, #68]
    str.w r11, [lr, #72]
    str.w r12, [lr, #76]
    str.w r1, [lr, #96]
    str.w r2, [lr, #100]
    str.w r3, [lr, #104]
    str.w r4, [lr, #108]
@ all 8x8 mod x^8 - 1 done
@ 8x8 mod x^8 + 1 : 1
    ldr.w r1, [lr, #16] @ a0a1
    ldr.w r2, [lr, #20] @ a2a3
    ldr.w r3, [lr, #24] @ a4a5
    ldr.w r4, [lr, #28] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr]
    str.w r1, [lr, #4]
    str.w r2, [lr, #8]
    str.w r3, [lr, #12]
    str.w r9, [lr, #16]
    str.w r10, [lr, #20]
    str.w r11, [lr, #24]
    str.w r12, [lr, #28]
@ 8x8 mod x^8 + 1 : 2
    ldr.w r1, [lr, #48] @ a0a1
    ldr.w r2, [lr, #52] @ a2a3
    ldr.w r3, [lr, #56] @ a4a5
    ldr.w r4, [lr, #60] @ a6a7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #32]
    ldr.w r2, [lr, #36]
    ldr.w r3, [lr, #40]
    ldr.w r4, [lr, #44]
    vmov r5, s13 @ a0a1
    ldr.w r6, [lr]
    ldr.w r7, [lr, #4]
    ldr.w r8, [lr, #8]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #12]
    ldr.w r1, [lr, #16]
    ldr.w r4, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    vmov r5, s19
    sbfx r6, r5, #0, #8
    sbfx r7, r5, #8, #8
    sbfx r8, r5, #16, #8
    sbfx r9, r5, #24, #8
    pkhbt r6, r6, r7, lsl #16
    pkhbt r7, r8, r9, lsl #16
    vmov s19, r7
    str.w r6, [r2], #4
    vmov s1, r2
@ 8x8 mod x^8 + 1 : 3
    ldr.w r1, [lr, #80] @ a0a1
    ldr.w r2, [lr, #84] @ a2a3
    ldr.w r3, [lr, #88] @ a4a5
    ldr.w r4, [lr, #92] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #64]
    ldr.w r2, [lr, #68]
    ldr.w r3, [lr, #72]
    ldr.w r4, [lr, #76]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr, #64]
    str.w r1, [lr, #68]
    str.w r2, [lr, #72]
    str.w r3, [lr, #76]
    str.w r9, [lr, #80]
    str.w r10, [lr, #84]
    str.w r11, [lr, #88]
    str.w r12, [lr, #92]
@ 8x8 mod x^8 + 1 : 4
    ldr.w r1, [lr, #112] @ a0a1
    ldr.w r2, [lr, #116] @ a2a3
    ldr.w r3, [lr, #120] @ a4a5
    ldr.w r4, [lr, #124] @ a6a7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #96]
    ldr.w r2, [lr, #100]
    ldr.w r3, [lr, #104]
    ldr.w r4, [lr, #108]
    vmov r5, s14 @ a2a3
    ldr.w r6, [lr, #64]
    ldr.w r7, [lr, #68]
    ldr.w r8, [lr, #72]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #76]
    ldr.w r1, [lr, #80]
    ldr.w r4, [lr, #84]
    ldr.w r6, [lr, #88]
    ldr.w r7, [lr, #92]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    vmov r5, s19
    str.w r5, [r2], #4
    vmov s1, r2
    vmov r0, s0
    vmov r1, s2
    cmp.w r0, r1
    bne.w ntt17_rader_byte_body1
@special case on f[760~763]
    ldr.w r1, [r0, #540]
    ldr.w r2, [r0, #180]
    ldr.w r3, [r0, #450]
    ldr.w r4, [r0, #360]
    ldr.w r5, [r0, #630]
    ldr.w r6, [r0, #720]
    ldr.w r7, [r0, #270]
    ldr.w r8, [r0, #90]
    ldr.w r9, [r0], #4
    ubfx r6, r6, #0, #8
    sbfx r10, r9, #0, #8 @ a0
    sbfx r11, r9, #8, #8 @ a1
    pkhbt r10, r10, r11, lsl #16 @ a0a1
    sbfx r11, r9, #16, #8 @ a2
    sbfx r12, r9, #24, #8 @ a3
    pkhbt r11, r11, r12, lsl #16 @ a2a3
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    sadd8 r9, r9, r6
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8 @ b0b1b2b3
    vmov s0, r0
    vmov s13, r10
    vmov s14, r11
    vmov s19, r9
    sbfx r9, r7, #0, #8
    sbfx r10, r8, #0, #8
    pkhbt r9, r9, r10, lsl #16 @ a3a1 : 1
    sbfx r10, r7, #8, #8
    sbfx r11, r8, #8, #8
    pkhbt r10, r10, r11, lsl #16 @ a3a1 : 2
    sbfx r11, r7, #16, #8
    sbfx r12, r8, #16, #8
    pkhbt r11, r11, r12, lsl #16 @ a3a1 : 3
    sbfx r12, r7, #24, #8
    sbfx r0, r8, #24, #8
    pkhbt r12, r12, r0, lsl #16 @ a3a1 : 4
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    str.w r11, [lr, #92]
    str.w r12, [lr, #124]
    mov.w r0, #0
    ssub8 r0, r0, r4 @ -a4
    sbfx r7, r0, #0, #8 @ -a4 : 1
    sbfx r8, r0, #8, #8 @ -a4 : 2
    sbfx r9, r0, #16, #8 @ -a4 : 3
    sbfx r10, r0, #24, #8 @ -a4 : 4
    sbfx r11, r3, #0, #8 @ a5 : 1
    sbfx r12, r3, #8, #8 @ a5 : 2
    pkhbt r7, r11, r7, lsl #16 @ a5 -a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 -a4 : 2
    sbfx r0, r3, #16, #8 @ a5 : 3
    sbfx r3, r3, #24, #8 @ a5 : 4
    pkhbt r9, r0, r9, lsl #16 @ a5 -a4 : 3
    pkhbt r10, r3, r10, lsl #16 @ a5 -a4 : 4
    str.w r7, [lr, #20]
    str.w r8, [lr, #52]
    str.w r9, [lr, #84]
    str.w r10, [lr, #116]
    sbfx r7, r4, #0, #8 @ a4 : 1
    sbfx r8, r4, #8, #8 @ a4 : 2
    sbfx r9, r4, #16, #8 @ a4 : 3
    sbfx r10, r4, #24, #8 @ a4 : 4
    pkhbt r7, r11, r7, lsl #16 @ a5 a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 a4 : 2
    pkhbt r9, r0, r9, lsl #16 @ a5 a4 : 3
    pkhbt r10, r3, r10, lsl #16 @ a5 a4 : 4
    ldr.w r3, [lr, #28] @ a3 a1 : 1
    ldr.w r4, [lr, #60] @ a3 a1 : 2
    ldr.w r11, [lr, #92] @ a3 a1 : 3
    ldr.w r12, [lr, #124] @ a3 a1 : 4
    sadd16 r0, r7, r3 @ a5 a4 + a3 a1 : 1
    ssub16 r3, r7, r3 @ a5 a4 - a3 a1 : 1
    sadd16 r7, r8, r4 @ a5 a4 + a3 a1 : 2
    ssub16 r4, r8, r4 @ a5 a4 - a3 a1 : 2
    sadd16 r8, r9, r11 @ a5 a4 + a3 a1 : 3
    ssub16 r11, r9, r11 @ a5 a4 - a3 a1 : 3
    sadd16 r9, r10, r12 @ a5 a4 + a3 a1 : 4
    ssub16 r12, r10, r12 @ a5 a4 - a3 a1 : 4
    str.w r0, [lr, #4]
    str.w r3, [lr, #12]
    str.w r7, [lr, #36]
    str.w r4, [lr, #44]
    str.w r8, [lr, #68]
    str.w r11, [lr, #76]
    str.w r9, [lr, #100]
    str.w r12, [lr, #108]
    mov.w r0, #0
    sbfx r7, r6, #0, #8 @ a8 : 1
    sbfx r8, r6, #8, #8 @ a8 : 2
    sbfx r9, r6, #16, #8 @ a8 : 3
    sbfx r10, r6, #24, #8 @ a8 : 4
    sbfx r3, r5, #0, #8 @ a7 : 1
    sbfx r4, r5, #8, #8 @ a7 : 2
    sbfx r11, r5, #16, #8 @ a7 : 3
    sbfx r12, r5, #24, #8 @ a7 : 4
    pkhbt r7, r3, r7, lsl #16 @ a7 a8 : 1
    pkhbt r8, r4, r8, lsl #16 @ a7 a8 : 2
    pkhbt r9, r11, r9, lsl #16 @ a7 a8 : 3
    pkhbt r10, r12, r10, lsl #16 @ a7 a8 : 4
    ssub16 r3, r0, r7 @ -a7 -a8 : 1
    ssub16 r4, r0, r8 @ -a7 -a8 : 2
    ssub16 r5, r0, r9 @ -a7 -a8 : 3
    ssub16 r6, r0, r10 @ -a7 -a8 : 4
    str.w r3, [lr, #24]
    str.w r4, [lr, #56]
    str.w r5, [lr, #88]
    str.w r6, [lr, #120]
    sbfx r3, r1, #0, #8 @ a6 : 1
    sbfx r4, r1, #8, #8 @ a6 : 2
    sbfx r5, r1, #16, #8 @ a6 : 3
    sbfx r6, r1, #24, #8 @ a6 : 4
    sbfx r11, r2, #0, #8 @ a2 : 1
    sbfx r12, r2, #8, #8 @ a2 : 2
    pkhbt r3, r3, r11, lsl #16 @ a6 a2 : 1
    pkhbt r4, r4, r12, lsl #16 @ a6 a2 : 2
    sbfx r11, r2, #16, #8 @ a2 : 3
    sbfx r12, r2, #24, #8 @ a2 : 4
    pkhbt r5, r5, r11, lsl #16 @ a6 a2 : 3
    pkhbt r6, r6, r12, lsl #16 @ a6 a2 : 4
    ssub16 r1, r0, r3 @ -a6 -a2 : 1
    ssub16 r2, r0, r4 @ -a6 -a2 : 2
    ssub16 r11, r0, r5 @ -a6 -a2 : 3
    ssub16 r12, r0, r6 @ -a6 -a2 : 4
    sadd16 r0, r3, r7 @ a6 a2 + a7 a8 : 1
    ssub16 r7, r3, r7 @ a6 a2 - a7 a8 : 1
    sadd16 r3, r4, r8 @ a6 a2 + a7 a8 : 2
    ssub16 r8, r4, r8 @ a6 a2 - a7 a8 : 2
    sadd16 r4, r5, r9 @ a6 a2 + a7 a8 : 3
    ssub16 r9, r5, r9 @ a6 a2 - a7 a8 : 3
    sadd16 r5, r6, r10 @ a6 a2 + a7 a8 : 4
    ssub16 r10, r6, r10 @ a6 a2 - a7 a8 : 4
    str.w r1, [lr, #16]
    str.w r2, [lr, #48]
    str.w r11, [lr, #80]
    str.w r12, [lr, #112]
    str.w r7, [lr, #8]
    str.w r8, [lr, #40]
    str.w r9, [lr, #72]
    str.w r10, [lr, #104]
    ldr.w r6, [lr, #4]
    ldr.w r7, [lr, #36]
    ldr.w r8, [lr, #68]
    ldr.w r9, [lr, #100]
    sadd16 r11, r5, r9 @ 2x2 mod x^2 - 1 : 4
    ssub16 r12, r5, r9 @ 2x2 mod x^2 + 1 : 4
    sadd16 r9, r4, r8 @ 2x2 mod x^2 - 1 : 3
    ssub16 r10, r4, r8 @ 2x2 mod x^2 + 1 : 3
    ssub16 r8, r3, r7 @ 2x2 mod x^2 + 1 : 2
    sadd16 r7, r3, r7 @ 2x2 mod x^2 - 1 : 2
    sadd16 r1, r0, r6 @ 2x2 mod x^2 - 1 : 1
    ssub16 r2, r0, r6 @ 2x2 mod x^2 + 1 : 1
    vmov r3, s5
    vmov r4, s6
    vmov r5, s4
    mov.w r6, #4591
    smuad r0, r1, r3
    smuadx lr, r1, r3
    smmulr r1, r0, r5
    mls r0, r1, r6, r0
    smmulr r1, lr, r5
    mls lr, r1, r6, lr
    pkhbt r1, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 1
    smuad r0, r7, r3
    smuadx lr, r7, r3
    smmulr r7, r0, r5
    mls r0, r7, r6, r0
    smmulr r7, lr, r5
    mls lr, r7, r6, lr
    pkhbt r7, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 2
    smuad r0, r9, r3
    smuadx lr, r9, r3
    smmulr r9, r0, r5
    mls r0, r9, r6, r0
    smmulr r9, lr, r5
    mls lr, r9, r6, lr
    pkhbt r9, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 3
    smuad r0, r11, r3
    smuadx lr, r11, r3
    smmulr r11, r0, r5
    mls r0, r11, r6, r0
    smmulr r11, lr, r5
    mls lr, r11, r6, lr
    pkhbt r11, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 4
    smusd r0, r2, r4
    smuadx lr, r2, r4
    smmulr r2, r0, r5
    mls r0, r2, r6, r0
    smmulr r2, lr, r5
    mls lr, r2, r6, lr
    pkhbt r2, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 1
    smusd r0, r8, r4
    smuadx lr, r8, r4
    smmulr r8, r0, r5
    mls r0, r8, r6, r0
    smmulr r8, lr, r5
    mls lr, r8, r6, lr
    pkhbt r8, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 2
    smusd r0, r10, r4
    smuadx lr, r10, r4
    smmulr r10, r0, r5
    mls r0, r10, r6, r0
    smmulr r10, lr, r5
    mls lr, r10, r6, lr
    pkhbt r10, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 3
    smusd r0, r12, r4
    smuadx lr, r12, r4
    smmulr r12, r0, r5
    mls r0, r12, r6, r0
    smmulr r12, lr, r5
    mls lr, r12, r6, lr
    pkhbt r12, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 4
@ r1, r2, r7, r8, r9, r10, r11, r12
    sadd16 r3, r1, r2
    ssub16 r4, r1, r2 @ r3 r4 = 4x4 mod x^4 - 1 : 1
    sadd16 r1, r7, r8
    ssub16 r2, r7, r8 @ r1 r2 = 4x4 mod x^4 - 1 : 2
    sadd16 r7, r9, r10
    ssub16 r8, r9, r10 @ r7 r8 = 4x4 mod x^4 - 1 : 3
    sadd16 r9, r11, r12
    ssub16 r10, r11, r12 @ r9 r10 = 4x4 mod x^4 - 1 : 4
    vmov lr, s20
    @ str.w r3, [lr]
    @ str.w r4, [lr, #4]
    @ str.w r1, [lr, #32]
    @ str.w r2, [lr, #36]
    str.w r7, [lr, #64]
    str.w r8, [lr, #68]
    str.w r9, [lr, #96]
    str.w r10, [lr, #100]
@ r5 = qinv, r6 = 4591
    vmov r11, s7 @ w0w1
    vmov r12, s8 @ w2w3
    ldr.w r7, [lr, #8] @ a0a1
    ldr.w r8, [lr, #12] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 1
    @ r3, r4, r7, r8
    sadd16 r9, r3, r7
    sadd16 r10, r4, r8
    ssub16 r7, r3, r7
    ssub16 r8, r4, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 1
    str.w r9, [lr]
    str.w r10, [lr, #4]
    str.w r7, [lr, #8]
    str.w r8, [lr, #12]
    ldr.w r7, [lr, #40] @ a0a1
    ldr.w r8, [lr, #44] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 2
    @ r1, r2, r7, r8
    sadd16 r9, r1, r7
    sadd16 r10, r2, r8
    ssub16 r7, r1, r7
    ssub16 r8, r2, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 2
    str.w r9, [lr, #32]
    str.w r10, [lr, #36]
    str.w r7, [lr, #40]
    str.w r8, [lr, #44]
    ldr.w r1, [lr, #72]
    ldr.w r2, [lr, #76]
    ldr.w r3, [lr, #104]
    ldr.w r4, [lr, #108]
    smuadx r7, r1, r11 @ a0b1 + a1b0
    smuadx r8, r2, r12 @ a2b3 + a3b2
    sub.w r7, r7, r8 @ c1
    smuadx r8, r1, r12
    smladx r8, r2, r11, r8 @ c3
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c1)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r9, r0, r12 @ a0b2 - a3b3
    smlad r9, r1, r11, r9 @ c2
    smusd r10, r0, r11 @ a0b0 - a3b1
    smuad r2, r1, r12 @ a2b2 + a1b3
    sub.w r10, r10, r2 @ c0
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c0)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c2)
    pkhbt r1, r9, r7, lsl #16
    pkhbt r2, r10, r8, lsl #16 @ r1 r2 = 4x4 mod x^4 + 1 : 3
    smuadx r7, r3, r11 @ a0b1 + a1b0
    smuadx r8, r4, r12 @ a2b3 + a3b2
    sub.w r7, r7, r8 @ c1
    smuadx r8, r3, r12
    smladx r8, r4, r11, r8 @ c3
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c1)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c3)
    pkhbt r0, r3, r4 @ a0a3
    pkhtb r3, r3, r4 @ a2a1
    smusd r9, r0, r12 @ a0b2 - a3b3
    smlad r9, r3, r11, r9 @ c2
    smusd r10, r0, r11 @ a0b0 - a3b1
    smuad r4, r3, r12 @ a2b2 + a1b3
    sub.w r10, r10, r4 @ c0
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c0)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c2)
    pkhbt r3, r9, r7, lsl #16
    pkhbt r4, r10, r8, lsl #16 @ r3 r4 = 4x4 mod x^4 + 1 : 4
    ldr.w r5, [lr, #64]
    ldr.w r6, [lr, #68]
    ldr.w r7, [lr, #96]
    ldr.w r8, [lr, #100]
    @ r5, r6, r1, r2
    @ r7, r8, r3, r4
    sadd16 r9, r5, r1
    sadd16 r10, r6, r2
    ssub16 r11, r5, r1
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    sadd16 r2, r8, r4
    ssub16 r3, r7, r3
    ssub16 r4, r8, r4
    str.w r9, [lr, #64]
    str.w r10, [lr, #68]
    str.w r11, [lr, #72]
    str.w r12, [lr, #76]
    str.w r1, [lr, #96]
    str.w r2, [lr, #100]
    str.w r3, [lr, #104]
    str.w r4, [lr, #108]
@ all 8x8 mod x^8 - 1 done
@ 8x8 mod x^8 + 1 : 1
    ldr.w r1, [lr, #16] @ a0a1
    ldr.w r2, [lr, #20] @ a2a3
    ldr.w r3, [lr, #24] @ a4a5
    ldr.w r4, [lr, #28] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr]
    str.w r1, [lr, #4]
    str.w r2, [lr, #8]
    str.w r3, [lr, #12]
    str.w r9, [lr, #16]
    str.w r10, [lr, #20]
    str.w r11, [lr, #24]
    str.w r12, [lr, #28]
@ 8x8 mod x^8 + 1 : 2
    ldr.w r1, [lr, #48] @ a0a1
    ldr.w r2, [lr, #52] @ a2a3
    ldr.w r3, [lr, #56] @ a4a5
    ldr.w r4, [lr, #60] @ a6a7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #32]
    ldr.w r2, [lr, #36]
    ldr.w r3, [lr, #40]
    ldr.w r4, [lr, #44]
    vmov r5, s13 @ a0a1
    ldr.w r6, [lr]
    ldr.w r7, [lr, #4]
    ldr.w r8, [lr, #8]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #12]
    ldr.w r1, [lr, #16]
    ldr.w r4, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    vmov r5, s19
    sbfx r6, r5, #0, #8
    sbfx r7, r5, #8, #8
    sbfx r8, r5, #16, #8
    sbfx r9, r5, #24, #8
    pkhbt r6, r6, r7, lsl #16
    pkhbt r7, r8, r9, lsl #16
    vmov s19, r7
    str.w r6, [r2], #4
    vmov s1, r2
@ 8x8 mod x^8 + 1 : 3
    ldr.w r1, [lr, #80] @ a0a1
    ldr.w r2, [lr, #84] @ a2a3
    ldr.w r3, [lr, #88] @ a4a5
    ldr.w r4, [lr, #92] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #64]
    ldr.w r2, [lr, #68]
    ldr.w r3, [lr, #72]
    ldr.w r4, [lr, #76]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr, #64]
    str.w r1, [lr, #68]
    str.w r2, [lr, #72]
    str.w r3, [lr, #76]
    str.w r9, [lr, #80]
    str.w r10, [lr, #84]
    str.w r11, [lr, #88]
    str.w r12, [lr, #92]
@ 8x8 mod x^8 + 1 : 4
    ldr.w r1, [lr, #112] @ a0a1
    ldr.w r2, [lr, #116] @ a2a3
    ldr.w r3, [lr, #120] @ a4a5
    ldr.w r4, [lr, #124] @ a6a7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #96]
    ldr.w r2, [lr, #100]
    ldr.w r3, [lr, #104]
    ldr.w r4, [lr, #108]
    vmov r5, s14 @ a2a3
    ldr.w r6, [lr, #64]
    ldr.w r7, [lr, #68]
    ldr.w r8, [lr, #72]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #76]
    ldr.w r1, [lr, #80]
    ldr.w r4, [lr, #84]
    ldr.w r6, [lr, #88]
    ldr.w r7, [lr, #92]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    vmov r5, s19
    str.w r5, [r2], #4
    vmov s1, r2
    vmov r0, s0
ntt17_rader_byte_body2:
    ldr.w r1, [r0, #540]
    ldr.w r2, [r0, #180]
    ldr.w r3, [r0, #450]
    ldr.w r4, [r0, #360]
    ldr.w r5, [r0, #630]
    @ ldr.w r6, [r0, #720]
    mov.w r6, #0
    ldr.w r7, [r0, #270]
    ldr.w r8, [r0, #90]
    ldr.w r9, [r0], #4
    sbfx r10, r9, #0, #8 @ a0
    sbfx r11, r9, #8, #8 @ a1
    pkhbt r10, r10, r11, lsl #16 @ a0a1
    sbfx r11, r9, #16, #8 @ a2
    sbfx r12, r9, #24, #8 @ a3
    pkhbt r11, r11, r12, lsl #16 @ a2a3
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    @ sadd8 r9, r9, r6
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8 @ b0b1b2b3
    vmov s0, r0
    vmov s13, r10
    vmov s14, r11
    vmov s19, r9
    sbfx r9, r7, #0, #8
    sbfx r10, r8, #0, #8
    pkhbt r9, r9, r10, lsl #16 @ a3a1 : 1
    sbfx r10, r7, #8, #8
    sbfx r11, r8, #8, #8
    pkhbt r10, r10, r11, lsl #16 @ a3a1 : 2
    sbfx r11, r7, #16, #8
    sbfx r12, r8, #16, #8
    pkhbt r11, r11, r12, lsl #16 @ a3a1 : 3
    sbfx r12, r7, #24, #8
    sbfx r0, r8, #24, #8
    pkhbt r12, r12, r0, lsl #16 @ a3a1 : 4
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    str.w r11, [lr, #92]
    str.w r12, [lr, #124]
    mov.w r0, #0
    ssub8 r0, r0, r4 @ -a4
    sbfx r7, r0, #0, #8 @ -a4 : 1
    sbfx r8, r0, #8, #8 @ -a4 : 2
    sbfx r9, r0, #16, #8 @ -a4 : 3
    sbfx r10, r0, #24, #8 @ -a4 : 4
    sbfx r11, r3, #0, #8 @ a5 : 1
    sbfx r12, r3, #8, #8 @ a5 : 2
    pkhbt r7, r11, r7, lsl #16 @ a5 -a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 -a4 : 2
    sbfx r0, r3, #16, #8 @ a5 : 3
    sbfx r3, r3, #24, #8 @ a5 : 4
    pkhbt r9, r0, r9, lsl #16 @ a5 -a4 : 3
    pkhbt r10, r3, r10, lsl #16 @ a5 -a4 : 4
    str.w r7, [lr, #20]
    str.w r8, [lr, #52]
    str.w r9, [lr, #84]
    str.w r10, [lr, #116]
    sbfx r7, r4, #0, #8 @ a4 : 1
    sbfx r8, r4, #8, #8 @ a4 : 2
    sbfx r9, r4, #16, #8 @ a4 : 3
    sbfx r10, r4, #24, #8 @ a4 : 4
    pkhbt r7, r11, r7, lsl #16 @ a5 a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 a4 : 2
    pkhbt r9, r0, r9, lsl #16 @ a5 a4 : 3
    pkhbt r10, r3, r10, lsl #16 @ a5 a4 : 4
    ldr.w r3, [lr, #28] @ a3 a1 : 1
    ldr.w r4, [lr, #60] @ a3 a1 : 2
    ldr.w r11, [lr, #92] @ a3 a1 : 3
    ldr.w r12, [lr, #124] @ a3 a1 : 4
    sadd16 r0, r7, r3 @ a5 a4 + a3 a1 : 1
    ssub16 r3, r7, r3 @ a5 a4 - a3 a1 : 1
    sadd16 r7, r8, r4 @ a5 a4 + a3 a1 : 2
    ssub16 r4, r8, r4 @ a5 a4 - a3 a1 : 2
    sadd16 r8, r9, r11 @ a5 a4 + a3 a1 : 3
    ssub16 r11, r9, r11 @ a5 a4 - a3 a1 : 3
    sadd16 r9, r10, r12 @ a5 a4 + a3 a1 : 4
    ssub16 r12, r10, r12 @ a5 a4 - a3 a1 : 4
    str.w r0, [lr, #4]
    str.w r3, [lr, #12]
    str.w r7, [lr, #36]
    str.w r4, [lr, #44]
    str.w r8, [lr, #68]
    str.w r11, [lr, #76]
    str.w r9, [lr, #100]
    str.w r12, [lr, #108]
    mov.w r0, #0
    sbfx r7, r6, #0, #8 @ a8 : 1
    sbfx r8, r6, #8, #8 @ a8 : 2
    sbfx r9, r6, #16, #8 @ a8 : 3
    sbfx r10, r6, #24, #8 @ a8 : 4
    sbfx r3, r5, #0, #8 @ a7 : 1
    sbfx r4, r5, #8, #8 @ a7 : 2
    sbfx r11, r5, #16, #8 @ a7 : 3
    sbfx r12, r5, #24, #8 @ a7 : 4
    pkhbt r7, r3, r7, lsl #16 @ a7 a8 : 1
    pkhbt r8, r4, r8, lsl #16 @ a7 a8 : 2
    pkhbt r9, r11, r9, lsl #16 @ a7 a8 : 3
    pkhbt r10, r12, r10, lsl #16 @ a7 a8 : 4
    ssub16 r3, r0, r7 @ -a7 -a8 : 1
    ssub16 r4, r0, r8 @ -a7 -a8 : 2
    ssub16 r5, r0, r9 @ -a7 -a8 : 3
    ssub16 r6, r0, r10 @ -a7 -a8 : 4
    str.w r3, [lr, #24]
    str.w r4, [lr, #56]
    str.w r5, [lr, #88]
    str.w r6, [lr, #120]
    sbfx r3, r1, #0, #8 @ a6 : 1
    sbfx r4, r1, #8, #8 @ a6 : 2
    sbfx r5, r1, #16, #8 @ a6 : 3
    sbfx r6, r1, #24, #8 @ a6 : 4
    sbfx r11, r2, #0, #8 @ a2 : 1
    sbfx r12, r2, #8, #8 @ a2 : 2
    pkhbt r3, r3, r11, lsl #16 @ a6 a2 : 1
    pkhbt r4, r4, r12, lsl #16 @ a6 a2 : 2
    sbfx r11, r2, #16, #8 @ a2 : 3
    sbfx r12, r2, #24, #8 @ a2 : 4
    pkhbt r5, r5, r11, lsl #16 @ a6 a2 : 3
    pkhbt r6, r6, r12, lsl #16 @ a6 a2 : 4
    ssub16 r1, r0, r3 @ -a6 -a2 : 1
    ssub16 r2, r0, r4 @ -a6 -a2 : 2
    ssub16 r11, r0, r5 @ -a6 -a2 : 3
    ssub16 r12, r0, r6 @ -a6 -a2 : 4
    sadd16 r0, r3, r7 @ a6 a2 + a7 a8 : 1
    ssub16 r7, r3, r7 @ a6 a2 - a7 a8 : 1
    sadd16 r3, r4, r8 @ a6 a2 + a7 a8 : 2
    ssub16 r8, r4, r8 @ a6 a2 - a7 a8 : 2
    sadd16 r4, r5, r9 @ a6 a2 + a7 a8 : 3
    ssub16 r9, r5, r9 @ a6 a2 - a7 a8 : 3
    sadd16 r5, r6, r10 @ a6 a2 + a7 a8 : 4
    ssub16 r10, r6, r10 @ a6 a2 - a7 a8 : 4
    str.w r1, [lr, #16]
    str.w r2, [lr, #48]
    str.w r11, [lr, #80]
    str.w r12, [lr, #112]
    str.w r7, [lr, #8]
    str.w r8, [lr, #40]
    str.w r9, [lr, #72]
    str.w r10, [lr, #104]
    ldr.w r6, [lr, #4]
    ldr.w r7, [lr, #36]
    ldr.w r8, [lr, #68]
    ldr.w r9, [lr, #100]
    sadd16 r11, r5, r9 @ 2x2 mod x^2 - 1 : 4
    ssub16 r12, r5, r9 @ 2x2 mod x^2 + 1 : 4
    sadd16 r9, r4, r8 @ 2x2 mod x^2 - 1 : 3
    ssub16 r10, r4, r8 @ 2x2 mod x^2 + 1 : 3
    ssub16 r8, r3, r7 @ 2x2 mod x^2 + 1 : 2
    sadd16 r7, r3, r7 @ 2x2 mod x^2 - 1 : 2
    sadd16 r1, r0, r6 @ 2x2 mod x^2 - 1 : 1
    ssub16 r2, r0, r6 @ 2x2 mod x^2 + 1 : 1
    vmov r3, s5
    vmov r4, s6
    vmov r5, s4
    mov.w r6, #4591
    smuad r0, r1, r3
    smuadx lr, r1, r3
    smmulr r1, r0, r5
    mls r0, r1, r6, r0
    smmulr r1, lr, r5
    mls lr, r1, r6, lr
    pkhbt r1, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 1
    smuad r0, r7, r3
    smuadx lr, r7, r3
    smmulr r7, r0, r5
    mls r0, r7, r6, r0
    smmulr r7, lr, r5
    mls lr, r7, r6, lr
    pkhbt r7, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 2
    smuad r0, r9, r3
    smuadx lr, r9, r3
    smmulr r9, r0, r5
    mls r0, r9, r6, r0
    smmulr r9, lr, r5
    mls lr, r9, r6, lr
    pkhbt r9, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 3
    smuad r0, r11, r3
    smuadx lr, r11, r3
    smmulr r11, r0, r5
    mls r0, r11, r6, r0
    smmulr r11, lr, r5
    mls lr, r11, r6, lr
    pkhbt r11, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 4
    smusd r0, r2, r4
    smuadx lr, r2, r4
    smmulr r2, r0, r5
    mls r0, r2, r6, r0
    smmulr r2, lr, r5
    mls lr, r2, r6, lr
    pkhbt r2, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 1
    smusd r0, r8, r4
    smuadx lr, r8, r4
    smmulr r8, r0, r5
    mls r0, r8, r6, r0
    smmulr r8, lr, r5
    mls lr, r8, r6, lr
    pkhbt r8, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 2
    smusd r0, r10, r4
    smuadx lr, r10, r4
    smmulr r10, r0, r5
    mls r0, r10, r6, r0
    smmulr r10, lr, r5
    mls lr, r10, r6, lr
    pkhbt r10, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 3
    smusd r0, r12, r4
    smuadx lr, r12, r4
    smmulr r12, r0, r5
    mls r0, r12, r6, r0
    smmulr r12, lr, r5
    mls lr, r12, r6, lr
    pkhbt r12, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 4
@ r1, r2, r7, r8, r9, r10, r11, r12
    sadd16 r3, r1, r2
    ssub16 r4, r1, r2 @ r3 r4 = 4x4 mod x^4 - 1 : 1
    sadd16 r1, r7, r8
    ssub16 r2, r7, r8 @ r1 r2 = 4x4 mod x^4 - 1 : 2
    sadd16 r7, r9, r10
    ssub16 r8, r9, r10 @ r7 r8 = 4x4 mod x^4 - 1 : 3
    sadd16 r9, r11, r12
    ssub16 r10, r11, r12 @ r9 r10 = 4x4 mod x^4 - 1 : 4
    vmov lr, s20
    @ str.w r3, [lr]
    @ str.w r4, [lr, #4]
    @ str.w r1, [lr, #32]
    @ str.w r2, [lr, #36]
    str.w r7, [lr, #64]
    str.w r8, [lr, #68]
    str.w r9, [lr, #96]
    str.w r10, [lr, #100]
@ r5 = qinv, r6 = 4591
    vmov r11, s7 @ w0w1
    vmov r12, s8 @ w2w3
    ldr.w r7, [lr, #8] @ a0a1
    ldr.w r8, [lr, #12] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 1
    @ r3, r4, r7, r8
    sadd16 r9, r3, r7
    sadd16 r10, r4, r8
    ssub16 r7, r3, r7
    ssub16 r8, r4, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 1
    str.w r9, [lr]
    str.w r10, [lr, #4]
    str.w r7, [lr, #8]
    str.w r8, [lr, #12]
    ldr.w r7, [lr, #40] @ a0a1
    ldr.w r8, [lr, #44] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 2
    @ r1, r2, r7, r8
    sadd16 r9, r1, r7
    sadd16 r10, r2, r8
    ssub16 r7, r1, r7
    ssub16 r8, r2, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 2
    str.w r9, [lr, #32]
    str.w r10, [lr, #36]
    str.w r7, [lr, #40]
    str.w r8, [lr, #44]
    ldr.w r1, [lr, #72]
    ldr.w r2, [lr, #76]
    ldr.w r3, [lr, #104]
    ldr.w r4, [lr, #108]
    smuadx r7, r1, r11 @ a0b1 + a1b0
    smuadx r8, r2, r12 @ a2b3 + a3b2
    sub.w r7, r7, r8 @ c1
    smuadx r8, r1, r12
    smladx r8, r2, r11, r8 @ c3
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c1)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c3)
    pkhbt r0, r1, r2 @ a0a3
    pkhtb r1, r1, r2 @ a2a1
    smusd r9, r0, r12 @ a0b2 - a3b3
    smlad r9, r1, r11, r9 @ c2
    smusd r10, r0, r11 @ a0b0 - a3b1
    smuad r2, r1, r12 @ a2b2 + a1b3
    sub.w r10, r10, r2 @ c0
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c0)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c2)
    pkhbt r1, r9, r7, lsl #16
    pkhbt r2, r10, r8, lsl #16 @ r1 r2 = 4x4 mod x^4 + 1 : 3
    smuadx r7, r3, r11 @ a0b1 + a1b0
    smuadx r8, r4, r12 @ a2b3 + a3b2
    sub.w r7, r7, r8 @ c1
    smuadx r8, r3, r12
    smladx r8, r4, r11, r8 @ c3
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c1)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c3)
    pkhbt r0, r3, r4 @ a0a3
    pkhtb r3, r3, r4 @ a2a1
    smusd r9, r0, r12 @ a0b2 - a3b3
    smlad r9, r3, r11, r9 @ c2
    smusd r10, r0, r11 @ a0b0 - a3b1
    smuad r4, r3, r12 @ a2b2 + a1b3
    sub.w r10, r10, r4 @ c0
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c0)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c2)
    pkhbt r3, r9, r7, lsl #16
    pkhbt r4, r10, r8, lsl #16 @ r3 r4 = 4x4 mod x^4 + 1 : 4
    ldr.w r5, [lr, #64]
    ldr.w r6, [lr, #68]
    ldr.w r7, [lr, #96]
    ldr.w r8, [lr, #100]
    @ r5, r6, r1, r2
    @ r7, r8, r3, r4
    sadd16 r9, r5, r1
    sadd16 r10, r6, r2
    ssub16 r11, r5, r1
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    sadd16 r2, r8, r4
    ssub16 r3, r7, r3
    ssub16 r4, r8, r4
    str.w r9, [lr, #64]
    str.w r10, [lr, #68]
    str.w r11, [lr, #72]
    str.w r12, [lr, #76]
    str.w r1, [lr, #96]
    str.w r2, [lr, #100]
    str.w r3, [lr, #104]
    str.w r4, [lr, #108]
@ all 8x8 mod x^8 - 1 done
@ 8x8 mod x^8 + 1 : 1
    ldr.w r1, [lr, #16] @ a0a1
    ldr.w r2, [lr, #20] @ a2a3
    ldr.w r3, [lr, #24] @ a4a5
    ldr.w r4, [lr, #28] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr]
    str.w r1, [lr, #4]
    str.w r2, [lr, #8]
    str.w r3, [lr, #12]
    str.w r9, [lr, #16]
    str.w r10, [lr, #20]
    str.w r11, [lr, #24]
    str.w r12, [lr, #28]
@ 8x8 mod x^8 + 1 : 2
    ldr.w r1, [lr, #48] @ a0a1
    ldr.w r2, [lr, #52] @ a2a3
    ldr.w r3, [lr, #56] @ a4a5
    ldr.w r4, [lr, #60] @ a6a7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #32]
    ldr.w r2, [lr, #36]
    ldr.w r3, [lr, #40]
    ldr.w r4, [lr, #44]
    vmov r5, s13 @ a0a1
    ldr.w r6, [lr]
    ldr.w r7, [lr, #4]
    ldr.w r8, [lr, #8]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #12]
    ldr.w r1, [lr, #16]
    ldr.w r4, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    vmov r5, s19
    sbfx r6, r5, #0, #8
    sbfx r7, r5, #8, #8
    sbfx r8, r5, #16, #8
    sbfx r9, r5, #24, #8
    pkhbt r6, r6, r7, lsl #16
    pkhbt r7, r8, r9, lsl #16
    vmov s19, r7
    str.w r6, [r2], #4
    vmov s1, r2
@ 8x8 mod x^8 + 1 : 3
    ldr.w r1, [lr, #80] @ a0a1
    ldr.w r2, [lr, #84] @ a2a3
    ldr.w r3, [lr, #88] @ a4a5
    ldr.w r4, [lr, #92] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #64]
    ldr.w r2, [lr, #68]
    ldr.w r3, [lr, #72]
    ldr.w r4, [lr, #76]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr, #64]
    str.w r1, [lr, #68]
    str.w r2, [lr, #72]
    str.w r3, [lr, #76]
    str.w r9, [lr, #80]
    str.w r10, [lr, #84]
    str.w r11, [lr, #88]
    str.w r12, [lr, #92]
@ 8x8 mod x^8 + 1 : 4
    ldr.w r1, [lr, #112] @ a0a1
    ldr.w r2, [lr, #116] @ a2a3
    ldr.w r3, [lr, #120] @ a4a5
    ldr.w r4, [lr, #124] @ a6a7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #96]
    ldr.w r2, [lr, #100]
    ldr.w r3, [lr, #104]
    ldr.w r4, [lr, #108]
    vmov r5, s14 @ a2a3
    ldr.w r6, [lr, #64]
    ldr.w r7, [lr, #68]
    ldr.w r8, [lr, #72]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #76]
    ldr.w r1, [lr, #80]
    ldr.w r4, [lr, #84]
    ldr.w r6, [lr, #88]
    ldr.w r7, [lr, #92]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    vmov r5, s19
    str.w r5, [r2], #4
    vmov s1, r2
    vmov r0, s0
    vmov r1, s3
    cmp.w r0, r1
    bne.w ntt17_rader_byte_body2
@ last case
    ldr.w r1, [r0, #540]
    ldr.w r2, [r0, #180]
    ldr.w r3, [r0, #450]
    ldr.w r4, [r0, #360]
    ldr.w r5, [r0, #630]
    @ ldr.w r6, [r0, #720]
    mov.w r6, #0
    ldr.w r7, [r0, #270]
    ldr.w r8, [r0, #90]
    ldr.w r9, [r0], #4
    sbfx r10, r9, #0, #8 @ a0
    sbfx r11, r9, #8, #8 @ a1
    pkhbt r10, r10, r11, lsl #16 @ a0a1
    @ sbfx r11, r9, #16, #8 @ a2
    @ sbfx r12, r9, #24, #8 @ a3
    @ pkhbt r11, r11, r12, lsl #16 @ a2a3
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    @ sadd8 r9, r9, r6
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8 @ b0b1b2b3
    vmov s0, r0
    vmov s13, r10
    @ vmov s14, r11
    vmov s19, r9
    sbfx r9, r7, #0, #8
    sbfx r10, r8, #0, #8
    pkhbt r9, r9, r10, lsl #16 @ a3a1 : 1
    sbfx r10, r7, #8, #8
    sbfx r11, r8, #8, #8
    pkhbt r10, r10, r11, lsl #16 @ a3a1 : 2
    @ sbfx r11, r7, #16, #8
    @ sbfx r12, r8, #16, #8
    @ pkhbt r11, r11, r12, lsl #16 @ a3a1 : 3
    @ sbfx r12, r7, #24, #8
    @ sbfx r0, r8, #24, #8
    @ pkhbt r12, r12, r0, lsl #16 @ a3a1 : 4
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    @ str.w r11, [lr, #92]
    @ str.w r12, [lr, #124]
    mov.w r0, #0
    ssub8 r0, r0, r4 @ -a4
    sbfx r7, r0, #0, #8 @ -a4 : 1
    sbfx r8, r0, #8, #8 @ -a4 : 2
    @ sbfx r9, r0, #16, #8 @ -a4 : 3
    @ sbfx r10, r0, #24, #8 @ -a4 : 4
    sbfx r11, r3, #0, #8 @ a5 : 1
    sbfx r12, r3, #8, #8 @ a5 : 2
    pkhbt r7, r11, r7, lsl #16 @ a5 -a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 -a4 : 2
    @ sbfx r0, r3, #16, #8 @ a5 : 3
    @ sbfx r3, r3, #24, #8 @ a5 : 4
    @ pkhbt r9, r0, r9, lsl #16 @ a5 -a4 : 3
    @ pkhbt r10, r3, r10, lsl #16 @ a5 -a4 : 4
    str.w r7, [lr, #20]
    str.w r8, [lr, #52]
    @ str.w r9, [lr, #84]
    @ str.w r10, [lr, #116]
    sbfx r7, r4, #0, #8 @ a4 : 1
    sbfx r8, r4, #8, #8 @ a4 : 2
    @ sbfx r9, r4, #16, #8 @ a4 : 3
    @ sbfx r10, r4, #24, #8 @ a4 : 4
    pkhbt r7, r11, r7, lsl #16 @ a5 a4 : 1
    pkhbt r8, r12, r8, lsl #16 @ a5 a4 : 2
    @ pkhbt r9, r0, r9, lsl #16 @ a5 a4 : 3
    @ pkhbt r10, r3, r10, lsl #16 @ a5 a4 : 4
    ldr.w r3, [lr, #28] @ a3 a1 : 1
    ldr.w r4, [lr, #60] @ a3 a1 : 2
    @ ldr.w r11, [lr, #92] @ a3 a1 : 3
    @ ldr.w r12, [lr, #124] @ a3 a1 : 4
    sadd16 r0, r7, r3 @ a5 a4 + a3 a1 : 1
    ssub16 r3, r7, r3 @ a5 a4 - a3 a1 : 1
    sadd16 r7, r8, r4 @ a5 a4 + a3 a1 : 2
    ssub16 r4, r8, r4 @ a5 a4 - a3 a1 : 2
    @ sadd16 r8, r9, r11 @ a5 a4 + a3 a1 : 3
    @ ssub16 r11, r9, r11 @ a5 a4 - a3 a1 : 3
    @ sadd16 r9, r10, r12 @ a5 a4 + a3 a1 : 4
    @ ssub16 r12, r10, r12 @ a5 a4 - a3 a1 : 4
    str.w r0, [lr, #4]
    str.w r3, [lr, #12]
    str.w r7, [lr, #36]
    str.w r4, [lr, #44]
    @ str.w r8, [lr, #68]
    @ str.w r11, [lr, #76]
    @ str.w r9, [lr, #100]
    @ str.w r12, [lr, #108]
    mov.w r0, #0
    sbfx r7, r6, #0, #8 @ a8 : 1
    sbfx r8, r6, #8, #8 @ a8 : 2
    @ sbfx r9, r6, #16, #8 @ a8 : 3
    @ sbfx r10, r6, #24, #8 @ a8 : 4
    sbfx r3, r5, #0, #8 @ a7 : 1
    sbfx r4, r5, #8, #8 @ a7 : 2
    @ sbfx r11, r5, #16, #8 @ a7 : 3
    @ sbfx r12, r5, #24, #8 @ a7 : 4
    pkhbt r7, r3, r7, lsl #16 @ a7 a8 : 1
    pkhbt r8, r4, r8, lsl #16 @ a7 a8 : 2
    @ pkhbt r9, r11, r9, lsl #16 @ a7 a8 : 3
    @ pkhbt r10, r12, r10, lsl #16 @ a7 a8 : 4
    ssub16 r3, r0, r7 @ -a7 -a8 : 1
    ssub16 r4, r0, r8 @ -a7 -a8 : 2
    @ ssub16 r5, r0, r9 @ -a7 -a8 : 3
    @ ssub16 r6, r0, r10 @ -a7 -a8 : 4
    str.w r3, [lr, #24]
    str.w r4, [lr, #56]
    @ str.w r5, [lr, #88]
    @ str.w r6, [lr, #120]
    sbfx r3, r1, #0, #8 @ a6 : 1
    sbfx r4, r1, #8, #8 @ a6 : 2
    @ sbfx r5, r1, #16, #8 @ a6 : 3
    @ sbfx r6, r1, #24, #8 @ a6 : 4
    sbfx r11, r2, #0, #8 @ a2 : 1
    sbfx r12, r2, #8, #8 @ a2 : 2
    pkhbt r3, r3, r11, lsl #16 @ a6 a2 : 1
    pkhbt r4, r4, r12, lsl #16 @ a6 a2 : 2
    @ sbfx r11, r2, #16, #8 @ a2 : 3
    @ sbfx r12, r2, #24, #8 @ a2 : 4
    @ pkhbt r5, r5, r11, lsl #16 @ a6 a2 : 3
    @ pkhbt r6, r6, r12, lsl #16 @ a6 a2 : 4
    ssub16 r1, r0, r3 @ -a6 -a2 : 1
    ssub16 r2, r0, r4 @ -a6 -a2 : 2
    @ ssub16 r11, r0, r5 @ -a6 -a2 : 3
    @ ssub16 r12, r0, r6 @ -a6 -a2 : 4
    sadd16 r0, r3, r7 @ a6 a2 + a7 a8 : 1
    ssub16 r7, r3, r7 @ a6 a2 - a7 a8 : 1
    sadd16 r3, r4, r8 @ a6 a2 + a7 a8 : 2
    ssub16 r8, r4, r8 @ a6 a2 - a7 a8 : 2
    @ sadd16 r4, r5, r9 @ a6 a2 + a7 a8 : 3
    @ ssub16 r9, r5, r9 @ a6 a2 - a7 a8 : 3
    @ sadd16 r5, r6, r10 @ a6 a2 + a7 a8 : 4
    @ ssub16 r10, r6, r10 @ a6 a2 - a7 a8 : 4
    str.w r1, [lr, #16]
    str.w r2, [lr, #48]
    @ str.w r11, [lr, #80]
    @ str.w r12, [lr, #112]
    str.w r7, [lr, #8]
    str.w r8, [lr, #40]
    @ str.w r9, [lr, #72]
    @ str.w r10, [lr, #104]
    ldr.w r6, [lr, #4]
    ldr.w r7, [lr, #36]
    @ ldr.w r8, [lr, #68]
    @ ldr.w r9, [lr, #100]
    @ sadd16 r11, r5, r9 @ 2x2 mod x^2 - 1 : 4
    @ ssub16 r12, r5, r9 @ 2x2 mod x^2 + 1 : 4
    @ sadd16 r9, r4, r8 @ 2x2 mod x^2 - 1 : 3
    @ ssub16 r10, r4, r8 @ 2x2 mod x^2 + 1 : 3
    ssub16 r8, r3, r7 @ 2x2 mod x^2 + 1 : 2
    sadd16 r7, r3, r7 @ 2x2 mod x^2 - 1 : 2
    sadd16 r1, r0, r6 @ 2x2 mod x^2 - 1 : 1
    ssub16 r2, r0, r6 @ 2x2 mod x^2 + 1 : 1
    vmov r3, s5
    vmov r4, s6
    vmov r5, s4
    mov.w r6, #4591
    smuad r0, r1, r3
    smuadx lr, r1, r3
    smmulr r1, r0, r5
    mls r0, r1, r6, r0
    smmulr r1, lr, r5
    mls lr, r1, r6, lr
    pkhbt r1, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 1
    smuad r0, r7, r3
    smuadx lr, r7, r3
    smmulr r7, r0, r5
    mls r0, r7, r6, r0
    smmulr r7, lr, r5
    mls lr, r7, r6, lr
    pkhbt r7, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 2
    @ smuad r0, r9, r3
    @ smuadx lr, r9, r3
    @ smmulr r9, r0, r5
    @ mls r0, r9, r6, r0
    @ smmulr r9, lr, r5
    @ mls lr, r9, r6, lr
    @ pkhbt r9, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 3
    @ smuad r0, r11, r3
    @ smuadx lr, r11, r3
    @ smmulr r11, r0, r5
    @ mls r0, r11, r6, r0
    @ smmulr r11, lr, r5
    @ mls lr, r11, r6, lr
    @ pkhbt r11, r0, lr, lsl #16 @ 2x2 mod x^2 - 1 done : 4
    smusd r0, r2, r4
    smuadx lr, r2, r4
    smmulr r2, r0, r5
    mls r0, r2, r6, r0
    smmulr r2, lr, r5
    mls lr, r2, r6, lr
    pkhbt r2, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 1
    smusd r0, r8, r4
    smuadx lr, r8, r4
    smmulr r8, r0, r5
    mls r0, r8, r6, r0
    smmulr r8, lr, r5
    mls lr, r8, r6, lr
    pkhbt r8, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 2
    @ smusd r0, r10, r4
    @ smuadx lr, r10, r4
    @ smmulr r10, r0, r5
    @ mls r0, r10, r6, r0
    @ smmulr r10, lr, r5
    @ mls lr, r10, r6, lr
    @ pkhbt r10, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 3
    @ smusd r0, r12, r4
    @ smuadx lr, r12, r4
    @ smmulr r12, r0, r5
    @ mls r0, r12, r6, r0
    @ smmulr r12, lr, r5
    @ mls lr, r12, r6, lr
    @ pkhbt r12, r0, lr, lsl #16 @ 2x2 mod x^2 + 1 done : 4
@ r1, r2, r7, r8, r9, r10, r11, r12
    sadd16 r3, r1, r2
    ssub16 r4, r1, r2 @ r3 r4 = 4x4 mod x^4 - 1 : 1
    sadd16 r1, r7, r8
    ssub16 r2, r7, r8 @ r1 r2 = 4x4 mod x^4 - 1 : 2
    @ sadd16 r7, r9, r10
    @ ssub16 r8, r9, r10 @ r7 r8 = 4x4 mod x^4 - 1 : 3
    @ sadd16 r9, r11, r12
    @ ssub16 r10, r11, r12 @ r9 r10 = 4x4 mod x^4 - 1 : 4
    vmov lr, s20
    @ str.w r3, [lr]
    @ str.w r4, [lr, #4]
    @ str.w r1, [lr, #32]
    @ str.w r2, [lr, #36]
    @ str.w r7, [lr, #64]
    @ str.w r8, [lr, #68]
    @ str.w r9, [lr, #96]
    @ str.w r10, [lr, #100]
@ r5 = qinv, r6 = 4591
    vmov r11, s7 @ w0w1
    vmov r12, s8 @ w2w3
    ldr.w r7, [lr, #8] @ a0a1
    ldr.w r8, [lr, #12] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 1
    @ r3, r4, r7, r8
    sadd16 r9, r3, r7
    sadd16 r10, r4, r8
    ssub16 r7, r3, r7
    ssub16 r8, r4, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 1
    str.w r9, [lr]
    str.w r10, [lr, #4]
    str.w r7, [lr, #8]
    str.w r8, [lr, #12]
    ldr.w r7, [lr, #40] @ a0a1
    ldr.w r8, [lr, #44] @ a2a3
    smuadx r9, r7, r11 @ a0b1 + a1b0
    smuadx r10, r8, r12 @ a2b3 + a3b2
    sub.w r9, r9, r10 @ c1
    smuadx r10, r7, r12
    smladx r10, r8, r11, r10 @ c3
    smmulr r0, r9, r5
    mls r9, r0, r6, r9 @ bar(c1)
    smmulr r0, r10, r5
    mls r10, r0, r6, r10 @ bar(c3)
    pkhbt r0, r7, r8 @ a0a3
    pkhtb r7, r7, r8 @ a2a1
    smusd r8, r0, r12 @ a0b2 - a3b3
    smlad r8, r7, r11, r8 @ c2
    smusd r0, r0, r11 @ a0b0 - a3b1
    smuad r7, r7, r12 @ a2b2 + a1b3
    sub.w r7, r0, r7 @ c0
    smmulr r0, r7, r5
    mls r7, r0, r6, r7 @ bar(c0)
    smmulr r0, r8, r5
    mls r8, r0, r6, r8 @ bar(c2)
    pkhbt r7, r7, r9, lsl #16
    pkhbt r8, r8, r10, lsl #16 @ r7 r8 = 4x4 mod x^4 + 1 : 2
    @ r1, r2, r7, r8
    sadd16 r9, r1, r7
    sadd16 r10, r2, r8
    ssub16 r7, r1, r7
    ssub16 r8, r2, r8 @ r9 r10 r7 r8 = 8x8 mod x^8 - 1 : 2
    str.w r9, [lr, #32]
    str.w r10, [lr, #36]
    str.w r7, [lr, #40]
    str.w r8, [lr, #44]
    @ ldr.w r1, [lr, #72]
    @ ldr.w r2, [lr, #76]
    @ ldr.w r3, [lr, #104]
    @ ldr.w r4, [lr, #108]
    @ smuadx r7, r1, r11 @ a0b1 + a1b0
    @ smuadx r8, r2, r12 @ a2b3 + a3b2
    @ sub.w r7, r7, r8 @ c1
    @ smuadx r8, r1, r12
    @ smladx r8, r2, r11, r8 @ c3
    @ smmulr r0, r7, r5
    @ mls r7, r0, r6, r7 @ bar(c1)
    @ smmulr r0, r8, r5
    @ mls r8, r0, r6, r8 @ bar(c3)
    @ pkhbt r0, r1, r2 @ a0a3
    @ pkhtb r1, r1, r2 @ a2a1
    @ smusd r9, r0, r12 @ a0b2 - a3b3
    @ smlad r9, r1, r11, r9 @ c2
    @ smusd r10, r0, r11 @ a0b0 - a3b1
    @ smuad r2, r1, r12 @ a2b2 + a1b3
    @ sub.w r10, r10, r2 @ c0
    @ smmulr r0, r9, r5
    @ mls r9, r0, r6, r9 @ bar(c0)
    @ smmulr r0, r10, r5
    @ mls r10, r0, r6, r10 @ bar(c2)
    @ pkhbt r1, r9, r7, lsl #16
    @ pkhbt r2, r10, r8, lsl #16 @ r1 r2 = 4x4 mod x^4 + 1 : 3
    @ smuadx r7, r3, r11 @ a0b1 + a1b0
    @ smuadx r8, r4, r12 @ a2b3 + a3b2
    @ sub.w r7, r7, r8 @ c1
    @ smuadx r8, r3, r12
    @ smladx r8, r4, r11, r8 @ c3
    @ smmulr r0, r7, r5
    @ mls r7, r0, r6, r7 @ bar(c1)
    @ smmulr r0, r8, r5
    @ mls r8, r0, r6, r8 @ bar(c3)
    @ pkhbt r0, r3, r4 @ a0a3
    @ pkhtb r3, r3, r4 @ a2a1
    @ smusd r9, r0, r12 @ a0b2 - a3b3
    @ smlad r9, r3, r11, r9 @ c2
    @ smusd r10, r0, r11 @ a0b0 - a3b1
    @ smuad r4, r3, r12 @ a2b2 + a1b3
    @ sub.w r10, r10, r4 @ c0
    @ smmulr r0, r9, r5
    @ mls r9, r0, r6, r9 @ bar(c0)
    @ smmulr r0, r10, r5
    @ mls r10, r0, r6, r10 @ bar(c2)
    @ pkhbt r3, r9, r7, lsl #16
    @ pkhbt r4, r10, r8, lsl #16 @ r3 r4 = 4x4 mod x^4 + 1 : 4
    @ ldr.w r5, [lr, #64]
    @ ldr.w r6, [lr, #68]
    @ ldr.w r7, [lr, #96]
    @ ldr.w r8, [lr, #100]
    @ @ r5, r6, r1, r2
    @ @ r7, r8, r3, r4
    @ sadd16 r9, r5, r1
    @ sadd16 r10, r6, r2
    @ ssub16 r11, r5, r1
    @ ssub16 r12, r6, r2
    @ sadd16 r1, r7, r3
    @ sadd16 r2, r8, r4
    @ ssub16 r3, r7, r3
    @ ssub16 r4, r8, r4
    @ str.w r9, [lr, #64]
    @ str.w r10, [lr, #68]
    @ str.w r11, [lr, #72]
    @ str.w r12, [lr, #76]
    @ str.w r1, [lr, #96]
    @ str.w r2, [lr, #100]
    @ str.w r3, [lr, #104]
    @ str.w r4, [lr, #108]
@ all 8x8 mod x^8 - 1 done
@ 8x8 mod x^8 + 1 : 1
    ldr.w r1, [lr, #16] @ a0a1
    ldr.w r2, [lr, #20] @ a2a3
    ldr.w r3, [lr, #24] @ a4a5
    ldr.w r4, [lr, #28] @ a6a7
    vmov r5, s9 @ b0b1
    vmov r6, s10 @ b2b3
    vmov r7, s11 @ b4b5
    vmov r8, s12 @ b6b7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    sadd16 r0, r1, r9 @ #0
    ssub16 r9, r1, r9 @ #16
    sadd16 r1, r2, r10 @ #4
    ssub16 r10, r2, r10 @ #20
    sadd16 r2, r3, r11 @ #8
    ssub16 r11, r3, r11 @ #24
    sadd16 r3, r4, r12 @ #12
    ssub16 r12, r4, r12 @ #28
    str.w r0, [lr]
    str.w r1, [lr, #4]
    str.w r2, [lr, #8]
    str.w r3, [lr, #12]
    str.w r9, [lr, #16]
    str.w r10, [lr, #20]
    str.w r11, [lr, #24]
    str.w r12, [lr, #28]
@ 8x8 mod x^8 + 1 : 2
    ldr.w r1, [lr, #48] @ a0a1
    ldr.w r2, [lr, #52] @ a2a3
    ldr.w r3, [lr, #56] @ a4a5
    ldr.w r4, [lr, #60] @ a6a7
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub.w r9, r9, r10 @ c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub.w r10, r10, r11 @ c3
    smuadx r11, r1, r7
    smladx r11, r2, r6, r11
    smladx r11, r3, r5, r11
    smuadx r12, r4, r8
    sub.w r11, r11, r12 @ c5
    smuadx r12, r1, r8
    smladx r12, r2, r7, r12
    smladx r12, r3, r6, r12
    smladx r12, r4, r5, r12 @ c7
    vmov s15, r9
    vmov s16, r10
    vmov s17, r11
    vmov s18, r12
    pkhbt r0, r1, r4 @ a0a7
    pkhtb r1, r1, r2 @ a2a1
    pkhtb r2, r2, r3 @ a4a3
    pkhtb r3, r3, r4 @ a6a5
    smusd r9, r0, r5
    smuad r10, r1, r8
    smlad r10, r2, r7, r10
    smlad r10, r3, r6, r10
    sub.w r9, r9, r10 @ c0
    smusd r10, r0, r6
    smlad r10, r1, r5, r10
    smuad r11, r2, r8
    smlad r11, r3, r7, r11
    sub.w r10, r10, r11 @ c2
    smusd r11, r0, r7
    smlad r11, r1, r6, r11
    smlad r11, r2, r5, r11
    smuad r12, r3, r8
    sub.w r11, r11, r12 @ c4
    smusd r12, r0, r8
    smlad r12, r1, r7, r12
    smlad r12, r2, r6, r12
    smlad r12, r3, r5, r12 @ c6
    vmov r1, s4
    mov.w r2, #4591
    vmov r3, s15
    vmov r4, s16
    smmulr r0, r9, r1
    mls r9, r0, r2, r9 @ c0
    smmulr r0, r10, r1
    mls r10, r0, r2, r10 @ c2
    smmulr r0, r11, r1
    mls r11, r0, r2, r11 @ c4
    smmulr r0, r12, r1
    mls r12, r0, r2, r12 @ c6
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c1
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c3
    pkhbt r9, r9, r3, lsl #16 @ c0c1
    pkhbt r10, r10, r4, lsl #16 @ c2c3
    vmov r3, s17
    vmov r4, s18
    smmulr r0, r3, r1
    mls r3, r0, r2, r3 @ c5
    smmulr r0, r4, r1
    mls r4, r0, r2, r4 @ c7
    pkhbt r11, r11, r3, lsl #16 @ c4c5
    pkhbt r12, r12, r4, lsl #16 @ c6c7
    ldr.w r1, [lr, #32]
    ldr.w r2, [lr, #36]
    ldr.w r3, [lr, #40]
    ldr.w r4, [lr, #44]
    vmov r5, s13 @ a0a1
    ldr.w r6, [lr]
    ldr.w r7, [lr, #4]
    ldr.w r8, [lr, #8]
    sadd16 r0, r1, r9 @ # 32 + 0
    ssub16 r9, r1, r9 @ # 32 + 16
    sadd16 r1, r2, r10 @ # 32 + 4
    ssub16 r10, r2, r10 @ # 32 + 20
    sadd16 r2, r3, r11 @ # 32 + 8
    ssub16 r11, r3, r11 @ # 32 + 24
    sadd16 r3, r4, r12 @ # 32 + 12
    ssub16 r12, r4, r12 @ # 32 + 28
    pkhbt r4, r6, r0, lsl #16 @ d0
    pkhtb r6, r0, r6, asr #16 @ d1
    pkhbt r0, r7, r1, lsl #16 @ d2
    pkhtb r7, r1, r7, asr #16 @ d3
    pkhbt r1, r8, r2, lsl #16 @ d4
    pkhtb r8, r2, r8, asr #16 @ d5
    sadd16 r4, r4, r5
    sadd16 r6, r6, r5
    sadd16 r0, r0, r5
    sadd16 r7, r7, r5
    sadd16 r1, r1, r5
    sadd16 r8, r8, r5    
    vmov r2, s1
    str.w r4, [r2, #2520]
    str.w r6, [r2, #1440]
    str.w r0, [r2, #1260]
    str.w r7, [r2, #720]
    str.w r1, [r2, #2160]
    str.w r8, [r2, #360]
    ldr.w r0, [lr, #12]
    ldr.w r1, [lr, #16]
    ldr.w r4, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    pkhbt r8, r0, r3, lsl #16 @ d6
    pkhtb r0, r3, r0, asr #16 @ d7
    pkhbt r3, r1, r9, lsl #16 @ d8
    pkhtb r1, r9, r1, asr #16 @ d9
    pkhbt r9, r4, r10, lsl #16 @ d10
    pkhtb r4, r10, r4, asr #16 @ d11
    pkhbt r10, r6, r11, lsl #16 @ d12
    pkhtb r6, r11, r6, asr #16 @ d13
    pkhbt r11, r7, r12, lsl #16 @ d14
    pkhtb r7, r12, r7, asr #16 @ d15
    sadd16 r8, r8, r5
    sadd16 r0, r0, r5
    sadd16 r3, r3, r5
    sadd16 r1, r1, r5
    sadd16 r9, r9, r5
    sadd16 r4, r4, r5
    sadd16 r10, r10, r5
    sadd16 r6, r6, r5
    sadd16 r11, r11, r5
    sadd16 r7, r7, r5
    str.w r8, [r2, #1080]
    str.w r0, [r2, #180]
    str.w r3, [r2, #540]
    str.w r1, [r2, #1620]
    str.w r9, [r2, #1800]
    str.w r4, [r2, #2340]
    str.w r10, [r2, #900]
    str.w r6, [r2, #2700]
    str.w r11, [r2, #1980]
    str.w r7, [r2, #2880]
    vmov r5, s19
    sbfx r6, r5, #0, #8
    sbfx r7, r5, #8, #8
    @ sbfx r8, r5, #16, #8
    @ sbfx r9, r5, #24, #8
    pkhbt r6, r6, r7, lsl #16
    @ pkhbt r7, r8, r9, lsl #16
    @ vmov s19, r7
    str.w r6, [r2], #4
    vpop {s16-s20}
    pop {r2-r12, pc}

@     vmov s1, r2
@ @ 8x8 mod x^8 + 1 : 3
@     ldr.w r1, [lr, #80] @ a0a1
@     ldr.w r2, [lr, #84] @ a2a3
@     ldr.w r3, [lr, #88] @ a4a5
@     ldr.w r4, [lr, #92] @ a6a7
@     vmov r5, s9 @ b0b1
@     vmov r6, s10 @ b2b3
@     vmov r7, s11 @ b4b5
@     vmov r8, s12 @ b6b7
@     smuadx r9, r1, r5
@     smuadx r10, r2, r8
@     smladx r10, r3, r7, r10
@     smladx r10, r4, r6, r10
@     sub.w r9, r9, r10 @ c1
@     smuadx r10, r1, r6
@     smladx r10, r2, r5, r10
@     smuadx r11, r3, r8
@     smladx r11, r4, r7, r11
@     sub.w r10, r10, r11 @ c3
@     smuadx r11, r1, r7
@     smladx r11, r2, r6, r11
@     smladx r11, r3, r5, r11
@     smuadx r12, r4, r8
@     sub.w r11, r11, r12 @ c5
@     smuadx r12, r1, r8
@     smladx r12, r2, r7, r12
@     smladx r12, r3, r6, r12
@     smladx r12, r4, r5, r12 @ c7
@     vmov s15, r9
@     vmov s16, r10
@     vmov s17, r11
@     vmov s18, r12
@     pkhbt r0, r1, r4 @ a0a7
@     pkhtb r1, r1, r2 @ a2a1
@     pkhtb r2, r2, r3 @ a4a3
@     pkhtb r3, r3, r4 @ a6a5
@     smusd r9, r0, r5
@     smuad r10, r1, r8
@     smlad r10, r2, r7, r10
@     smlad r10, r3, r6, r10
@     sub.w r9, r9, r10 @ c0
@     smusd r10, r0, r6
@     smlad r10, r1, r5, r10
@     smuad r11, r2, r8
@     smlad r11, r3, r7, r11
@     sub.w r10, r10, r11 @ c2
@     smusd r11, r0, r7
@     smlad r11, r1, r6, r11
@     smlad r11, r2, r5, r11
@     smuad r12, r3, r8
@     sub.w r11, r11, r12 @ c4
@     smusd r12, r0, r8
@     smlad r12, r1, r7, r12
@     smlad r12, r2, r6, r12
@     smlad r12, r3, r5, r12 @ c6
@     vmov r1, s4
@     mov.w r2, #4591
@     vmov r3, s15
@     vmov r4, s16
@     smmulr r0, r9, r1
@     mls r9, r0, r2, r9 @ c0
@     smmulr r0, r10, r1
@     mls r10, r0, r2, r10 @ c2
@     smmulr r0, r11, r1
@     mls r11, r0, r2, r11 @ c4
@     smmulr r0, r12, r1
@     mls r12, r0, r2, r12 @ c6
@     smmulr r0, r3, r1
@     mls r3, r0, r2, r3 @ c1
@     smmulr r0, r4, r1
@     mls r4, r0, r2, r4 @ c3
@     pkhbt r9, r9, r3, lsl #16 @ c0c1
@     pkhbt r10, r10, r4, lsl #16 @ c2c3
@     vmov r3, s17
@     vmov r4, s18
@     smmulr r0, r3, r1
@     mls r3, r0, r2, r3 @ c5
@     smmulr r0, r4, r1
@     mls r4, r0, r2, r4 @ c7
@     pkhbt r11, r11, r3, lsl #16 @ c4c5
@     pkhbt r12, r12, r4, lsl #16 @ c6c7
@     ldr.w r1, [lr, #64]
@     ldr.w r2, [lr, #68]
@     ldr.w r3, [lr, #72]
@     ldr.w r4, [lr, #76]
@     sadd16 r0, r1, r9 @ #0
@     ssub16 r9, r1, r9 @ #16
@     sadd16 r1, r2, r10 @ #4
@     ssub16 r10, r2, r10 @ #20
@     sadd16 r2, r3, r11 @ #8
@     ssub16 r11, r3, r11 @ #24
@     sadd16 r3, r4, r12 @ #12
@     ssub16 r12, r4, r12 @ #28
@     str.w r0, [lr, #64]
@     str.w r1, [lr, #68]
@     str.w r2, [lr, #72]
@     str.w r3, [lr, #76]
@     str.w r9, [lr, #80]
@     str.w r10, [lr, #84]
@     str.w r11, [lr, #88]
@     str.w r12, [lr, #92]
@ @ 8x8 mod x^8 + 1 : 4
@     ldr.w r1, [lr, #112] @ a0a1
@     ldr.w r2, [lr, #116] @ a2a3
@     ldr.w r3, [lr, #120] @ a4a5
@     ldr.w r4, [lr, #124] @ a6a7
@     smuadx r9, r1, r5
@     smuadx r10, r2, r8
@     smladx r10, r3, r7, r10
@     smladx r10, r4, r6, r10
@     sub.w r9, r9, r10 @ c1
@     smuadx r10, r1, r6
@     smladx r10, r2, r5, r10
@     smuadx r11, r3, r8
@     smladx r11, r4, r7, r11
@     sub.w r10, r10, r11 @ c3
@     smuadx r11, r1, r7
@     smladx r11, r2, r6, r11
@     smladx r11, r3, r5, r11
@     smuadx r12, r4, r8
@     sub.w r11, r11, r12 @ c5
@     smuadx r12, r1, r8
@     smladx r12, r2, r7, r12
@     smladx r12, r3, r6, r12
@     smladx r12, r4, r5, r12 @ c7
@     vmov s15, r9
@     vmov s16, r10
@     vmov s17, r11
@     vmov s18, r12
@     pkhbt r0, r1, r4 @ a0a7
@     pkhtb r1, r1, r2 @ a2a1
@     pkhtb r2, r2, r3 @ a4a3
@     pkhtb r3, r3, r4 @ a6a5
@     smusd r9, r0, r5
@     smuad r10, r1, r8
@     smlad r10, r2, r7, r10
@     smlad r10, r3, r6, r10
@     sub.w r9, r9, r10 @ c0
@     smusd r10, r0, r6
@     smlad r10, r1, r5, r10
@     smuad r11, r2, r8
@     smlad r11, r3, r7, r11
@     sub.w r10, r10, r11 @ c2
@     smusd r11, r0, r7
@     smlad r11, r1, r6, r11
@     smlad r11, r2, r5, r11
@     smuad r12, r3, r8
@     sub.w r11, r11, r12 @ c4
@     smusd r12, r0, r8
@     smlad r12, r1, r7, r12
@     smlad r12, r2, r6, r12
@     smlad r12, r3, r5, r12 @ c6
@     vmov r1, s4
@     mov.w r2, #4591
@     vmov r3, s15
@     vmov r4, s16
@     smmulr r0, r9, r1
@     mls r9, r0, r2, r9 @ c0
@     smmulr r0, r10, r1
@     mls r10, r0, r2, r10 @ c2
@     smmulr r0, r11, r1
@     mls r11, r0, r2, r11 @ c4
@     smmulr r0, r12, r1
@     mls r12, r0, r2, r12 @ c6
@     smmulr r0, r3, r1
@     mls r3, r0, r2, r3 @ c1
@     smmulr r0, r4, r1
@     mls r4, r0, r2, r4 @ c3
@     pkhbt r9, r9, r3, lsl #16 @ c0c1
@     pkhbt r10, r10, r4, lsl #16 @ c2c3
@     vmov r3, s17
@     vmov r4, s18
@     smmulr r0, r3, r1
@     mls r3, r0, r2, r3 @ c5
@     smmulr r0, r4, r1
@     mls r4, r0, r2, r4 @ c7
@     pkhbt r11, r11, r3, lsl #16 @ c4c5
@     pkhbt r12, r12, r4, lsl #16 @ c6c7
@     ldr.w r1, [lr, #96]
@     ldr.w r2, [lr, #100]
@     ldr.w r3, [lr, #104]
@     ldr.w r4, [lr, #108]
@     vmov r5, s13 @ a0a1
@     ldr.w r6, [lr, #64]
@     ldr.w r7, [lr, #68]
@     ldr.w r8, [lr, #72]
@     sadd16 r0, r1, r9 @ # 32 + 0
@     ssub16 r9, r1, r9 @ # 32 + 16
@     sadd16 r1, r2, r10 @ # 32 + 4
@     ssub16 r10, r2, r10 @ # 32 + 20
@     sadd16 r2, r3, r11 @ # 32 + 8
@     ssub16 r11, r3, r11 @ # 32 + 24
@     sadd16 r3, r4, r12 @ # 32 + 12
@     ssub16 r12, r4, r12 @ # 32 + 28
@     pkhbt r4, r6, r0, lsl #16 @ d0
@     pkhtb r6, r0, r6, asr #16 @ d1
@     pkhbt r0, r7, r1, lsl #16 @ d2
@     pkhtb r7, r1, r7, asr #16 @ d3
@     pkhbt r1, r8, r2, lsl #16 @ d4
@     pkhtb r8, r2, r8, asr #16 @ d5
@     sadd16 r4, r4, r5
@     sadd16 r6, r6, r5
@     sadd16 r0, r0, r5
@     sadd16 r7, r7, r5
@     sadd16 r1, r1, r5
@     sadd16 r8, r8, r5    
@     vmov r2, s1
@     str.w r4, [r2, #2520]
@     str.w r6, [r2, #1440]
@     str.w r0, [r2, #1260]
@     str.w r7, [r2, #720]
@     str.w r1, [r2, #2160]
@     str.w r8, [r2, #360]
@     ldr.w r0, [lr, #76]
@     ldr.w r1, [lr, #80]
@     ldr.w r4, [lr, #84]
@     ldr.w r6, [lr, #88]
@     ldr.w r7, [lr, #92]
@     pkhbt r8, r0, r3, lsl #16 @ d6
@     pkhtb r0, r3, r0, asr #16 @ d7
@     pkhbt r3, r1, r9, lsl #16 @ d8
@     pkhtb r1, r9, r1, asr #16 @ d9
@     pkhbt r9, r4, r10, lsl #16 @ d10
@     pkhtb r4, r10, r4, asr #16 @ d11
@     pkhbt r10, r6, r11, lsl #16 @ d12
@     pkhtb r6, r11, r6, asr #16 @ d13
@     pkhbt r11, r7, r12, lsl #16 @ d14
@     pkhtb r7, r12, r7, asr #16 @ d15
@     sadd16 r8, r8, r5
@     sadd16 r0, r0, r5
@     sadd16 r3, r3, r5
@     sadd16 r1, r1, r5
@     sadd16 r9, r9, r5
@     sadd16 r4, r4, r5
@     sadd16 r10, r10, r5
@     sadd16 r6, r6, r5
@     sadd16 r11, r11, r5
@     sadd16 r7, r7, r5
@     str.w r8, [r2, #1080]
@     str.w r0, [r2, #180]
@     str.w r3, [r2, #540]
@     str.w r1, [r2, #1620]
@     str.w r9, [r2, #1800]
@     str.w r4, [r2, #2340]
@     str.w r10, [r2, #900]
@     str.w r6, [r2, #2700]
@     str.w r11, [r2, #1980]
@     str.w r7, [r2, #2880]
@     vmov r5, s19
@     str.w r5, [r2], #4
@     vmov s1, r2
@     vmov r0, s0