.p2align 2,,3
.syntax unified

.data
buffer: .space 64

.text
.global fft17
@ fft17(int* fpad) ; int16_t fpad[1530] ; 0~764 : coefficients of f, 765~1529 : zero
.type fft17, %function
fft17:
    push {r1-r12, lr}
    adr lr, wpad
    vldm lr, {s1-s10}
    add.w lr, r0, #180
    vmov s13, lr
fft17_body:
    ldr lr, buffer_bridge
    ldr r1, [r0, #1080] @a6
    ldr r2, [r0, #360] @a2
    ldr r3, [r0, #900] @a5
    ldr r4, [r0, #720] @a4
    ldr r5, [r0, #1260] @a7
    ldr r6, [r0, #1440] @a8
    ldr r7, [r0, #540] @a3
    ldr r8, [r0, #180] @a1
    vmov s0, r0
    mov r0, #0
    pkhbt r9, r1, r2, lsl #16 @a6a2
    pkhtb r10, r2, r1, asr #16 @a'6a'2
    pkhbt r11, r5, r6, lsl #16 @a7a8
    pkhtb r12, r6, r5, asr #16 @a'7a'8
    ssub16 r1, r0, r9 @-a6 -a2
    ssub16 r2, r0, r10 @-a'6 -a'2
    sadd16 r5, r9, r11 @ a6+a7 a2+a8
    sadd16 r6, r10, r12
    ssub16 r9, r9, r11 @ a6-a7 a2-a8
    ssub16 r10, r10, r12
    ssub16 r11, r0, r11 @ -a7 -a8
    ssub16 r12, r0, r12
    str r1, [lr, #16]
    str r2, [lr, #48]
    str r5, [lr]
    str r6, [lr, #32]
    str r9, [lr, #8]
    str r10, [lr, #40]
    str r11, [lr, #24]
    str r12, [lr, #56]
    pkhbt r11, r7, r8, lsl #16 @ r11 = a3a1
    pkhtb r12, r8, r7, asr #16 @ r12 = a'3 a'1
    pkhbt r5, r3, r4, lsl #16 @ r5 = a5a4
    pkhtb r6, r4, r3, asr #16 @ r6 = a'5 a'4
    sadd16 r2, r5, r11 @ a5+a3 a4+a1
    sadd16 r1, r6, r12
    ssub16 r3, r0, r4 @ r3 = -a4 -a'4
    ssub16 r4, r5, r11 @ a5-a3 a4-a1
    ssub16 r7, r6, r12
    pkhbt r8, r5, r3, lsl #16 @ a5 -a4
    pkhtb r9, r3, r6 @ a'5 -a'4
    str r11, [lr, #28]
    str r12, [lr, #60]
    str r1, [lr, #36]
    str r7, [lr, #44]
    str r8, [lr, #20]
    str r9, [lr, #52]
@polymul_8x8:
@ mod (x^4 - 1) part
    ldr r1, [lr]
    ldr r3, [lr, #8]
    @ ldm lr, {r1-r4} @ r1 = a0a1, r2 = a2a3, r3 = a4a5, r4 = a6a7
    vmov r5, s1 @ r5 = b0b1
    vmov r6, s2 @ r6 = b2b3
    vmov r7, s3 @ r7 = b4b5
    vmov r8, s4 @ r8 = b6b7
    vmov r0, s9 @ r0 = 935519
    vmov lr, s10 @ lr = 4591
    smuadx r9, r1, r5 @ r9 = a0b1 + a1b0
    smladx r9, r2, r6, r9 @ r9 = a0b1 + a1b0 + a2b3 + a3b2 = c1
    smuadx r10, r1, r6 @ r10 = a0b3 + a1b2
    smladx r10, r2, r5, r10 @ r10 = a0b3 + a1b2 + a2b1 + a3b0 = c3
    pkhbt r11, r1, r2, lsl #16 @ r11 = a0a2
    pkhtb r12, r2, r1, asr #16 @ r12 = a1a3
    pkhbt r1, r5, r6, lsl #16 @ r1 = b0b2
    pkhtb r2, r6, r5, asr #16 @ r2 = b1b3
    smuadx r5, r12, r2 @ r5 = a1b3 + a3b1
    smlad r5, r11, r1, r5 @ r5 = a0b0 + a1b3 + a2b2 +a3b1 = c0
    smuadx r6, r11, r1 @ r6 = a0b2 + a2b0
    smlad r6, r12, r2, r6 @ r6 = a0b2 + a1b1 + a2b0 + a3b3 = c2
    smmulr r1, r5, r0 
    mls r5, r1, lr, r5 @ r5 = barrett(c0)
    smmulr r1, r9, r0
    mls r9, r1, lr, r9 @ r9 = barrett(c1)
    smmulr r1, r6, r0
    mls r6, r1, lr, r6 @ r6 = barrett(c2)
    smmulr r1, r10, r0
    mls r10, r1, lr, r10 @ r10 = barrett(c3)
    pkhbt r1, r5, r9, lsl #16 @ r1 = c0c1
    pkhbt r2, r6, r10, lsl #16 @ r2 = c2c3
@(x^4 - 1) part done, r1 = c0c1, r2 = c2c3
@(x^4 + 1) part, r3 = a0a1, r4 = a2a3, r7 = b0b1, r8 = b2b3
@ r1 r2 not free
    smuadx r5, r3, r7 @ r5 = a0b1 + a1b0
    smuadx r6, r4, r8 @ r6 = a2b3 + a3b2
    sub r5, r5, r6 @ r5 = a0b1 + a1b0 - a2b3 - a3b2 = c1
    smuadx r6, r3, r8 @ r6 = a0b3 + a1b2
    smladx r6, r4, r7, r6 @ r6 = a0b3 + a1b2 + a2b1 + a3b0 = c3
    pkhbt r9, r3, r4, lsl #16 @ r9 = a0a2
    pkhtb r10, r4, r3, asr #16 @ r10 = a1a3
    pkhbt r11, r7, r8, lsl #16 @ r11 = b0b2
    pkhtb r12, r8, r7, asr #16 @ r12 = b1b3
    smusd r3, r9, r11 @ r3 = a0b0 - a2b2
    smuadx r4, r10, r12 @ r4 = a1b3 + a3b1
    sub r3, r3, r4 @ r3 = a0b0 - a2b2 - a1b3 - a3b1 = c0
    smusd r7, r10, r12 @ r7 = a1b1 - a3b3
    smladx r4, r9, r11, r7 @ r4 = a0b2 + a1b1 + a2b0 - a3b3 = c2
    smmulr r7, r3, r0
    mls r3, r7, lr, r3 @ r3 = barrett(c0)
    smmulr r7, r5, r0
    mls r5, r7, lr, r5 @ r5 = barrett(c1)
    smmulr r7, r4, r0
    mls r4, r7, lr, r4 @ r4 = barrett(c2)
    smmulr r7, r6, r0
    mls r6, r7, lr, r6 @ r6 = barrett(c3)
    pkhbt r3, r3, r5, lsl #16 @ r3 = c0c1
    pkhbt r4, r4, r6, lsl #16 @ r4 = c2c3
    sadd16 r5, r1, r3 @ r5 = d0d1
    sadd16 r6, r2, r4 @ r6 = d2d3
    ssub16 r7, r1, r3 @ r7 = d4d5
    ssub16 r8, r2, r4 @ r8 = d6d7
@ back to (x^8 - 1) done
    ldr lr, buffer_bridge
    stm lr, {r5-r8}
@ 8x8 mod (x^8 - 1) done    
    ldr r1, [lr, #16] @ r1 = a0a1
    ldr r2, [lr, #20] @ r2 = a2a3
    ldr r3, [lr, #24] @ r3 = a4a5
    ldr r4, [lr, #28] @ r4 = a6a7
    vmov r5, s5 @ r5 = b0b1
    vmov r6, s6 @ r6 = b2b3
    vmov r7, s7 @ r7 = b4b5
    vmov r8, s8 @ r8 = b6b7
    vmov lr, s10
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10 @ r9 = c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11 @ r10 = c3
    smmulr r11, r9, r0
    mls r9, r11, lr, r9 @ r9 = barrett(c1)
    smmulr r11, r10, r0
    mls r10, r11, lr, r10 @ r10 = barrett(c3)
    pkhbt r9, r9, r10, lsl #16 @ r9 = c1c3
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11 @ r10 = c5
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11 @ r11 = c7
    smmulr r12, r10, r0
    mls r10, r12, lr, r10 @ r10 = barrett(c5)
    smmulr r12, r11, r0
    mls r11, r12, lr, r11 @ r11 = barrett(c7)
    pkhbt r10, r10, r11, lsl #16 @ r10 = c5c7
    pkhbt r11, r1, r3, lsl #16 @ r11 = a0a4
    pkhtb r12, r3, r1, asr #16 @ r12 = a1a5
    pkhbt r1, r2, r4, lsl #16 @ r1 = a2a6
    pkhtb r3, r4, r2, asr #16 @ r3 = a3a7
    pkhbt r2, r5, r7, lsl #16 @ r2 = b0b4
    pkhtb r4, r7, r5, asr #16 @ r4 = b1b5
    pkhbt r5, r6, r8, lsl #16 @ r5 = b2b6
    pkhtb r7, r8, r6, asr #16 @ r7 = b3b7
    vmov s11, r9 @ s11 = c1c3
    vmov s12, r10 @ s12 = c5c7
@ free : r6, r8, r9, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8 @ r6 = c0
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9 @ r8 = c2
    smmulr r9, r6, r0
    mls r6, r9, lr, r6 @ r6 = barrett(c0)
    smmulr r9, r8, r0
    mls r8, r9, lr, r8 @ r8 = barrett(c2)
    pkhbt r6, r6, r8, lsl #16 @ r6 = c0c2
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8 @ r8 = c4
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9 @ r9 = c6
    smmulr r10, r8, r0
    mls r8, r10, lr, r8 @ r8 = barrett(c4)
    smmulr r10, r9, r0
    mls r9, r10, lr, r9 @ r9 = barrett(c6)
    vmov r10, s11 @ r10 = c1c3
    vmov r11, s12 @ r11 = c5c7
    pkhbt r1, r6, r10, lsl #16 @ r1 = c0c1
    pkhtb r2, r10, r6, asr #16 @ r2 = c2c3
    pkhbt r3, r8, r11, lsl #16 @ r3 = c4c5
    pkhtb r4, r11, r9 @ r4 = c6c7
@ 8x8 mod (x^8 + 1) done
    ldr r0, buffer_bridge
    ldm r0, {r5-r8}
    sadd16 r9, r5, r1 @ r9 = d0d1
    ssub16 r10, r5, r1 @ r10 = d8d9
    sadd16 r11, r6, r2 @ r11 = d2d3
    ssub16 r12, r6, r2 @ r12 = d10d11
    sadd16 r1, r7, r3 @ r1 = d4d5
    ssub16 r2, r7, r3 @ r2 = d12d13
    sadd16 r3, r8, r4 @ r3 = d6d7
    ssub16 r4, r8, r4 @ r4 = d14 0
    vmov lr, s0
    ldr r5, [lr] @ r5 = a0a1
    pkhbt r6, r5, r5, lsl #16 @ r6 = a0a0
    pkhtb r7, r5, r5, asr #16 @ r7 = a1a1
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    vmov s15, r7
    str r9, [r0]
    str r11, [r0, #4]
    str.w r1, [r0, #8]
    str.w r3, [r0, #12]
    str r10, [r0, #16]
    str r12, [r0, #20]
    str.w r2, [r0, #24]
    str.w r4, [r0, #28]
@ convolution done 1

    vmov r12, s9 @ r12 = 935519
    vmov r11, s10 @ r11 = 4591
    ldr r1, [lr] @ r1 = a0a1
    ldr r2, [lr, #180] @ r2 = a90a91
    ldr r3, [lr, #360]
    ldr r4, [lr, #540]
    ldr r5, [lr, #720]
    ldr r6, [lr, #900]
    ldr r7, [lr, #1080]
    ldr r8, [lr, #1260]
    ldr r9, [lr, #1440]
    sadd16 r1, r1, r2
    sadd16 r1, r1, r3
    sadd16 r1, r1, r4
    sadd16 r1, r1, r5
    sadd16 r1, r1, r6
    sadd16 r1, r1, r7
    sadd16 r1, r1, r8
    sadd16 r1, r1, r9
    ubfx r3, r1, #0, #16
    smmulr r4, r3, r12
    mls r3, r4, r11, r3 @ r3 = barrett(a0+a90+...)
    ubfx r5, r1, #16, #16
    smmulr r4, r5, r12
    mls r5, r4, r11, r5
    pkhbt r3, r3, r5, lsl #16
    vmov s14, r3

@ a0 + a90 +... done

    ldr lr, buffer_bridge+4
    ldm lr, {r1-r4} @ r1 = a0a1, r2 = a2a3, r3 = a4a5, r4 = a6a7
    vmov r5, s1 @ r5 = b0b1
    vmov r6, s2 @ r6 = b2b3
    vmov r7, s3 @ r7 = b4b5
    vmov r8, s4 @ r8 = b6b7
    vmov r0, s9 @ r0 = 935519
    vmov lr, s10 @ lr = 4591
    smuadx r9, r1, r5 @ r9 = a0b1 + a1b0
    smladx r9, r2, r6, r9 @ r9 = a0b1 + a1b0 + a2b3 + a3b2 = c1
    smuadx r10, r1, r6 @ r10 = a0b3 + a1b2
    smladx r10, r2, r5, r10 @ r10 = a0b3 + a1b2 + a2b1 + a3b0 = c3
    pkhbt r11, r1, r2, lsl #16 @ r11 = a0a2
    pkhtb r12, r2, r1, asr #16 @ r12 = a1a3
    pkhbt r1, r5, r6, lsl #16 @ r1 = b0b2
    pkhtb r2, r6, r5, asr #16 @ r2 = b1b3
    smuadx r5, r12, r2 @ r5 = a1b3 + a3b1
    smlad r5, r11, r1, r5 @ r5 = a0b0 + a1b3 + a2b2 +a3b1 = c0
    smuadx r6, r11, r1 @ r6 = a0b2 + a2b0
    smlad r6, r12, r2, r6 @ r6 = a0b2 + a1b1 + a2b0 + a3b3 = c2
    smmulr r1, r5, r0 
    mls r5, r1, lr, r5 @ r5 = barrett(c0)
    smmulr r1, r9, r0
    mls r9, r1, lr, r9 @ r9 = barrett(c1)
    smmulr r1, r6, r0
    mls r6, r1, lr, r6 @ r6 = barrett(c2)
    smmulr r1, r10, r0
    mls r10, r1, lr, r10 @ r10 = barrett(c3)
    pkhbt r1, r5, r9, lsl #16 @ r1 = c0c1
    pkhbt r2, r6, r10, lsl #16 @ r2 = c2c3
@(x^4 - 1) part done, r1 = c0c1, r2 = c2c3
@(x^4 + 1) part, r3 = a0a1, r4 = a2a3, r7 = b0b1, r8 = b2b3
@ r1 r2 not free
    smuadx r5, r3, r7 @ r5 = a0b1 + a1b0
    smuadx r6, r4, r8 @ r6 = a2b3 + a3b2
    sub r5, r5, r6 @ r5 = a0b1 + a1b0 - a2b3 - a3b2 = c1
    smuadx r6, r3, r8 @ r6 = a0b3 + a1b2
    smladx r6, r4, r7, r6 @ r6 = a0b3 + a1b2 + a2b1 + a3b0 = c3
    pkhbt r9, r3, r4, lsl #16 @ r9 = a0a2
    pkhtb r10, r4, r3, asr #16 @ r10 = a1a3
    pkhbt r11, r7, r8, lsl #16 @ r11 = b0b2
    pkhtb r12, r8, r7, asr #16 @ r12 = b1b3
    smusd r3, r9, r11 @ r3 = a0b0 - a2b2
    smuadx r4, r10, r12 @ r4 = a1b3 + a3b1
    sub r3, r3, r4 @ r3 = a0b0 - a2b2 - a1b3 - a3b1 = c0
    smusd r7, r10, r12 @ r7 = a1b1 - a3b3
    smladx r4, r9, r11, r7 @ r4 = a0b2 + a1b1 + a2b0 - a3b3 = c2
    smmulr r7, r3, r0
    mls r3, r7, lr, r3 @ r3 = barrett(c0)
    smmulr r7, r5, r0
    mls r5, r7, lr, r5 @ r5 = barrett(c1)
    smmulr r7, r4, r0
    mls r4, r7, lr, r4 @ r4 = barrett(c2)
    smmulr r7, r6, r0
    mls r6, r7, lr, r6 @ r6 = barrett(c3)
    pkhbt r3, r3, r5, lsl #16 @ r3 = c0c1
    pkhbt r4, r4, r6, lsl #16 @ r4 = c2c3
    sadd16 r5, r1, r3 @ r5 = d0d1
    sadd16 r6, r2, r4 @ r6 = d2d3
    ssub16 r7, r1, r3 @ r7 = d4d5
    ssub16 r8, r2, r4 @ r8 = d6d7
@ back to (x^8 - 1) done
    ldr lr, buffer_bridge+4
    stm lr, {r5-r8}

@ 8x8 mod (x^8 - 1) done

    ldr r1, [lr, #16] @ r1 = a0a1
    ldr r2, [lr, #20] @ r2 = a2a3
    ldr r3, [lr, #24] @ r3 = a4a5
    ldr r4, [lr, #28] @ r4 = a6a7
    vmov r5, s5 @ r5 = b0b1
    vmov r6, s6 @ r6 = b2b3
    vmov r7, s7 @ r7 = b4b5
    vmov r8, s8 @ r8 = b6b7
    vmov lr, s10
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10 @ r9 = c1
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11 @ r10 = c3
    smmulr r11, r9, r0
    mls r9, r11, lr, r9 @ r9 = barrett(c1)
    smmulr r11, r10, r0
    mls r10, r11, lr, r10 @ r10 = barrett(c3)
    pkhbt r9, r9, r10, lsl #16 @ r9 = c1c3
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11 @ r10 = c5
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11 @ r11 = c7
    smmulr r12, r10, r0
    mls r10, r12, lr, r10 @ r10 = barrett(c5)
    smmulr r12, r11, r0
    mls r11, r12, lr, r11 @ r11 = barrett(c7)
    pkhbt r10, r10, r11, lsl #16 @ r10 = c5c7
    pkhbt r11, r1, r3, lsl #16 @ r11 = a0a4
    pkhtb r12, r3, r1, asr #16 @ r12 = a1a5
    pkhbt r1, r2, r4, lsl #16 @ r1 = a2a6
    pkhtb r3, r4, r2, asr #16 @ r3 = a3a7
    pkhbt r2, r5, r7, lsl #16 @ r2 = b0b4
    pkhtb r4, r7, r5, asr #16 @ r4 = b1b5
    pkhbt r5, r6, r8, lsl #16 @ r5 = b2b6
    pkhtb r7, r8, r6, asr #16 @ r7 = b3b7
    vmov s11, r9 @ s11 = c1c3
    vmov s12, r10 @ s12 = c5c7
@ free : r6, r8, r9, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8 @ r6 = c0
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9 @ r8 = c2
    smmulr r9, r6, r0
    mls r6, r9, lr, r6 @ r6 = barrett(c0)
    smmulr r9, r8, r0
    mls r8, r9, lr, r8 @ r8 = barrett(c2)
    pkhbt r6, r6, r8, lsl #16 @ r6 = c0c2
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8 @ r8 = c4
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9 @ r9 = c6
    smmulr r10, r8, r0
    mls r8, r10, lr, r8 @ r8 = barrett(c4)
    smmulr r10, r9, r0
    mls r9, r10, lr, r9 @ r9 = barrett(c6)
    vmov r10, s11 @ r10 = c1c3
    vmov r11, s12 @ r11 = c5c7
    pkhbt r1, r6, r10, lsl #16 @ r1 = c0c1
    pkhtb r2, r10, r6, asr #16 @ r2 = c2c3
    pkhbt r3, r8, r11, lsl #16 @ r3 = c4c5
    pkhtb r4, r11, r9 @ r4 = c6c7
@ 8x8 mod (x^8 + 1) done
    ldr.w r0, buffer_bridge+4
    ldm r0, {r5-r8}
    vmov lr, s15
    sadd16 r9, r5, r1 @ r9 = d0d1
    ssub16 r10, r5, r1 @ r10 = d8d9
    sadd16 r11, r6, r2 @ r11 = d2d3
    ssub16 r12, r6, r2 @ r12 = d10d11
    sadd16 r1, r7, r3 @ r1 = d4d5
    ssub16 r2, r7, r3 @ r2 = d12d13
    sadd16 r3, r8, r4 @ r3 = d6d7
    ssub16 r4, r8, r4 @ r4 = d14 0
    @ vmov lr, s0
    @ vmov r5, s15
    @ ldr r5, [lr] @ r5 = a0a1
    @ pkhtb r5, r5, r5, asr #16 @ r5 = a1a1
    sadd16 r9, r9, lr
    sadd16 r10, r10, lr
    sadd16 r11, r11, lr
    sadd16 r12, r12, lr
    sadd16 r1, r1, lr
    sadd16 r2, r2, lr
    sadd16 r3, r3, lr
    sadd16 r4, r4, lr
    @ str r9, [r0] @ r9 = y14y8
    @ str r11, [r0, #4] @ r11 = y7y4
    @ str.w r1, [r0, #8] @ r1 = y12y2
    @ str.w r3, [r0, #12] @ r3 = y6y1
    @ str r10, [r0, #16] @ r10 = y3y9
    @ str r12, [r0, #20] @ r12 = y10y13
    @ str.w r2, [r0, #24] @ r2 = y5y15
    str.w r4, [r0, #28] @ r4 = y11y16
@ convolution done 2

@ 14 8 7 4, 12 2 6 1, 3 9 10 13, 5 15 11 16
    vmov r0, s0
    ldr.w lr, buffer_bridge
@ free : 45678
    ldr.w r4, [lr] @ r4 = x14x8
    ldr.w r5, [lr, #4] @ r5 = x7x4
    ldr.w r6, [lr, #8] @ r6 = x12x2
    pkhbt r7, r4, r9, lsl #16 @ r7 = x14y14
    pkhtb r8, r9, r4, asr #16 @ r8 = x8y8
    pkhbt r4, r5, r11, lsl #16 @ r4 = x7y7
    pkhtb r9, r11, r5, asr #16 @ r9 = x4y4
    pkhbt r5, r6, r1, lsl #16 @ r5 = x12y12
    pkhtb r11, r1, r6, asr #16 @ r11 = x2y2
    str r7, [r0, #2520]
    str r8, [r0, #1440]
    str r4, [r0, #1260]
    str r9, [r0, #720]
    str r5, [r0, #2160]
    str r11, [r0, #360]
@ not free : 2, 3, 10, 12
    ldr.w r1, [lr, #12] @ r1 = x6x1
    ldr.w r4, [lr, #16] @ r4 = x3x9
    ldr.w r5, [lr, #20] @ r5 = x10x13
    ldr.w r6, [lr, #24] @ r6 = x5x15
    ldr.w r7, [lr, #28] @ r7 = x11x16
    ldr.w r8, [lr, #60] @ r8 = y11y16
    pkhbt r9, r1, r3, lsl #16 @ r9 = x6y6
    pkhtb r11, r3, r1, asr #16 @ r11 = x1y1
    pkhbt r1, r4, r10, lsl #16 @ r1 = x3y3
    pkhtb r3, r10, r4, asr #16 @ r3 = x9y9
    pkhbt r4, r5, r12, lsl #16 @ r4 = x10y10
    pkhtb r10, r12, r5, asr #16 @ r10 = x13y13
    pkhbt r5, r6, r2, lsl #16 @ r5 = x5y5
    pkhtb r12, r2, r6, asr #16 @ r12 = x15y15
    pkhbt r2, r7, r8, lsl #16 @ r2 = x11y11
    pkhtb r6, r8, r7, asr #16 @ r6 = x16y16
    str r9, [r0, #1080]
    str r11, [r0, #180]
    str r1, [r0, #540]
    str r3, [r0, #1620]
    str r4, [r0, #1800]
    str r10, [r0, #2340]
    str r5, [r0, #900]
    str r12, [r0, #2700]
    str r2, [r0, #1980]
    str r6, [r0, #2880]
    vmov r1, s14
    str.w r1, [r0]
    vmov lr, s13
    add.w r0, r0, #4
    cmp.w r0, lr
    bne.w fft17_body

    pop {r1-r12, pc}

buffer_bridge:
    .word buffer
    .word buffer+32

wpad:
    .word 127400945
    .word 4248566465
    .word 61146163
    .word 4158194321
    .word 28375972
    .word 25823139
    .word 4251253512
    .word 4220778258
    .word 935519
    .word 4591
