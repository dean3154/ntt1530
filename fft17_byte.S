.p2align 2,,3
.syntax unified

.data
buffer: .space 128

.text
buffer_bridge:
    .word buffer
    .word buffer+32
    .word buffer+64
    .word buffer+96
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

.global fft17_byte
.type fft17_byte, %function
fft17_byte:
@ fft17_byte(int16_t* f, int16_t* fpad
    push {r2-r12, lr}
    vpush {s16-s25}
    adr lr, wpad
    vldm lr, {s2-s11}
    vmov s1, r1
    add.w r1, r0, #40
    add.w r2, r0, #88
    vmov s12, r1
    vmov s13, r2
    ldr.w r3, buffer_bridge
    ldr.w r4, buffer_bridge+4
    ldr.w r5, buffer_bridge+8
    ldr.w r6, buffer_bridge+12
    vmov s14, r3
    vmov s15, r4
    vmov s16, r5
    vmov s17, r6
fft17_byte_body1:
    ldr.w r1, [r0, #540]
    ldr.w r2, [r0, #180]
    ldr.w r3, [r0, #450]
    ldr.w r4, [r0, #360]
    ldr.w r5, [r0, #630]
    ldr.w r6, [r0, #720]
    ldr.w r7, [r0, #270]
    ldr.w r8, [r0, #90]
    ldr.w r9, [r0], #4
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    sbfx r12, r9, #16, #8
    sbfx lr, r9, #24, #8
    pkhbt r10, r10, r10, lsl #16 @a0a0
    pkhbt r11, r11, r11, lsl #16 @a1a1
    pkhbt r12, r12, r12, lsl #16 @a2a2
    pkhbt lr, lr, lr, lsl #16 @a3a3
    vmov s0, r0
    vmov s18, r10
    vmov s19, r11
    vmov s20, r12
    vmov s21, lr
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    sadd8 r9, r9, r6
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    sbfx r12, r9, #16, #8
    sbfx lr, r9, #24, #8
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r12, lr, lsl #16
    vmov s22, r10 @b01
    vmov s23, r11 @b23
@ 6 2 5 4 7 8 3 1, -6 -2 5 -4 -7 -8 3 1
    vmov lr, s14
    mov.w r0, #0
    sbfx r9, r7, #0, #8
    sbfx r10, r7, #8, #8
    sbfx r11, r7, #16, #8
    sbfx r12, r7, #24, #8
    sbfx r7, r8, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r8, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r8, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r8, #24, #8
    pkhbt r12, r12, r7, lsl #16
    str.w r9, [lr, #12]
    str.w r10, [lr, #44]
    str.w r11, [lr, #76]
    str.w r12, [lr, #108]
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    str.w r11, [lr, #92]
    str.w r12, [lr, #124]
    sbfx r9, r5, #0, #8
    sbfx r10, r5, #8, #8
    sbfx r11, r5, #16, #8
    sbfx r12, r5, #24, #8
    sbfx r7, r6, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r6, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r6, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r6, #24, #8
    pkhbt r12, r12, r7, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    ssub16 r7, r0, r11
    ssub16 r8, r0, r12
    str.w r9, [lr, #8]
    str.w r10, [lr, #40]
    str.w r11, [lr, #72]
    str.w r12, [lr, #104]
    str.w r5, [lr, #24]
    str.w r6, [lr, #56]
    str.w r7, [lr, #88]
    str.w r8, [lr, #120]
    sbfx r9, r1, #0, #8
    sbfx r10, r1, #8, #8
    sbfx r11, r1, #16, #8
    sbfx r12, r1, #24, #8
    sbfx r7, r2, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r2, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r2, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r2, #24, #8
    pkhbt r12, r12, r7, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    ssub16 r7, r0, r11
    ssub16 r8, r0, r12
    str.w r9, [lr, #0]
    str.w r10, [lr, #32]
    str.w r11, [lr, #64]
    str.w r12, [lr, #96]
    str.w r5, [lr, #16]
    str.w r6, [lr, #48]
    str.w r7, [lr, #80]
    str.w r8, [lr, #112]
    sbfx r9, r3, #0, #8
    sbfx r10, r3, #8, #8
    sbfx r11, r3, #16, #8
    sbfx r12, r3, #24, #8
    sbfx r5, r4, #0, #8
    sbfx r6, r4, #8, #8
    sbfx r7, r4, #16, #8
    sbfx r8, r4, #24, #8
    pkhbt r1, r9, r5, lsl #16
    pkhbt r2, r10, r6, lsl #16
    pkhbt r3, r11, r7, lsl #16
    pkhbt r4, r12, r8, lsl #16
    sub.w r5, r0, r5
    sub.w r6, r0, r6
    sub.w r7, r0, r7
    sub.w r8, r0, r8
    pkhbt r5, r9, r5, lsl #16
    pkhbt r6, r10, r6, lsl #16
    pkhbt r7, r11, r7, lsl #16
    pkhbt r8, r12, r8, lsl #16
    str.w r1, [lr, #4]
    str.w r2, [lr, #36]
    str.w r3, [lr, #68]
    str.w r4, [lr, #100]
    str.w r5, [lr, #20]
    str.w r6, [lr, #52]
    str.w r7, [lr, #84]
    str.w r8, [lr, #116]
@ pre-process done
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s14
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s14
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s18
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s15
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s15
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s15
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s19
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s16
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s16
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s16
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s20
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s17
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s17
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s17
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s21
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov r0, s1
    vmov lr, s14
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    pkhbt r9, r1, r5, lsl #16 @ 14
    pkhtb r10, r5, r1, asr #16 @ 8
    pkhbt r11, r2, r6, lsl #16 @ 7
    pkhtb r12, r6, r2, asr #16 @ 4
    pkhbt r1, r3, r7, lsl #16 @ 12
    pkhtb r2, r7, r3, asr #16 @ 2
    pkhbt r3, r4, r8, lsl #16 @ 6
    pkhtb r4, r8, r4, asr #16 @ 1
    str.w r9, [r0, #2520]
    str.w r10, [r0, #1440]
    str.w r11, [r0, #1260]
    str.w r12, [r0, #720]
    str.w r1, [r0, #2160]
    str.w r2, [r0, #360]
    str.w r3, [r0, #1080]
    str.w r4, [r0, #180]
    ldr.w r1, [lr, #16]
    ldr.w r2, [lr, #20]
    ldr.w r3, [lr, #24]
    ldr.w r4, [lr, #28]
    ldr.w r5, [lr, #48]
    ldr.w r6, [lr, #52]
    ldr.w r7, [lr, #56]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r5, lsl #16 @ 3
    pkhtb r10, r5, r1, asr #16 @ 9
    pkhbt r11, r2, r6, lsl #16 @ 10
    pkhtb r12, r6, r2, asr #16 @ 13
    pkhbt r1, r3, r7, lsl #16 @ 5
    pkhtb r2, r7, r3, asr #16 @ 15
    pkhbt r3, r4, r8, lsl #16 @ 11
    pkhtb r4, r8, r4, asr #16 @ 16
    str.w r9, [r0, #540]
    str.w r10, [r0, #1620]
    str.w r11, [r0, #1800]
    str.w r12, [r0, #2340]
    str.w r1, [r0, #900]
    str.w r2, [r0, #2700]
    str.w r3, [r0, #1980]
    str.w r4, [r0, #2880]
    vmov lr, s16
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    pkhbt r9, r1, r5, lsl #16 @ 14
    pkhtb r10, r5, r1, asr #16 @ 8
    pkhbt r11, r2, r6, lsl #16 @ 7
    pkhtb r12, r6, r2, asr #16 @ 4
    pkhbt r1, r3, r7, lsl #16 @ 12
    pkhtb r2, r7, r3, asr #16 @ 2
    pkhbt r3, r4, r8, lsl #16 @ 6
    pkhtb r4, r8, r4, asr #16 @ 1
    str.w r9, [r0, #2524]
    str.w r10, [r0, #1444]
    str.w r11, [r0, #1264]
    str.w r12, [r0, #724]
    str.w r1, [r0, #2164]
    str.w r2, [r0, #364]
    str.w r3, [r0, #1084]
    str.w r4, [r0, #184]
    ldr.w r1, [lr, #16]
    ldr.w r2, [lr, #20]
    ldr.w r3, [lr, #24]
    ldr.w r4, [lr, #28]
    ldr.w r5, [lr, #48]
    ldr.w r6, [lr, #52]
    ldr.w r7, [lr, #56]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r5, lsl #16 @ 3
    pkhtb r10, r5, r1, asr #16 @ 9
    pkhbt r11, r2, r6, lsl #16 @ 10
    pkhtb r12, r6, r2, asr #16 @ 13
    pkhbt r1, r3, r7, lsl #16 @ 5
    pkhtb r2, r7, r3, asr #16 @ 15
    pkhbt r3, r4, r8, lsl #16 @ 11
    pkhtb r4, r8, r4, asr #16 @ 16
    str.w r9, [r0, #544]
    str.w r10, [r0, #1624]
    str.w r11, [r0, #1804]
    str.w r12, [r0, #2344]
    str.w r1, [r0, #904]
    str.w r2, [r0, #2704]
    str.w r3, [r0, #1984]
    str.w r4, [r0, #2884]
    vmov r5, s22
    vmov r6, s23
    str.w r6, [r0, #4]
    str.w r5, [r0], #8

    vmov s1, r0
    vmov r0, s0
    vmov r2, s12
    cmp.w r0, r2
    bne.w fft17_byte_body1

@ 760~763
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
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    sbfx r12, r9, #16, #8
    sbfx lr, r9, #24, #8
    pkhbt r10, r10, r10, lsl #16 @a0a0
    pkhbt r11, r11, r11, lsl #16 @a1a1
    pkhbt r12, r12, r12, lsl #16 @a2a2
    pkhbt lr, lr, lr, lsl #16 @a3a3
    vmov s0, r0
    vmov s18, r10
    vmov s19, r11
    vmov s20, r12
    vmov s21, lr
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    sadd8 r9, r9, r6
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    sbfx r12, r9, #16, #8
    sbfx lr, r9, #24, #8
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r12, lr, lsl #16
    vmov s22, r10 @b01
    vmov s23, r11 @b23
@ 6 2 5 4 7 8 3 1, -6 -2 5 -4 -7 -8 3 1
    vmov lr, s14
    mov.w r0, #0
    sbfx r9, r7, #0, #8
    sbfx r10, r7, #8, #8
    sbfx r11, r7, #16, #8
    sbfx r12, r7, #24, #8
    sbfx r7, r8, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r8, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r8, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r8, #24, #8
    pkhbt r12, r12, r7, lsl #16
    str.w r9, [lr, #12]
    str.w r10, [lr, #44]
    str.w r11, [lr, #76]
    str.w r12, [lr, #108]
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    str.w r11, [lr, #92]
    str.w r12, [lr, #124]
    sbfx r9, r5, #0, #8
    sbfx r10, r5, #8, #8
    sbfx r11, r5, #16, #8
    sbfx r12, r5, #24, #8
    sbfx r7, r6, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r6, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r6, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r6, #24, #8
    pkhbt r12, r12, r7, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    ssub16 r7, r0, r11
    ssub16 r8, r0, r12
    str.w r9, [lr, #8]
    str.w r10, [lr, #40]
    str.w r11, [lr, #72]
    str.w r12, [lr, #104]
    str.w r5, [lr, #24]
    str.w r6, [lr, #56]
    str.w r7, [lr, #88]
    str.w r8, [lr, #120]
    sbfx r9, r1, #0, #8
    sbfx r10, r1, #8, #8
    sbfx r11, r1, #16, #8
    sbfx r12, r1, #24, #8
    sbfx r7, r2, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r2, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r2, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r2, #24, #8
    pkhbt r12, r12, r7, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    ssub16 r7, r0, r11
    ssub16 r8, r0, r12
    str.w r9, [lr, #0]
    str.w r10, [lr, #32]
    str.w r11, [lr, #64]
    str.w r12, [lr, #96]
    str.w r5, [lr, #16]
    str.w r6, [lr, #48]
    str.w r7, [lr, #80]
    str.w r8, [lr, #112]
    sbfx r9, r3, #0, #8
    sbfx r10, r3, #8, #8
    sbfx r11, r3, #16, #8
    sbfx r12, r3, #24, #8
    sbfx r5, r4, #0, #8
    sbfx r6, r4, #8, #8
    sbfx r7, r4, #16, #8
    sbfx r8, r4, #24, #8
    pkhbt r1, r9, r5, lsl #16
    pkhbt r2, r10, r6, lsl #16
    pkhbt r3, r11, r7, lsl #16
    pkhbt r4, r12, r8, lsl #16
    sub.w r5, r0, r5
    sub.w r6, r0, r6
    sub.w r7, r0, r7
    sub.w r8, r0, r8
    pkhbt r5, r9, r5, lsl #16
    pkhbt r6, r10, r6, lsl #16
    pkhbt r7, r11, r7, lsl #16
    pkhbt r8, r12, r8, lsl #16
    str.w r1, [lr, #4]
    str.w r2, [lr, #36]
    str.w r3, [lr, #68]
    str.w r4, [lr, #100]
    str.w r5, [lr, #20]
    str.w r6, [lr, #52]
    str.w r7, [lr, #84]
    str.w r8, [lr, #116]
@ pre-process done
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s14
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s14
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s18
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s15
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s15
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s15
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s19
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s16
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s16
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s16
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s20
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s17
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s17
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s17
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s21
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov r0, s1
    vmov lr, s14
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    pkhbt r9, r1, r5, lsl #16 @ 14
    pkhtb r10, r5, r1, asr #16 @ 8
    pkhbt r11, r2, r6, lsl #16 @ 7
    pkhtb r12, r6, r2, asr #16 @ 4
    pkhbt r1, r3, r7, lsl #16 @ 12
    pkhtb r2, r7, r3, asr #16 @ 2
    pkhbt r3, r4, r8, lsl #16 @ 6
    pkhtb r4, r8, r4, asr #16 @ 1
    str.w r9, [r0, #2520]
    str.w r10, [r0, #1440]
    str.w r11, [r0, #1260]
    str.w r12, [r0, #720]
    str.w r1, [r0, #2160]
    str.w r2, [r0, #360]
    str.w r3, [r0, #1080]
    str.w r4, [r0, #180]
    ldr.w r1, [lr, #16]
    ldr.w r2, [lr, #20]
    ldr.w r3, [lr, #24]
    ldr.w r4, [lr, #28]
    ldr.w r5, [lr, #48]
    ldr.w r6, [lr, #52]
    ldr.w r7, [lr, #56]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r5, lsl #16 @ 3
    pkhtb r10, r5, r1, asr #16 @ 9
    pkhbt r11, r2, r6, lsl #16 @ 10
    pkhtb r12, r6, r2, asr #16 @ 13
    pkhbt r1, r3, r7, lsl #16 @ 5
    pkhtb r2, r7, r3, asr #16 @ 15
    pkhbt r3, r4, r8, lsl #16 @ 11
    pkhtb r4, r8, r4, asr #16 @ 16
    str.w r9, [r0, #540]
    str.w r10, [r0, #1620]
    str.w r11, [r0, #1800]
    str.w r12, [r0, #2340]
    str.w r1, [r0, #900]
    str.w r2, [r0, #2700]
    str.w r3, [r0, #1980]
    str.w r4, [r0, #2880]
    vmov lr, s16
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    pkhbt r9, r1, r5, lsl #16 @ 14
    pkhtb r10, r5, r1, asr #16 @ 8
    pkhbt r11, r2, r6, lsl #16 @ 7
    pkhtb r12, r6, r2, asr #16 @ 4
    pkhbt r1, r3, r7, lsl #16 @ 12
    pkhtb r2, r7, r3, asr #16 @ 2
    pkhbt r3, r4, r8, lsl #16 @ 6
    pkhtb r4, r8, r4, asr #16 @ 1
    str.w r9, [r0, #2524]
    str.w r10, [r0, #1444]
    str.w r11, [r0, #1264]
    str.w r12, [r0, #724]
    str.w r1, [r0, #2164]
    str.w r2, [r0, #364]
    str.w r3, [r0, #1084]
    str.w r4, [r0, #184]
    ldr.w r1, [lr, #16]
    ldr.w r2, [lr, #20]
    ldr.w r3, [lr, #24]
    ldr.w r4, [lr, #28]
    ldr.w r5, [lr, #48]
    ldr.w r6, [lr, #52]
    ldr.w r7, [lr, #56]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r5, lsl #16 @ 3
    pkhtb r10, r5, r1, asr #16 @ 9
    pkhbt r11, r2, r6, lsl #16 @ 10
    pkhtb r12, r6, r2, asr #16 @ 13
    pkhbt r1, r3, r7, lsl #16 @ 5
    pkhtb r2, r7, r3, asr #16 @ 15
    pkhbt r3, r4, r8, lsl #16 @ 11
    pkhtb r4, r8, r4, asr #16 @ 16
    str.w r9, [r0, #544]
    str.w r10, [r0, #1624]
    str.w r11, [r0, #1804]
    str.w r12, [r0, #2344]
    str.w r1, [r0, #904]
    str.w r2, [r0, #2704]
    str.w r3, [r0, #1984]
    str.w r4, [r0, #2884]
    vmov r5, s22
    vmov r6, s23
    str.w r6, [r0, #4]
    str.w r5, [r0], #8
    vmov s1, r0
    vmov r0, s0

@764~
fft17_byte_body2:
    ldr.w r1, [r0, #540]
    ldr.w r2, [r0, #180]
    ldr.w r3, [r0, #450]
    ldr.w r4, [r0, #360]
    ldr.w r5, [r0, #630]
    mov.w r6, #0
    ldr.w r7, [r0, #270]
    ldr.w r8, [r0, #90]
    ldr.w r9, [r0], #4
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    sbfx r12, r9, #16, #8
    sbfx lr, r9, #24, #8
    pkhbt r10, r10, r10, lsl #16 @a0a0
    pkhbt r11, r11, r11, lsl #16 @a1a1
    pkhbt r12, r12, r12, lsl #16 @a2a2
    pkhbt lr, lr, lr, lsl #16 @a3a3
    vmov s0, r0
    vmov s18, r10
    vmov s19, r11
    vmov s20, r12
    vmov s21, lr
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    sbfx r12, r9, #16, #8
    sbfx lr, r9, #24, #8
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r12, lr, lsl #16
    vmov s22, r10 @b01
    vmov s23, r11 @b23
@ 6 2 5 4 7 8 3 1, -6 -2 5 -4 -7 -8 3 1
    vmov lr, s14
    mov.w r0, #0
    sbfx r9, r7, #0, #8
    sbfx r10, r7, #8, #8
    sbfx r11, r7, #16, #8
    sbfx r12, r7, #24, #8
    sbfx r7, r8, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r8, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r8, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r8, #24, #8
    pkhbt r12, r12, r7, lsl #16
    str.w r9, [lr, #12]
    str.w r10, [lr, #44]
    str.w r11, [lr, #76]
    str.w r12, [lr, #108]
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    str.w r11, [lr, #92]
    str.w r12, [lr, #124]
    sbfx r9, r5, #0, #8
    sbfx r10, r5, #8, #8
    sbfx r11, r5, #16, #8
    sbfx r12, r5, #24, #8
    pkhbt r9, r9, r6, lsl #16
    pkhbt r10, r10, r6, lsl #16
    pkhbt r11, r11, r6, lsl #16
    pkhbt r12, r12, r6, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    ssub16 r7, r0, r11
    ssub16 r8, r0, r12
    str.w r9, [lr, #8]
    str.w r10, [lr, #40]
    str.w r11, [lr, #72]
    str.w r12, [lr, #104]
    str.w r5, [lr, #24]
    str.w r6, [lr, #56]
    str.w r7, [lr, #88]
    str.w r8, [lr, #120]
    sbfx r9, r1, #0, #8
    sbfx r10, r1, #8, #8
    sbfx r11, r1, #16, #8
    sbfx r12, r1, #24, #8
    sbfx r7, r2, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r2, #8, #8
    pkhbt r10, r10, r7, lsl #16
    sbfx r7, r2, #16, #8
    pkhbt r11, r11, r7, lsl #16
    sbfx r7, r2, #24, #8
    pkhbt r12, r12, r7, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    ssub16 r7, r0, r11
    ssub16 r8, r0, r12
    str.w r9, [lr, #0]
    str.w r10, [lr, #32]
    str.w r11, [lr, #64]
    str.w r12, [lr, #96]
    str.w r5, [lr, #16]
    str.w r6, [lr, #48]
    str.w r7, [lr, #80]
    str.w r8, [lr, #112]
    sbfx r9, r3, #0, #8
    sbfx r10, r3, #8, #8
    sbfx r11, r3, #16, #8
    sbfx r12, r3, #24, #8
    sbfx r5, r4, #0, #8
    sbfx r6, r4, #8, #8
    sbfx r7, r4, #16, #8
    sbfx r8, r4, #24, #8
    pkhbt r1, r9, r5, lsl #16
    pkhbt r2, r10, r6, lsl #16
    pkhbt r3, r11, r7, lsl #16
    pkhbt r4, r12, r8, lsl #16
    sub.w r5, r0, r5
    sub.w r6, r0, r6
    sub.w r7, r0, r7
    sub.w r8, r0, r8
    pkhbt r5, r9, r5, lsl #16
    pkhbt r6, r10, r6, lsl #16
    pkhbt r7, r11, r7, lsl #16
    pkhbt r8, r12, r8, lsl #16
    str.w r1, [lr, #4]
    str.w r2, [lr, #36]
    str.w r3, [lr, #68]
    str.w r4, [lr, #100]
    str.w r5, [lr, #20]
    str.w r6, [lr, #52]
    str.w r7, [lr, #84]
    str.w r8, [lr, #116]
@ pre-process done
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s14
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s14
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s18
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s15
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s15
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s15
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s19
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s16
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s16
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s16
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s20
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s17
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s17
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s17
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s21
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov r0, s1
    vmov lr, s14
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    pkhbt r9, r1, r5, lsl #16 @ 14
    pkhtb r10, r5, r1, asr #16 @ 8
    pkhbt r11, r2, r6, lsl #16 @ 7
    pkhtb r12, r6, r2, asr #16 @ 4
    pkhbt r1, r3, r7, lsl #16 @ 12
    pkhtb r2, r7, r3, asr #16 @ 2
    pkhbt r3, r4, r8, lsl #16 @ 6
    pkhtb r4, r8, r4, asr #16 @ 1
    str.w r9, [r0, #2520]
    str.w r10, [r0, #1440]
    str.w r11, [r0, #1260]
    str.w r12, [r0, #720]
    str.w r1, [r0, #2160]
    str.w r2, [r0, #360]
    str.w r3, [r0, #1080]
    str.w r4, [r0, #180]
    ldr.w r1, [lr, #16]
    ldr.w r2, [lr, #20]
    ldr.w r3, [lr, #24]
    ldr.w r4, [lr, #28]
    ldr.w r5, [lr, #48]
    ldr.w r6, [lr, #52]
    ldr.w r7, [lr, #56]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r5, lsl #16 @ 3
    pkhtb r10, r5, r1, asr #16 @ 9
    pkhbt r11, r2, r6, lsl #16 @ 10
    pkhtb r12, r6, r2, asr #16 @ 13
    pkhbt r1, r3, r7, lsl #16 @ 5
    pkhtb r2, r7, r3, asr #16 @ 15
    pkhbt r3, r4, r8, lsl #16 @ 11
    pkhtb r4, r8, r4, asr #16 @ 16
    str.w r9, [r0, #540]
    str.w r10, [r0, #1620]
    str.w r11, [r0, #1800]
    str.w r12, [r0, #2340]
    str.w r1, [r0, #900]
    str.w r2, [r0, #2700]
    str.w r3, [r0, #1980]
    str.w r4, [r0, #2880]
    vmov lr, s16
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    pkhbt r9, r1, r5, lsl #16 @ 14
    pkhtb r10, r5, r1, asr #16 @ 8
    pkhbt r11, r2, r6, lsl #16 @ 7
    pkhtb r12, r6, r2, asr #16 @ 4
    pkhbt r1, r3, r7, lsl #16 @ 12
    pkhtb r2, r7, r3, asr #16 @ 2
    pkhbt r3, r4, r8, lsl #16 @ 6
    pkhtb r4, r8, r4, asr #16 @ 1
    str.w r9, [r0, #2524]
    str.w r10, [r0, #1444]
    str.w r11, [r0, #1264]
    str.w r12, [r0, #724]
    str.w r1, [r0, #2164]
    str.w r2, [r0, #364]
    str.w r3, [r0, #1084]
    str.w r4, [r0, #184]
    ldr.w r1, [lr, #16]
    ldr.w r2, [lr, #20]
    ldr.w r3, [lr, #24]
    ldr.w r4, [lr, #28]
    ldr.w r5, [lr, #48]
    ldr.w r6, [lr, #52]
    ldr.w r7, [lr, #56]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r5, lsl #16 @ 3
    pkhtb r10, r5, r1, asr #16 @ 9
    pkhbt r11, r2, r6, lsl #16 @ 10
    pkhtb r12, r6, r2, asr #16 @ 13
    pkhbt r1, r3, r7, lsl #16 @ 5
    pkhtb r2, r7, r3, asr #16 @ 15
    pkhbt r3, r4, r8, lsl #16 @ 11
    pkhtb r4, r8, r4, asr #16 @ 16
    str.w r9, [r0, #544]
    str.w r10, [r0, #1624]
    str.w r11, [r0, #1804]
    str.w r12, [r0, #2344]
    str.w r1, [r0, #904]
    str.w r2, [r0, #2704]
    str.w r3, [r0, #1984]
    str.w r4, [r0, #2884]
    vmov r5, s22
    vmov r6, s23
    str.w r6, [r0, #4]
    str.w r5, [r0], #8

    vmov s1, r0
    vmov r0, s0
    vmov r2, s13
    cmp.w r0, r2
    bne.w fft17_byte_body2

@last
    ldr.w r1, [r0, #540]
    ldr.w r2, [r0, #180]
    ldr.w r3, [r0, #450]
    ldr.w r4, [r0, #360]
    ldr.w r5, [r0, #630]
    mov.w r6, #0
    ldr.w r7, [r0, #270]
    ldr.w r8, [r0, #90]
    ldr.w r9, [r0], #4
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    pkhbt r10, r10, r10, lsl #16 @a0a0
    pkhbt r11, r11, r11, lsl #16 @a1a1
    vmov s0, r0
    vmov s18, r10
    vmov s19, r11
    sadd8 r9, r9, r1
    sadd8 r9, r9, r2
    sadd8 r9, r9, r3
    sadd8 r9, r9, r4
    sadd8 r9, r9, r5
    sadd8 r9, r9, r7
    sadd8 r9, r9, r8
    sbfx r10, r9, #0, #8
    sbfx r11, r9, #8, #8
    pkhbt r10, r10, r11, lsl #16
    vmov s22, r10 @b01
@ 6 2 5 4 7 8 3 1, -6 -2 5 -4 -7 -8 3 1
    vmov lr, s14
    mov.w r0, #0
    sbfx r9, r7, #0, #8
    sbfx r10, r7, #8, #8
    sbfx r7, r8, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r8, #8, #8
    pkhbt r10, r10, r7, lsl #16
    str.w r9, [lr, #12]
    str.w r10, [lr, #44]
    str.w r9, [lr, #28]
    str.w r10, [lr, #60]
    sbfx r9, r5, #0, #8
    sbfx r10, r5, #8, #8
    sbfx r7, r6, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r6, #8, #8
    pkhbt r10, r10, r7, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    str.w r9, [lr, #8]
    str.w r10, [lr, #40]
    str.w r5, [lr, #24]
    str.w r6, [lr, #56]
    sbfx r9, r1, #0, #8
    sbfx r10, r1, #8, #8
    sbfx r7, r2, #0, #8
    pkhbt r9, r9, r7, lsl #16
    sbfx r7, r2, #8, #8
    pkhbt r10, r10, r7, lsl #16
    ssub16 r5, r0, r9
    ssub16 r6, r0, r10
    str.w r9, [lr, #0]
    str.w r10, [lr, #32]
    str.w r5, [lr, #16]
    str.w r6, [lr, #48]
    sbfx r9, r3, #0, #8
    sbfx r10, r3, #8, #8
    sbfx r5, r4, #0, #8
    sbfx r6, r4, #8, #8
    pkhbt r1, r9, r5, lsl #16
    pkhbt r2, r10, r6, lsl #16
    sub.w r5, r0, r5
    sub.w r6, r0, r6
    pkhbt r5, r9, r5, lsl #16
    pkhbt r6, r10, r6, lsl #16
    str.w r1, [lr, #4]
    str.w r2, [lr, #36]
    str.w r5, [lr, #20]
    str.w r6, [lr, #52]
@ pre-process done
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s14
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s14
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s18
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov lr, s15
    ldr.w r9, [lr]
    ldr.w r10, [lr, #4]
    ldr.w r11, [lr, #8]
    ldr.w r12, [lr, #12]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
    sadd16 r1, r9, r11
    sadd16 r2, r10, r12
    ssub16 r3, r9, r11
    ssub16 r4, r10, r12
    smuadx r9, r1, r5
    smladx r9, r2, r6, r9
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    pkhbt r11, r1, r2, lsl #16
    pkhtb r12, r2, r1, asr #16
    pkhbt r1, r5, r6, lsl #16
    pkhtb r2, r6, r5, asr #16
    smuadx r5, r12, r2
    smlad r5, r11, r1, r5
    smuadx r6, r11, r1
    smlad r6, r12, r2, r6
    smmulr r1, r5, r0
    mls r5, r1, lr, r5
    smmulr r1, r9, r0
    mls r9, r1, lr, r9
    smmulr r1, r6, r0
    mls r6, r1, lr, r6
    smmulr r1, r10, r0
    mls r10, r1, lr, r10
    pkhbt r1, r5, r9, lsl #16
    pkhbt r2, r6, r10, lsl #16
    smuadx r5, r3, r7
    smuadx r6, r4, r8
    sub r5, r5, r6
    smuadx r6, r3, r8
    smladx r6, r4, r7, r6
    pkhbt r9, r3, r4, lsl #16
    pkhtb r10, r4, r3, asr #16
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    smusd r3, r9, r11
    smuadx r4, r10, r12
    sub r3, r3, r4
    smusd r7, r10, r12
    smladx r4, r9, r11, r7
    smmulr r7, r3, r0
    mls r3, r7, lr, r3
    smmulr r7, r5, r0
    mls r5, r7, lr, r5
    smmulr r7, r4, r0
    mls r4, r7, lr, r4
    smmulr r7, r6, r0
    mls r6, r7, lr, r6
    pkhbt r3, r3, r5, lsl #16
    pkhbt r4, r4, r6, lsl #16
    sadd16 r5, r1, r3
    sadd16 r6, r2, r4
    ssub16 r7, r1, r3
    ssub16 r8, r2, r4
    vmov lr, s15
    stm lr, {r5-r8}
    ldr r1, [lr, #16]
    ldr r2, [lr, #20]
    ldr r3, [lr, #24]
    ldr r4, [lr, #28]
    vmov r5, s6
    vmov r6, s7
    vmov r7, s8
    vmov r8, s9
    vmov lr, s11
    smuadx r9, r1, r5
    smuadx r10, r2, r8
    smladx r10, r3, r7, r10
    smladx r10, r4, r6, r10
    sub r9, r9, r10
    smuadx r10, r1, r6
    smladx r10, r2, r5, r10
    smuadx r11, r3, r8
    smladx r11, r4, r7, r11
    sub r10, r10, r11
    smmulr r11, r9, r0
    mls r9, r11, lr, r9
    smmulr r11, r10, r0
    mls r10, r11, lr, r10
    pkhbt r9, r9, r10, lsl #16
    smuadx r10, r1, r7
    smladx r10, r2, r6, r10
    smladx r10, r3, r5, r10
    smuadx r11, r4, r8
    sub r10, r10, r11
    smuadx r11, r1, r8
    smladx r11, r2, r7, r11
    smladx r11, r3, r6, r11
    smladx r11, r4, r5, r11
    smmulr r12, r10, r0
    mls r10, r12, lr, r10
    smmulr r12, r11, r0
    mls r11, r12, lr, r11
    pkhbt r10, r10, r11, lsl #16
    pkhbt r11, r1, r3, lsl #16
    pkhtb r12, r3, r1, asr #16
    pkhbt r1, r2, r4, lsl #16
    pkhtb r3, r4, r2, asr #16
    pkhbt r2, r5, r7, lsl #16
    pkhtb r4, r7, r5, asr #16
    pkhbt r5, r6, r8, lsl #16
    pkhtb r7, r8, r6, asr #16
    vmov s24, r9
    vmov s25, r10
    smusd r6, r11, r2
    smuadx r8, r12, r7
    smladx r8, r1, r5, r8
    smladx r8, r3, r4, r8
    sub r6, r6, r8
    smusd r8, r11, r5
    smlsd r8, r1, r2, r8
    smlsd r8, r12, r4, r8
    smuadx r9, r3, r7
    sub r8, r8, r9
    smmulr r9, r6, r0
    mls r6, r9, lr, r6
    smmulr r9, r8, r0
    mls r8, r9, lr, r8
    pkhbt r6, r6, r8, lsl #16
    smuadx r8, r11, r2
    smlsd r8, r12, r7, r8
    smlsd r8, r1, r5, r8
    smlsd r8, r3, r4, r8
    smuadx r9, r11, r5
    smladx r9, r12, r4, r9
    smladx r9, r1, r2, r9
    smlsd r9, r3, r7, r9
    smmulr r10, r8, r0
    mls r8, r10, lr, r8
    smmulr r10, r9, r0
    mls r9, r10, lr, r9
    vmov r10, s24
    vmov r11, s25
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s15
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s19
    sadd16 r9, r9, r6
    sadd16 r10, r10, r6
    sadd16 r11, r11, r6
    sadd16 r12, r12, r6
    sadd16 r1, r1, r6
    sadd16 r2, r2, r6
    sadd16 r3, r3, r6
    sadd16 r4, r4, r6
    str.w r9, [lr]
    str.w r11, [lr, #4]
    str.w r1, [lr, #8]
    str.w r3, [lr, #12]
    str.w r10, [lr, #16]
    str.w r12, [lr, #20]
    str.w r2, [lr, #24]
    str.w r4, [lr, #28]

    vmov r0, s1
    vmov lr, s14
    ldr.w r1, [lr]
    ldr.w r2, [lr, #4]
    ldr.w r3, [lr, #8]
    ldr.w r4, [lr, #12]
    ldr.w r5, [lr, #32]
    ldr.w r6, [lr, #36]
    ldr.w r7, [lr, #40]
    ldr.w r8, [lr, #44]
    pkhbt r9, r1, r5, lsl #16 @ 14
    pkhtb r10, r5, r1, asr #16 @ 8
    pkhbt r11, r2, r6, lsl #16 @ 7
    pkhtb r12, r6, r2, asr #16 @ 4
    pkhbt r1, r3, r7, lsl #16 @ 12
    pkhtb r2, r7, r3, asr #16 @ 2
    pkhbt r3, r4, r8, lsl #16 @ 6
    pkhtb r4, r8, r4, asr #16 @ 1
    str.w r9, [r0, #2520]
    str.w r10, [r0, #1440]
    str.w r11, [r0, #1260]
    str.w r12, [r0, #720]
    str.w r1, [r0, #2160]
    str.w r2, [r0, #360]
    str.w r3, [r0, #1080]
    str.w r4, [r0, #180]
    ldr.w r1, [lr, #16]
    ldr.w r2, [lr, #20]
    ldr.w r3, [lr, #24]
    ldr.w r4, [lr, #28]
    ldr.w r5, [lr, #48]
    ldr.w r6, [lr, #52]
    ldr.w r7, [lr, #56]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r5, lsl #16 @ 3
    pkhtb r10, r5, r1, asr #16 @ 9
    pkhbt r11, r2, r6, lsl #16 @ 10
    pkhtb r12, r6, r2, asr #16 @ 13
    pkhbt r1, r3, r7, lsl #16 @ 5
    pkhtb r2, r7, r3, asr #16 @ 15
    pkhbt r3, r4, r8, lsl #16 @ 11
    pkhtb r4, r8, r4, asr #16 @ 16
    str.w r9, [r0, #540]
    str.w r10, [r0, #1620]
    str.w r11, [r0, #1800]
    str.w r12, [r0, #2340]
    str.w r1, [r0, #900]
    str.w r2, [r0, #2700]
    str.w r3, [r0, #1980]
    str.w r4, [r0, #2880]

    vmov r5, s22
    str.w r5, [r0]
    vpop {s16-s25}
    pop {r2-r12, pc}

