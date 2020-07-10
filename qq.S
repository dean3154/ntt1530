.p2align 2,,3
.syntax unified

.data
buffer: .space 64
mul_buffer: .space 16

.text
.global fft17
.type fft17, %function
fft17:
    push {r1-r12, lr}
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
    pkhbt r11, r3, r4, lsl #16 @a5a4
    pkhtb r12, r4, r3, asr #16 @a'5a'4
    ssub16 r1, r0, r9 @-a6a2
    ssub16 r2, r0, r10 @-a'6a'2
    str r9, [lr]
    str r11, [lr, #4]
    str r1, [lr, #16]
    str r10, [lr, #32]
    str r12, [lr, #36]
    str r2, [lr, #48]
    ssub16 r11, r0, r11 @-a5 -a4
    ssub16 r12, r0, r12 @-a'5 -a'4
    pkhbt r11, r3, r11 @a5 -a4
    pkhtb r12, r12, r3, asr #16 @a'5 -a'4
    pkhbt r1, r5, r6, lsl #16 @a7a8
    pkhtb r2, r6, r5, asr #16
    pkhbt r3, r7, r8, lsl #16 @a3a1
    pkhtb r4, r8, r7, asr #16
    ssub16 r5, r0, r1 
    ssub16 r6, r0, r2
    str r11, [lr, #20]
    str r12, [lr, #52]
    str r1, [lr, #8]
    str r2, [lr, #40]
    str r3, [lr, #12]
    str r3, [lr, #28]
    str r4, [lr, #44]
    str r4, [lr, #60]
    str r5, [lr, #24]
    str r6, [lr, #56]
polymul_8x8:
    adr r0, wpad
    vldm r0, {s1-s10}
    ldr r1, [lr] @ r1 = a0a1
    ldr r2, [lr, #4] @ r2 = a2a3
    vmov r0, s9 @ r0 = 935519
    vmov lr, s10 @ lr = 4591
    vmov r3, s1 @ r3 = b0b1
    vmov r4, s2 @ r4 = b2b3
    smulbb r5, r1, r3 @ r5 = a0b0 = c0
    smulbb r6, r1, r4 @ r6 = a0b2
    smuadx r7, r1, r3 @ r7 = a0b1 + a1b0 = c1
    smuadx r8, r1, r4 @ r8 = a0b3 + a1b2
    smuadx r9, r2, r4 @ r9 = a2b3 + a3b2
    smultt r10, r2, r3 @ r10 = a3b1
    smultt r11, r2, r4 @ r11 = a3b3
    smladx r12, r2, r3, r8 @ r12 = c3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r6, r1, r3, r6 @ r6 = c2
    smlad r10, r1, r4 ,r10 @ r10 = a1b3 + a2b2 + a3b1
    smmulr r1, r5, r0 @ round(c0/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c0)
    smmulr r1, r7, r0
    mls r7, r1, lr, r7 @ r7 = barrett(c1)
    pkhbt r5, r5, r7, lsl #16 @ r5 = c0c1
    smmulr r1, r6, r0
    mls r6, r1, lr, r6 @ r6 = barrett(c2)
    smmulr r1, r12, r0
    mls r12, r1, lr, r12 @ r12 = barrett(c3)
    pkhbt r6, r6, r12, lsl #16 @ r6 = c2c3
    ldr r12, mul_buffer_bridge @ r12 = mul_buffer addr
    str r5, [r12] @ store c0c1
    str r6, [r12, #4] @ store c2c3
    ldr r0, buffer_bridge
    ldr r1, [r0, #8] @ r1 = a4a5
    ldr r2, [r0, #12] @ r2 = a6a7
    smlabb r10, r1, r3, r10 @ r10 = a1b3 + a2b2 + a3b1 +a4b0
    smlabb r11, r1, r4, r11 @ r11 = a3b3 + a4b2  
    smladx r9, r1, r3, r9 @ r9 = a2b3 + a3b2 + a4b1 + a5b0
    smuadx r5, r1, r4 @ r5 = a4b3 + a5b2
    smuadx r6, r2, r4 @ r6 = a6b3 + a7b2
    smultt r7, r2, r3 @ r7 = a7b1
    smultt r12, r2, r4 @ r12 = a7b3
    smladx r5, r2, r3, r5 @ r5 = a4b3 + a5b2 + a6b1 + a7b0
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad r11, r1, r3, r11 @ r11 = a3b3 + a4b2 + a5b1 + a6b0
    smlad r7, r1, r4, r7 @ r7 = a5b3 + a6b2 + a7b1
    vmov r3, s3 @ r3 = b4b5
    vmov r4, s4 @ r4 = b6b7
    ldr r1, [r0] @ r1 = a0a1
    ldr r2, [r0, #4] @ r2 = a2a3
    smlabb r10, r1, r3, r10 @ r10 = c4
    smlabb r11, r1, r4, r11 @ r11 = a0b6 + a3b3 + a4b2 + a5b1 +a6b0
    smladx r9, r1, r3, r9 @ r9 = c5
    smladx r5, r1, r4, r5 
    smladx r5, r2, r3, r5 @ r5 = c7
    smladx r6, r2, r4, r6 @ r6 = a2b7 + a3b6 + a6b3 + a7b2
    smlatt r7, r2, r3, r7 @ r7 = a3b5 + a5b3 + a6b2 + a7b1
    smlatt r12, r2, r4, r12 @ r12 = a3b7 + a7b3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r11, r1, r3, r11 @ r11 = c6
    smlad r7, r1, r4, r7 @ r7 = a1b7 + a2b6 + a3b5 + a5b3 + a6b2 +a7b1
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r10, r0 @ r1 = round(c4/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c4)
    smmulr r1, r9, r0 @ r1 = round(c5/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c5)
    pkhbt r10, r10, r9, lsl #16 @ r10 = c4c5
    smmulr r1, r11, r0 @ r1 = round(c6/q)
    mls r11, r1, lr, r11 @ r11 = barrett(c6)
    smmulr r1, r5, r0 @ r1 = round(c7/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c7)
    pkhbt r11, r11, r5, lsl #16 @ r11 = c6c7
    ldr r0, mul_buffer_bridge
    str r10, [r0, #8] @ store c4c5
    str r11, [r0, #12] @store c6c7
    ldr r0, buffer_bridge
    ldr r1, [r0, #8] @ r1 = a4a5
    ldr r2, [r0, #12] @ r2 = a6a7
    smlabb r7, r1, r3, r7 @ r7 = a1b7 + a2b6 + a3b5 + a4b4 + a5b3 + a6b2 +a7b1 = c8
    smlabb r12, r1, r4, r12 @ r12 = a3b7 + a4b6 + a7b3
    smladx r6, r1, r3, r6 @ r6 = a2b7 + a3b6 + a4b5 + a5b4 + a6b3 + a7b2 = c9
    smuadx r5, r1, r4 @ r5 = a4b7 + a5b6
    smuadx r8, r2, r4 @ r8 = a6b7 + a7b6 = c13
    smultt r9, r2, r3 @ r9 = a7b5
    smultt r10, r2, r4 @ r10 = a7b7 = c14
    smladx r5, r2, r3, r5 @ r5 = a4b7 + a5b6 + a6b5 + a7b4 = c11
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad.w r12, r1, r3, r12 @ r12 = a3b7 + a4b6 + a5b5 + a6b4 + a7b3 = c10
    smlad.w r9, r1, r4, r9 @ r9 = a5b7 + a6b6 + a7b5 = c12
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r7, r0 @ r1 = round(c8/q)
    mls r7, r1, lr, r7 @ r7 = barrett(c8)
    smmulr r1, r6, r0 @ r1 = round(c9/q)
    mls r6, r1, lr, r6 @ r6 = barrett(c9)
    pkhbt r7, r7, r6, lsl #16 @ r7 = c8c9
    smmulr r1, r12, r0 @ r1 = round(c10/q)
    mls r12, r1, lr, r12 @ r12 = barrett(c10)
    smmulr r1, r5, r0 @ r1 = round(c11/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c11)
    pkhbt r12, r12, r5, lsl #16 @ r12 = c10c11
    smmulr r1, r9, r0 @ r1 = round(c12/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c12)
    smmulr r1, r8, r0 @ r1 = round(c13/q)
    mls r8, r1, lr, r8 @ r8 = barrett(c13)
    pkhbt r9, r9, r8, lsl #16 @ r9 = c12c13
    smmulr r1, r10, r0 @ r1 = round(c14/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c14)
    ubfx r10, r10, #0, #16 @ r10 = c14 0 
    ldr r0, mul_buffer_bridge
    ldm r0, {r1-r4} @ r1 = c0c1, r2 = c2c3, r3 = c4c5, r4 = c6c7
    sadd16 r1, r1, r7 @ r1 = (c0 + c8) (c1 + c9)
    sadd16 r2, r2, r12 @ r2 = (c2 + c10) (c3 + c11)
    sadd16 r3, r3, r9 @ r3 = (c4 + c12) (c5 + c13)
    sadd16 r4, r4, r10 @ r4 = (c6 + c14) (c7)
    ldr r0, buffer_bridge
    stm r0, {r1-r4}
@ 8x8 mod (x^8 - 1) done
    ldr lr, buffer_bridge
    ldr r1, [lr, #16] @ r1 = a0a1
    ldr r2, [lr, #20] @ r2 = a2a3
    vmov r0, s9 @ r0 = 935519
    vmov lr, s10 @ lr = 4591
    vmov r3, s5 @ r3 = b0b1
    vmov r4, s6 @ r4 = b2b3
    smulbb r5, r1, r3 @ r5 = a0b0 = c0
    smulbb r6, r1, r4 @ r6 = a0b2
    smuadx r7, r1, r3 @ r7 = a0b1 + a1b0 = c1
    smuadx r8, r1, r4 @ r8 = a0b3 + a1b2
    smuadx r9, r2, r4 @ r9 = a2b3 + a3b2
    smultt r10, r2, r3 @ r10 = a3b1
    smultt r11, r2, r4 @ r11 = a3b3
    smladx r12, r2, r3, r8 @ r12 = c3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r6, r1, r3, r6 @ r6 = c2
    smlad r10, r1, r4 ,r10 @ r10 = a1b3 + a2b2 + a3b1
    smmulr r1, r5, r0 @ round(c0/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c0)
    smmulr r1, r7, r0
    mls r7, r1, lr, r7 @ r7 = barrett(c1)
    pkhbt r5, r5, r7, lsl #16 @ r5 = c0c1
    smmulr r1, r6, r0
    mls r6, r1, lr, r6 @ r6 = barrett(c2)
    smmulr r1, r12, r0
    mls r12, r1, lr, r12 @ r12 = barrett(c3)
    pkhbt r6, r6, r12, lsl #16 @ r6 = c2c3
    ldr r12, mul_buffer_bridge @ r12 = mul_buffer addr
    str r5, [r12] @ store c0c1
    str r6, [r12, #4] @ store c2c3
    ldr r0, buffer_bridge
    ldr r1, [r0, #24] @ r1 = a4a5
    ldr r2, [r0, #28] @ r2 = a6a7
    smlabb r10, r1, r3, r10 @ r10 = a1b3 + a2b2 + a3b1 +a4b0
    smlabb r11, r1, r4, r11 @ r11 = a3b3 + a4b2  
    smladx r9, r1, r3, r9 @ r9 = a2b3 + a3b2 + a4b1 + a5b0
    smuadx r5, r1, r4 @ r5 = a4b3 + a5b2
    smuadx r6, r2, r4 @ r6 = a6b3 + a7b2
    smultt r7, r2, r3 @ r7 = a7b1
    smultt r12, r2, r4 @ r12 = a7b3
    smladx r5, r2, r3, r5 @ r5 = a4b3 + a5b2 + a6b1 + a7b0
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad r11, r1, r3, r11 @ r11 = a3b3 + a4b2 + a5b1 + a6b0
    smlad r7, r1, r4, r7 @ r7 = a5b3 + a6b2 + a7b1
    vmov r3, s7 @ r3 = b4b5
    vmov r4, s8 @ r4 = b6b7
    ldr r1, [r0, #16] @ r1 = a0a1
    ldr r2, [r0, #20] @ r2 = a2a3
    smlabb r10, r1, r3, r10 @ r10 = c4
    smlabb r11, r1, r4, r11 @ r11 = a0b6 + a3b3 + a4b2 + a5b1 +a6b0
    smladx r9, r1, r3, r9 @ r9 = c5
    smladx r5, r1, r4, r5 
    smladx r5, r2, r3, r5 @ r5 = c7
    smladx r6, r2, r4, r6 @ r6 = a2b7 + a3b6 + a6b3 + a7b2
    smlatt r7, r2, r3, r7 @ r7 = a3b5 + a5b3 + a6b2 + a7b1
    smlatt r12, r2, r4, r12 @ r12 = a3b7 + a7b3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r11, r1, r3, r11 @ r11 = c6
    smlad r7, r1, r4, r7 @ r7 = a1b7 + a2b6 + a3b5 + a5b3 + a6b2 +a7b1
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r10, r0 @ r1 = round(c4/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c4)
    smmulr r1, r9, r0 @ r1 = round(c5/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c5)
    pkhbt r10, r10, r9, lsl #16 @ r10 = c4c5
    smmulr r1, r11, r0 @ r1 = round(c6/q)
    mls r11, r1, lr, r11 @ r11 = barrett(c6)
    smmulr r1, r5, r0 @ r1 = round(c7/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c7)
    pkhbt r11, r11, r5, lsl #16 @ r11 = c6c7
    ldr r0, mul_buffer_bridge
    str r10, [r0, #8] @ store c4c5
    str r11, [r0, #12] @store c6c7
    ldr r0, buffer_bridge
    ldr r1, [r0, #24] @ r1 = a4a5
    ldr r2, [r0, #28] @ r2 = a6a7
    smlabb r7, r1, r3, r7 @ r7 = a1b7 + a2b6 + a3b5 + a4b4 + a5b3 + a6b2 +a7b1 = c8
    smlabb r12, r1, r4, r12 @ r12 = a3b7 + a4b6 + a7b3
    smladx r6, r1, r3, r6 @ r6 = a2b7 + a3b6 + a4b5 + a5b4 + a6b3 + a7b2 = c9
    smuadx r5, r1, r4 @ r5 = a4b7 + a5b6
    smuadx r8, r2, r4 @ r8 = a6b7 + a7b6 = c13
    smultt r9, r2, r3 @ r9 = a7b5
    smultt r10, r2, r4 @ r10 = a7b7 = c14
    smladx r5, r2, r3, r5 @ r5 = a4b7 + a5b6 + a6b5 + a7b4 = c11
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad.w r12, r1, r3, r12 @ r12 = a3b7 + a4b6 + a5b5 + a6b4 + a7b3 = c10
    smlad.w r9, r1, r4, r9 @ r9 = a5b7 + a6b6 + a7b5 = c12
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r7, r0 @ r1 = round(c8/q)
    mls r7, r1, lr, r7 @ r7 = barrett(c8)
    smmulr r1, r6, r0 @ r1 = round(c9/q)
    mls r6, r1, lr, r6 @ r6 = barrett(c9)
    pkhbt r7, r7, r6, lsl #16 @ r7 = c8c9
    smmulr r1, r12, r0 @ r1 = round(c10/q)
    mls r12, r1, lr, r12 @ r12 = barrett(c10)
    smmulr r1, r5, r0 @ r1 = round(c11/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c11)
    pkhbt r12, r12, r5, lsl #16 @ r12 = c10c11
    smmulr r1, r9, r0 @ r1 = round(c12/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c12)
    smmulr r1, r8, r0 @ r1 = round(c13/q)
    mls r8, r1, lr, r8 @ r8 = barrett(c13)
    pkhbt r9, r9, r8, lsl #16 @ r9 = c12c13
    smmulr r1, r10, r0 @ r1 = round(c14/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c14)
    ubfx r10, r10, #0, #16 @ r10 = c14 0 
    ldr r0, mul_buffer_bridge
    ldm r0, {r1-r4} @ r1 = c0c1, r2 = c2c3, r3 = c4c5, r4 = c6c7
    ssub16 r1, r1, r7 @ r1 = (c0 - c8) (c1 - c9)
    ssub16 r2, r2, r12 @ r2 = (c2 - c10) (c3 - c11)
    ssub16 r3, r3, r9 @ r3 = (c4 - c12) (c5 - c13)
    ssub16 r4, r4, r10 @ r4 = (c6 - c14) (c7)
@ 8x8 mod (x^8 + 1) done
    ldr r0, buffer_bridge
    ldm r0, {r5-r8}
    sadd16 r9, r5, r1 @ r9 = d0d1
    ssub16 r10, r5, r1 @ r10 = d8d9
    sadd16 r11, r6, r2 @ r11 = d2d3
    ssub16 r12, r6, r2 @ r12 = d10d11
    sadd16 r1, r7, r3 @ r1 = d4d5
    ssub16 r5, r7, r3 @ r5 = d12d13
    sadd16 r2, r8, r4 @ r2 = d6d7
    ssub16 r6, r8, r4 @ r6 = d14 0
    vmov r3, s0
    ldr lr, [r3] @ lr = real a0a1
    pkhbt lr, lr, lr, lsl #16 @ lr = a0 a0
    sadd16 r9, r9, lr
    sadd16 r11, r11, lr
    sadd16 r1, r1, lr
    sadd16 r2, r2, lr
    sadd16 r10, r10, lr
    sadd16 r12, r12, lr
    sadd16 r5, r5, lr
    sadd16 r6, r6, lr
    str r9, [r0]
    str r11, [r0, #4]
    str r1, [r0, #8]
    str r2, [r0, #12]
    str r10, [r0, #16]
    str r12, [r0, #20]
    str r5, [r0, #24]
    str r6, [r0, #28]
@ convolution done 1



    ldr lr, buffer_bridge
    ldr r1, [lr, #32] @ r1 = a0a1
    ldr r2, [lr, #36] @ r2 = a2a3
    vmov r0, s9 @ r0 = 935519
    vmov lr, s10 @ lr = 4591
    vmov r3, s1 @ r3 = b0b1
    vmov r4, s2 @ r4 = b2b3
    smulbb r5, r1, r3 @ r5 = a0b0 = c0
    smulbb r6, r1, r4 @ r6 = a0b2
    smuadx r7, r1, r3 @ r7 = a0b1 + a1b0 = c1
    smuadx r8, r1, r4 @ r8 = a0b3 + a1b2
    smuadx r9, r2, r4 @ r9 = a2b3 + a3b2
    smultt r10, r2, r3 @ r10 = a3b1
    smultt r11, r2, r4 @ r11 = a3b3
    smladx r12, r2, r3, r8 @ r12 = c3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r6, r1, r3, r6 @ r6 = c2
    smlad r10, r1, r4 ,r10 @ r10 = a1b3 + a2b2 + a3b1
    smmulr r1, r5, r0 @ round(c0/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c0)
    smmulr r1, r7, r0
    mls r7, r1, lr, r7 @ r7 = barrett(c1)
    pkhbt r5, r5, r7, lsl #16 @ r5 = c0c1
    smmulr r1, r6, r0
    mls r6, r1, lr, r6 @ r6 = barrett(c2)
    smmulr r1, r12, r0
    mls r12, r1, lr, r12 @ r12 = barrett(c3)
    pkhbt r6, r6, r12, lsl #16 @ r6 = c2c3
    ldr r12, mul_buffer_bridge @ r12 = mul_buffer addr
    str r5, [r12] @ store c0c1
    str r6, [r12, #4] @ store c2c3
    ldr r0, buffer_bridge
    ldr r1, [r0, #40] @ r1 = a4a5
    ldr r2, [r0, #44] @ r2 = a6a7
    smlabb r10, r1, r3, r10 @ r10 = a1b3 + a2b2 + a3b1 +a4b0
    smlabb r11, r1, r4, r11 @ r11 = a3b3 + a4b2  
    smladx r9, r1, r3, r9 @ r9 = a2b3 + a3b2 + a4b1 + a5b0
    smuadx r5, r1, r4 @ r5 = a4b3 + a5b2
    smuadx r6, r2, r4 @ r6 = a6b3 + a7b2
    smultt r7, r2, r3 @ r7 = a7b1
    smultt r12, r2, r4 @ r12 = a7b3
    smladx r5, r2, r3, r5 @ r5 = a4b3 + a5b2 + a6b1 + a7b0
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad r11, r1, r3, r11 @ r11 = a3b3 + a4b2 + a5b1 + a6b0
    smlad r7, r1, r4, r7 @ r7 = a5b3 + a6b2 + a7b1
    vmov r3, s3 @ r3 = b4b5
    vmov r4, s4 @ r4 = b6b7
    ldr r1, [r0, #32] @ r1 = a0a1
    ldr r2, [r0, #36] @ r2 = a2a3
    smlabb r10, r1, r3, r10 @ r10 = c4
    smlabb r11, r1, r4, r11 @ r11 = a0b6 + a3b3 + a4b2 + a5b1 +a6b0
    smladx r9, r1, r3, r9 @ r9 = c5
    smladx r5, r1, r4, r5 
    smladx r5, r2, r3, r5 @ r5 = c7
    smladx r6, r2, r4, r6 @ r6 = a2b7 + a3b6 + a6b3 + a7b2
    smlatt r7, r2, r3, r7 @ r7 = a3b5 + a5b3 + a6b2 + a7b1
    smlatt r12, r2, r4, r12 @ r12 = a3b7 + a7b3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r11, r1, r3, r11 @ r11 = c6
    smlad r7, r1, r4, r7 @ r7 = a1b7 + a2b6 + a3b5 + a5b3 + a6b2 +a7b1
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r10, r0 @ r1 = round(c4/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c4)
    smmulr r1, r9, r0 @ r1 = round(c5/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c5)
    pkhbt r10, r10, r9, lsl #16 @ r10 = c4c5
    smmulr r1, r11, r0 @ r1 = round(c6/q)
    mls r11, r1, lr, r11 @ r11 = barrett(c6)
    smmulr r1, r5, r0 @ r1 = round(c7/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c7)
    pkhbt r11, r11, r5, lsl #16 @ r11 = c6c7
    ldr r0, mul_buffer_bridge
    str r10, [r0, #8] @ store c4c5
    str r11, [r0, #12] @store c6c7
    ldr r0, buffer_bridge
    ldr r1, [r0, #40] @ r1 = a4a5
    ldr r2, [r0, #44] @ r2 = a6a7
    smlabb r7, r1, r3, r7 @ r7 = a1b7 + a2b6 + a3b5 + a4b4 + a5b3 + a6b2 +a7b1 = c8
    smlabb r12, r1, r4, r12 @ r12 = a3b7 + a4b6 + a7b3
    smladx r6, r1, r3, r6 @ r6 = a2b7 + a3b6 + a4b5 + a5b4 + a6b3 + a7b2 = c9
    smuadx r5, r1, r4 @ r5 = a4b7 + a5b6
    smuadx r8, r2, r4 @ r8 = a6b7 + a7b6 = c13
    smultt r9, r2, r3 @ r9 = a7b5
    smultt r10, r2, r4 @ r10 = a7b7 = c14
    smladx r5, r2, r3, r5 @ r5 = a4b7 + a5b6 + a6b5 + a7b4 = c11
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad.w r12, r1, r3, r12 @ r12 = a3b7 + a4b6 + a5b5 + a6b4 + a7b3 = c10
    smlad.w r9, r1, r4, r9 @ r9 = a5b7 + a6b6 + a7b5 = c12
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r7, r0 @ r1 = round(c8/q)
    mls r7, r1, lr, r7 @ r7 = barrett(c8)
    smmulr r1, r6, r0 @ r1 = round(c9/q)
    mls r6, r1, lr, r6 @ r6 = barrett(c9)
    pkhbt r7, r7, r6, lsl #16 @ r7 = c8c9
    smmulr r1, r12, r0 @ r1 = round(c10/q)
    mls r12, r1, lr, r12 @ r12 = barrett(c10)
    smmulr r1, r5, r0 @ r1 = round(c11/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c11)
    pkhbt r12, r12, r5, lsl #16 @ r12 = c10c11
    smmulr r1, r9, r0 @ r1 = round(c12/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c12)
    smmulr r1, r8, r0 @ r1 = round(c13/q)
    mls r8, r1, lr, r8 @ r8 = barrett(c13)
    pkhbt r9, r9, r8, lsl #16 @ r9 = c12c13
    smmulr r1, r10, r0 @ r1 = round(c14/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c14)
    ubfx r10, r10, #0, #16 @ r10 = c14 0 
    ldr r0, mul_buffer_bridge
    ldm r0, {r1-r4} @ r1 = c0c1, r2 = c2c3, r3 = c4c5, r4 = c6c7
    sadd16 r1, r1, r7 @ r1 = (c0 + c8) (c1 + c9)
    sadd16 r2, r2, r12 @ r2 = (c2 + c10) (c3 + c11)
    sadd16 r3, r3, r9 @ r3 = (c4 + c12) (c5 + c13)
    sadd16 r4, r4, r10 @ r4 = (c6 + c14) (c7)
    ldr r0, buffer_bridge
    stm r0, {r1-r4}
@ 8x8 mod (x^8 - 1) done
    ldr lr, buffer_bridge
    ldr r1, [lr, #48] @ r1 = a0a1
    ldr r2, [lr, #52] @ r2 = a2a3
    vmov r0, s9 @ r0 = 935519
    vmov lr, s10 @ lr = 4591
    vmov r3, s5 @ r3 = b0b1
    vmov r4, s6 @ r4 = b2b3
    smulbb r5, r1, r3 @ r5 = a0b0 = c0
    smulbb r6, r1, r4 @ r6 = a0b2
    smuadx r7, r1, r3 @ r7 = a0b1 + a1b0 = c1
    smuadx r8, r1, r4 @ r8 = a0b3 + a1b2
    smuadx r9, r2, r4 @ r9 = a2b3 + a3b2
    smultt r10, r2, r3 @ r10 = a3b1
    smultt r11, r2, r4 @ r11 = a3b3
    smladx r12, r2, r3, r8 @ r12 = c3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r6, r1, r3, r6 @ r6 = c2
    smlad r10, r1, r4 ,r10 @ r10 = a1b3 + a2b2 + a3b1
    smmulr r1, r5, r0 @ round(c0/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c0)
    smmulr r1, r7, r0
    mls r7, r1, lr, r7 @ r7 = barrett(c1)
    pkhbt r5, r5, r7, lsl #16 @ r5 = c0c1
    smmulr r1, r6, r0
    mls r6, r1, lr, r6 @ r6 = barrett(c2)
    smmulr r1, r12, r0
    mls r12, r1, lr, r12 @ r12 = barrett(c3)
    pkhbt r6, r6, r12, lsl #16 @ r6 = c2c3
    ldr r12, mul_buffer_bridge @ r12 = mul_buffer addr
    str r5, [r12] @ store c0c1
    str r6, [r12, #4] @ store c2c3
    ldr r0, buffer_bridge
    ldr r1, [r0, #56] @ r1 = a4a5
    ldr r2, [r0, #60] @ r2 = a6a7
    smlabb r10, r1, r3, r10 @ r10 = a1b3 + a2b2 + a3b1 +a4b0
    smlabb r11, r1, r4, r11 @ r11 = a3b3 + a4b2  
    smladx r9, r1, r3, r9 @ r9 = a2b3 + a3b2 + a4b1 + a5b0
    smuadx r5, r1, r4 @ r5 = a4b3 + a5b2
    smuadx r6, r2, r4 @ r6 = a6b3 + a7b2
    smultt r7, r2, r3 @ r7 = a7b1
    smultt r12, r2, r4 @ r12 = a7b3
    smladx r5, r2, r3, r5 @ r5 = a4b3 + a5b2 + a6b1 + a7b0
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad r11, r1, r3, r11 @ r11 = a3b3 + a4b2 + a5b1 + a6b0
    smlad r7, r1, r4, r7 @ r7 = a5b3 + a6b2 + a7b1
    vmov r3, s7 @ r3 = b4b5
    vmov r4, s8 @ r4 = b6b7
    ldr r1, [r0, #48] @ r1 = a0a1
    ldr r2, [r0, #52] @ r2 = a2a3
    smlabb r10, r1, r3, r10 @ r10 = c4
    smlabb r11, r1, r4, r11 @ r11 = a0b6 + a3b3 + a4b2 + a5b1 +a6b0
    smladx r9, r1, r3, r9 @ r9 = c5
    smladx r5, r1, r4, r5 
    smladx r5, r2, r3, r5 @ r5 = c7
    smladx r6, r2, r4, r6 @ r6 = a2b7 + a3b6 + a6b3 + a7b2
    smlatt r7, r2, r3, r7 @ r7 = a3b5 + a5b3 + a6b2 + a7b1
    smlatt r12, r2, r4, r12 @ r12 = a3b7 + a7b3
    pkhbt r1, r2, r1 @ r1 = a2a1
    smlad r11, r1, r3, r11 @ r11 = c6
    smlad r7, r1, r4, r7 @ r7 = a1b7 + a2b6 + a3b5 + a5b3 + a6b2 +a7b1
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r10, r0 @ r1 = round(c4/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c4)
    smmulr r1, r9, r0 @ r1 = round(c5/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c5)
    pkhbt r10, r10, r9, lsl #16 @ r10 = c4c5
    smmulr r1, r11, r0 @ r1 = round(c6/q)
    mls r11, r1, lr, r11 @ r11 = barrett(c6)
    smmulr r1, r5, r0 @ r1 = round(c7/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c7)
    pkhbt r11, r11, r5, lsl #16 @ r11 = c6c7
    ldr r0, mul_buffer_bridge
    str r10, [r0, #8] @ store c4c5
    str r11, [r0, #12] @store c6c7
    ldr r0, buffer_bridge
    ldr r1, [r0, #56] @ r1 = a4a5
    ldr r2, [r0, #60] @ r2 = a6a7
    smlabb r7, r1, r3, r7 @ r7 = a1b7 + a2b6 + a3b5 + a4b4 + a5b3 + a6b2 +a7b1 = c8
    smlabb r12, r1, r4, r12 @ r12 = a3b7 + a4b6 + a7b3
    smladx r6, r1, r3, r6 @ r6 = a2b7 + a3b6 + a4b5 + a5b4 + a6b3 + a7b2 = c9
    smuadx r5, r1, r4 @ r5 = a4b7 + a5b6
    smuadx r8, r2, r4 @ r8 = a6b7 + a7b6 = c13
    smultt r9, r2, r3 @ r9 = a7b5
    smultt r10, r2, r4 @ r10 = a7b7 = c14
    smladx r5, r2, r3, r5 @ r5 = a4b7 + a5b6 + a6b5 + a7b4 = c11
    pkhbt r1, r2, r1 @ r1 = a6a5
    smlad.w r12, r1, r3, r12 @ r12 = a3b7 + a4b6 + a5b5 + a6b4 + a7b3 = c10
    smlad.w r9, r1, r4, r9 @ r9 = a5b7 + a6b6 + a7b5 = c12
    vmov r0, s9 @ r0 = 935519
    smmulr r1, r7, r0 @ r1 = round(c8/q)
    mls r7, r1, lr, r7 @ r7 = barrett(c8)
    smmulr r1, r6, r0 @ r1 = round(c9/q)
    mls r6, r1, lr, r6 @ r6 = barrett(c9)
    pkhbt r7, r7, r6, lsl #16 @ r7 = c8c9
    smmulr r1, r12, r0 @ r1 = round(c10/q)
    mls r12, r1, lr, r12 @ r12 = barrett(c10)
    smmulr r1, r5, r0 @ r1 = round(c11/q)
    mls r5, r1, lr, r5 @ r5 = barrett(c11)
    pkhbt r12, r12, r5, lsl #16 @ r12 = c10c11
    smmulr r1, r9, r0 @ r1 = round(c12/q)
    mls r9, r1, lr, r9 @ r9 = barrett(c12)
    smmulr r1, r8, r0 @ r1 = round(c13/q)
    mls r8, r1, lr, r8 @ r8 = barrett(c13)
    pkhbt r9, r9, r8, lsl #16 @ r9 = c12c13
    smmulr r1, r10, r0 @ r1 = round(c14/q)
    mls r10, r1, lr, r10 @ r10 = barrett(c14)
    ubfx r10, r10, #0, #16 @ r10 = c14 0 
    ldr r0, mul_buffer_bridge
    ldm r0, {r1-r4} @ r1 = c0c1, r2 = c2c3, r3 = c4c5, r4 = c6c7
    ssub16 r1, r1, r7 @ r1 = (c0 - c8) (c1 - c9)
    ssub16 r2, r2, r12 @ r2 = (c2 - c10) (c3 - c11)
    ssub16 r3, r3, r9 @ r3 = (c4 - c12) (c5 - c13)
    ssub16 r4, r4, r10 @ r4 = (c6 - c14) (c7)
@ 8x8 mod (x^8 + 1) done
    ldr r0, buffer_bridge
    ldm r0, {r5-r8}
    sadd16 r9, r5, r1 @ r9 = d0d1
    ssub16 r10, r5, r1 @ r10 = d8d9
    sadd16 r11, r6, r2 @ r11 = d2d3
    ssub16 r12, r6, r2 @ r12 = d10d11
    sadd16 r1, r7, r3 @ r1 = d4d5
    ssub16 r5, r7, r3 @ r5 = d12d13
    sadd16 r2, r8, r4 @ r2 = d6d7
    ssub16 r6, r8, r4 @ r6 = d14 0
    vmov r3, s0
    ldr lr, [r3] @ lr = real a0a1
    pkhbt lr, lr, lr, lsl #16 @ lr = a0 a0
    sadd16 r9, r9, lr
    sadd16 r11, r11, lr
    sadd16 r1, r1, lr
    sadd16 r2, r2, lr
    sadd16 r10, r10, lr
    sadd16 r12, r12, lr
    sadd16 r5, r5, lr
    sadd16 r6, r6, lr
    str r9, [r0, #32]
    str r11, [r0, #36]
    str r1, [r0, #40]
    str r2, [r0, #44]
    str r10, [r0, #48]
    str r12, [r0, #52]
    str r5, [r0, #56]
    str r6, [r0, #60]
@ convolution done 2
    vmov lr, s0
    ldr r1, [lr] @ r1 = a0a1
    ldr r2, [lr, #180] @ r2 = a90a91
    ldr r3, [lr, #360]
    ldr r4, [lr, #540]
    ldr r5, [lr, #720]
    ldr r6, [lr, #900]
    ldr r7, [lr, #1080]
    ldr r8, [lr, #1260]
    ldr r9, [lr, #1440]
    ldr r10, [lr, #1620]
    ldr r11, [lr, #1800]
    ldr r12, [lr, #1980]
    sadd16 r1, r1, r2
    sadd16 r1, r1, r3
    sadd16 r1, r1, r4
    sadd16 r1, r1, r5
    sadd16 r1, r1, r6
    sadd16 r1, r1, r7
    sadd16 r1, r1, r8
    sadd16 r1, r1, r9
    sadd16 r1, r1, r10
    sadd16 r1, r1, r11
    sadd16 r1, r1, r12
    ldr r2, [lr, #2160] 
    ldr r3, [lr, #2340]
    ldr r4, [lr, #2520]
    ldr r5, [lr, #2700]
    ldr r6, [lr, #2880]
    vmov r12, s9 @ r12 = 935519
    vmov r11, s10 @ r11 = 4591
    sadd16 r2, r2, r3
    sadd16 r2, r2, r4
    sadd16 r2, r2, r5
    sadd16 r2, r2, r6
    ubfx r3, r1, #0, #16
    ubfx r4, r2, #0, #16
    add r3, r3, r4 @ r3 = a0 + a90 + ...
    smmulr r4, r3, r12
    mls r3, r4, r11, r3 @ r3 = barrett(a0+a90+...)
    ubfx r5, r1, #16, #16
    ubfx r6, r2, #16, #16
    add r5, r5, r6
    smmulr r4, r5, r12
    mls r5, r4, r11, r5
    pkhbt r3, r3, r5, lsl #16
    str r3, [lr]
@ 14 8 7 4, 12 2 6 1, 3 9 10 13, 5 15 11 16

    ldr r1, [r0] @ r1 = x14x8
    ldr r2, [r0, #32] @ r2 = y14y8
    ldr r5, [r0, #4] @ r5 = x7x4
    ldr r6, [r0, #36] @ r6 = y7y4
    ldr r9, [r0, #8] @ r9 = x12x2
    ldr r10, [r0, #40] @ r10 = y12y2
    pkhbt r3, r1, r2, lsl #16 @ r3 = x14y14
    pkhtb r4, r2, r1, asr #16 @ r4 = x8y8
    pkhbt r7, r5, r6, lsl #16 @ r7 = x7y7
    pkhtb r8, r6, r5, asr #16 @ r8 = x4y4
    pkhbt r11, r9, r10, lsl #16 @ r11 = x12y12
    pkhtb r12, r10, r9 ,asr #16 @ r12 = x2y2
    str r3, [lr, #2520]
    str r4, [lr, #1440]
    str r7, [lr, #1260]
    str r8, [lr, #720]
    str r11, [lr, #2160]
    str r12, [lr, #360]
    ldr r1, [r0, #12] @ r1 = x6x1
    ldr r2, [r0, #44] @ r2 = y6y1
    ldr r5, [r0, #16] @ r5 = x3x9
    ldr r6, [r0, #48] @ r6 = y3y9
    ldr r9, [r0, #20] @ r9 = x10x13
    ldr r10, [r0, #52] @ r10 = y10y13
    pkhbt r3, r1, r2, lsl #16 @ r3 = x6y6
    pkhtb r4, r2, r1, asr #16 @ r4 = x1y1
    pkhbt r7, r5, r6, lsl #16 @ r7 = x3y3
    pkhtb r8, r6, r5, asr #16 @ r8 = x9y9
    pkhbt r11, r9, r10, lsl #16 @ r11 = x10y10
    pkhtb r12, r10, r9 ,asr #16 @ r12 = x13y13
    str r3, [lr, #1080]
    str r4, [lr, #180]
    str r7, [lr, #540]
    str r8, [lr, #1620]
    str r11, [lr, #1800]
    str r12, [lr, #2340]
    ldr r1, [r0, #24] @ r1 = x5x15
    ldr r2, [r0, #56] @ r2 = y5y15
    ldr r5, [r0, #28] @ r5 = x11x16
    ldr r6, [r0, #60] @ r6 = y11y16
    pkhbt r3, r1, r2, lsl #16 @ r3 = x5y5
    pkhtb r4, r2, r1, asr #16 @ r4 = x15y15
    pkhbt r7, r5, r6, lsl #16 @ r7 = x11y11
    pkhtb r8, r6, r5, asr #16 @ r8 = x16y16
    str r3, [lr, #900]
    str r4, [lr, #2700]
    str r7, [lr, #1980]
    str r8, [lr, #2880]
    

    





    pop {r1-r12, lr}
    bx lr

buffer_bridge:
    .word buffer
mul_buffer_bridge:
    .word mul_buffer

wpad:
    .word 4182573092
    .word 117701970
    .word 66254782
    .word 90372144
    .word 28375972
    .word 25823139
    .word 4251253512
    .word 4220778258
    .word 935519
    .word 4591