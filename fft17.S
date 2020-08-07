.p2align 2,,3
.syntax unified

.data
buffer: .space 64

.text
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

.global fft17
.type fft17, %function
fft17:
@ fft17(int16_t* f, int16_t* fpad
    push {r2-r12, lr}
    vpush {s16-s20}
    adr lr, wpad
    vldm lr, {s2-s11}
    vmov s1, r1
    add.w r1, r0, #80
    add.w r2, r0, #180
    vmov s17, r1
    vmov s18, r2
    ldr.w r3, buffer_bridge
    ldr.w r4, buffer_bridge+4
    vmov s19, r3
    vmov s20, r4
fft17_body1:
    ldr.w r1, [r0, #1080]
    ldr.w r2, [r0, #360]
    ldr.w r3, [r0, #900]
    ldr.w r4, [r0, #720]
    ldr.w r5, [r0, #1260]
    ldr.w r6, [r0, #1440]
    ldr.w r7, [r0, #540]
    ldr.w r8, [r0, #180]
    ldr.w r9, [r0], #4
    pkhbt r11, r9, r9, lsl #16
    pkhtb r12, r9, r9, asr #16
    sadd16 r9, r9, r1
    sadd16 r9, r9, r2
    sadd16 r9, r9, r3
    sadd16 r9, r9, r4
    sadd16 r9, r9, r5
    sadd16 r9, r9, r6
    sadd16 r9, r9, r7
    sadd16 r9, r9, r8
    sbfx r10, r9, #16, #16
    sbfx r9, r9, #0, #16
    vmov s15, r11
    vmov s16, r12
    vmov r11, s10
    vmov r12, s11
    smmulr lr, r9, r11
    mls r9, lr, r12, r9
    smmulr lr, r10, r11
    mls r10, lr, r12, r10
    pkhbt r9, r9, r10, lsl #16
    vmov s12, r9
    vmov lr, s19
    vmov s0, r0
    mov.w r0, #0
    pkhbt r9, r1, r2, lsl #16
    pkhtb r10, r2, r1, asr #16
    pkhbt r11, r5, r6, lsl #16
    pkhtb r12, r6, r5, asr #16
    ssub16 r1, r0, r9
    ssub16 r2, r0, r10
    sadd16 r5, r9, r11
    sadd16 r6, r10, r12
    ssub16 r9, r9, r11
    ssub16 r10, r10, r12
    ssub16 r11, r0, r11
    ssub16 r12, r0, r12
    str r1, [lr, #16]
    str r2, [lr, #48]
    str r5, [lr]
    str r6, [lr, #32]
    str r9, [lr, #8]
    str r10, [lr, #40]
    str r11, [lr, #24]
    str r12, [lr, #56]
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    pkhbt r5, r3, r4, lsl #16
    pkhtb r6, r4, r3, asr #16
    sadd16 r2, r5, r11
    sadd16 r1, r6, r12
    ssub16 r3, r0, r4
    ssub16 r4, r5, r11
    ssub16 r7, r6, r12
    pkhbt r8, r5, r3, lsl #16
    pkhtb r9, r3, r6
    str r11, [lr, #28]
    str r12, [lr, #60]
    str r1, [lr, #36]
    str r7, [lr, #44]
    str r8, [lr, #20]
    str r9, [lr, #52]
    ldr r1, [lr]
    ldr r3, [lr, #8]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
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
    vmov lr, s19
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
    vmov s13, r9
    vmov s14, r10
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
    vmov r10, s13
    vmov r11, s14
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s19
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s15
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
    vmov lr, s20
    ldm lr, {r1-r4}
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
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
    vmov lr, s20
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
    vmov s13, r9
    vmov s14, r10
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
    vmov r10, s13
    vmov r11, s14
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov r0, s20
    ldm r0, {r5-r8}
    vmov lr, s16
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    sadd16 r9, r9, lr
    sadd16 r10, r10, lr
    sadd16 r11, r11, lr
    sadd16 r12, r12, lr
    sadd16 r1, r1, lr
    sadd16 r2, r2, lr
    sadd16 r3, r3, lr
    sadd16 r4, r4, lr
    str.w r4, [r0, #28]
    vmov r0, s1
    vmov lr, s19
    ldr.w r4, [lr]
    ldr.w r5, [lr, #4]
    ldr.w r6, [lr, #8]
    pkhbt r7, r4, r9, lsl #16
    pkhtb r8, r9, r4, asr #16
    pkhbt r4, r5, r11, lsl #16
    pkhtb r9, r11, r5, asr #16
    pkhbt r5, r6, r1, lsl #16
    pkhtb r11, r1, r6, asr #16
    str.w r7, [r0, #2520]
    str.w r8, [r0, #1440]
    str.w r4, [r0, #1260]
    str.w r9, [r0, #720]
    str.w r5, [r0, #2160]
    str.w r11, [r0, #360]
    ldr.w r1, [lr, #12]
    ldr.w r4, [lr, #16]
    ldr.w r5, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r3, lsl #16
    pkhtb r11, r3, r1, asr #16
    pkhbt r1, r4, r10, lsl #16
    pkhtb r3, r10, r4, asr #16
    pkhbt r4, r5, r12, lsl #16
    pkhtb r10, r12, r5, asr #16
    pkhbt r5, r6, r2, lsl #16
    pkhtb r12, r2, r6, asr #16
    pkhbt r2, r7, r8, lsl #16
    pkhtb r6, r8, r7, asr #16
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
    vmov r1, s12
    str.w r1, [r0], #4
    vmov s1, r0
    vmov r0, s0
    vmov r2, s17
    cmp.w r0, r2
    bne.w fft17_body1

    ldr.w r1, [r0, #1080]
    ldr.w r2, [r0, #360]
    ldr.w r3, [r0, #900]
    ldr.w r4, [r0, #720]
    ldr.w r5, [r0, #1260]
    ldr.w r6, [r0, #1440]
    ldr.w r7, [r0, #540]
    ldr.w r8, [r0, #180]
    ldr.w r9, [r0], #4
    ubfx r6, r6, #0, #16
    pkhbt r11, r9, r9, lsl #16
    pkhtb r12, r9, r9, asr #16
    sadd16 r9, r9, r1
    sadd16 r9, r9, r2
    sadd16 r9, r9, r3
    sadd16 r9, r9, r4
    sadd16 r9, r9, r5
    sadd16 r9, r9, r6
    sadd16 r9, r9, r7
    sadd16 r9, r9, r8
    sbfx r10, r9, #16, #16
    sbfx r9, r9, #0, #16
    vmov s15, r11
    vmov s16, r12
    vmov r11, s10
    vmov r12, s11
    smmulr lr, r9, r11
    mls r9, lr, r12, r9
    smmulr lr, r10, r11
    mls r10, lr, r12, r10
    pkhbt r9, r9, r10, lsl #16
    vmov s12, r9
    vmov lr, s19
    vmov s0, r0
    mov.w r0, #0
    pkhbt r9, r1, r2, lsl #16
    pkhtb r10, r2, r1, asr #16
    pkhbt r11, r5, r6, lsl #16
    pkhtb r12, r6, r5, asr #16
    ssub16 r1, r0, r9
    ssub16 r2, r0, r10
    sadd16 r5, r9, r11
    sadd16 r6, r10, r12
    ssub16 r9, r9, r11
    ssub16 r10, r10, r12
    ssub16 r11, r0, r11
    ssub16 r12, r0, r12
    str r1, [lr, #16]
    str r2, [lr, #48]
    str r5, [lr]
    str r6, [lr, #32]
    str r9, [lr, #8]
    str r10, [lr, #40]
    str r11, [lr, #24]
    str r12, [lr, #56]
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    pkhbt r5, r3, r4, lsl #16
    pkhtb r6, r4, r3, asr #16
    sadd16 r2, r5, r11
    sadd16 r1, r6, r12
    ssub16 r3, r0, r4
    ssub16 r4, r5, r11
    ssub16 r7, r6, r12
    pkhbt r8, r5, r3, lsl #16
    pkhtb r9, r3, r6
    str r11, [lr, #28]
    str r12, [lr, #60]
    str r1, [lr, #36]
    str r7, [lr, #44]
    str r8, [lr, #20]
    str r9, [lr, #52]
    ldr r1, [lr]
    ldr r3, [lr, #8]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
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
    vmov lr, s19
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
    vmov s13, r9
    vmov s14, r10
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
    vmov r10, s13
    vmov r11, s14
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s19
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s15
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
    vmov lr, s20
    ldm lr, {r1-r4}
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
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
    vmov lr, s20
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
    vmov s13, r9
    vmov s14, r10
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
    vmov r10, s13
    vmov r11, s14
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov r0, s20
    ldm r0, {r5-r8}
    vmov lr, s16
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    sadd16 r9, r9, lr
    sadd16 r10, r10, lr
    sadd16 r11, r11, lr
    sadd16 r12, r12, lr
    sadd16 r1, r1, lr
    sadd16 r2, r2, lr
    sadd16 r3, r3, lr
    sadd16 r4, r4, lr
    str.w r4, [r0, #28]
    vmov r0, s1
    vmov lr, s19
    ldr.w r4, [lr]
    ldr.w r5, [lr, #4]
    ldr.w r6, [lr, #8]
    pkhbt r7, r4, r9, lsl #16
    pkhtb r8, r9, r4, asr #16
    pkhbt r4, r5, r11, lsl #16
    pkhtb r9, r11, r5, asr #16
    pkhbt r5, r6, r1, lsl #16
    pkhtb r11, r1, r6, asr #16
    str.w r7, [r0, #2520]
    str.w r8, [r0, #1440]
    str.w r4, [r0, #1260]
    str.w r9, [r0, #720]
    str.w r5, [r0, #2160]
    str.w r11, [r0, #360]
    ldr.w r1, [lr, #12]
    ldr.w r4, [lr, #16]
    ldr.w r5, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r3, lsl #16
    pkhtb r11, r3, r1, asr #16
    pkhbt r1, r4, r10, lsl #16
    pkhtb r3, r10, r4, asr #16
    pkhbt r4, r5, r12, lsl #16
    pkhtb r10, r12, r5, asr #16
    pkhbt r5, r6, r2, lsl #16
    pkhtb r12, r2, r6, asr #16
    pkhbt r2, r7, r8, lsl #16
    pkhtb r6, r8, r7, asr #16
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
    vmov r1, s12
    str.w r1, [r0], #4
    vmov s1, r0
    vmov r0, s0
fft17_body2:
    ldr.w r1, [r0, #1080]
    ldr.w r2, [r0, #360]
    ldr.w r3, [r0, #900]
    ldr.w r4, [r0, #720]
    ldr.w r5, [r0, #1260]
    ldr.w r7, [r0, #540]
    ldr.w r8, [r0, #180]
    ldr.w r9, [r0], #4
    mov.w r6, #0
    pkhbt r11, r9, r9, lsl #16
    pkhtb r12, r9, r9, asr #16
    sadd16 r9, r9, r1
    sadd16 r9, r9, r2
    sadd16 r9, r9, r3
    sadd16 r9, r9, r4
    sadd16 r9, r9, r5
    sadd16 r9, r9, r7
    sadd16 r9, r9, r8
    sbfx r10, r9, #16, #16
    sbfx r9, r9, #0, #16
    vmov s15, r11
    vmov s16, r12
    vmov r11, s10
    vmov r12, s11
    smmulr lr, r9, r11
    mls r9, lr, r12, r9
    smmulr lr, r10, r11
    mls r10, lr, r12, r10
    pkhbt r9, r9, r10, lsl #16
    vmov s12, r9
    vmov lr, s19
    vmov s0, r0
    mov.w r0, #0
    pkhbt r9, r1, r2, lsl #16
    pkhtb r10, r2, r1, asr #16
    pkhbt r11, r5, r6, lsl #16
    pkhtb r12, r6, r5, asr #16
    ssub16 r1, r0, r9
    ssub16 r2, r0, r10
    sadd16 r5, r9, r11
    sadd16 r6, r10, r12
    ssub16 r9, r9, r11
    ssub16 r10, r10, r12
    ssub16 r11, r0, r11
    ssub16 r12, r0, r12
    str r1, [lr, #16]
    str r2, [lr, #48]
    str r5, [lr]
    str r6, [lr, #32]
    str r9, [lr, #8]
    str r10, [lr, #40]
    str r11, [lr, #24]
    str r12, [lr, #56]
    pkhbt r11, r7, r8, lsl #16
    pkhtb r12, r8, r7, asr #16
    pkhbt r5, r3, r4, lsl #16
    pkhtb r6, r4, r3, asr #16
    sadd16 r2, r5, r11
    sadd16 r1, r6, r12
    ssub16 r3, r0, r4
    ssub16 r4, r5, r11
    ssub16 r7, r6, r12
    pkhbt r8, r5, r3, lsl #16
    pkhtb r9, r3, r6
    str r11, [lr, #28]
    str r12, [lr, #60]
    str r1, [lr, #36]
    str r7, [lr, #44]
    str r8, [lr, #20]
    str r9, [lr, #52]
    ldr r1, [lr]
    ldr r3, [lr, #8]
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
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
    vmov lr, s19
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
    vmov s13, r9
    vmov s14, r10
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
    vmov r10, s13
    vmov r11, s14
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov lr, s19
    ldm lr, {r5-r8}
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    vmov r6, s15
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
    vmov lr, s20
    ldm lr, {r1-r4}
    vmov r5, s2
    vmov r6, s3
    vmov r7, s4
    vmov r8, s5
    vmov r0, s10
    vmov lr, s11
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
    vmov lr, s20
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
    vmov s13, r9
    vmov s14, r10
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
    vmov r10, s13
    vmov r11, s14
    pkhbt r1, r6, r10, lsl #16
    pkhtb r2, r10, r6, asr #16
    pkhbt r3, r8, r11, lsl #16
    pkhtb r4, r11, r9
    vmov r0, s20
    ldm r0, {r5-r8}
    vmov lr, s16
    sadd16 r9, r5, r1
    ssub16 r10, r5, r1
    sadd16 r11, r6, r2
    ssub16 r12, r6, r2
    sadd16 r1, r7, r3
    ssub16 r2, r7, r3
    sadd16 r3, r8, r4
    ssub16 r4, r8, r4
    sadd16 r9, r9, lr
    sadd16 r10, r10, lr
    sadd16 r11, r11, lr
    sadd16 r12, r12, lr
    sadd16 r1, r1, lr
    sadd16 r2, r2, lr
    sadd16 r3, r3, lr
    sadd16 r4, r4, lr
    str.w r4, [r0, #28]
    vmov r0, s1
    vmov lr, s19
    ldr.w r4, [lr]
    ldr.w r5, [lr, #4]
    ldr.w r6, [lr, #8]
    pkhbt r7, r4, r9, lsl #16
    pkhtb r8, r9, r4, asr #16
    pkhbt r4, r5, r11, lsl #16
    pkhtb r9, r11, r5, asr #16
    pkhbt r5, r6, r1, lsl #16
    pkhtb r11, r1, r6, asr #16
    str.w r7, [r0, #2520]
    str.w r8, [r0, #1440]
    str.w r4, [r0, #1260]
    str.w r9, [r0, #720]
    str.w r5, [r0, #2160]
    str.w r11, [r0, #360]
    ldr.w r1, [lr, #12]
    ldr.w r4, [lr, #16]
    ldr.w r5, [lr, #20]
    ldr.w r6, [lr, #24]
    ldr.w r7, [lr, #28]
    ldr.w r8, [lr, #60]
    pkhbt r9, r1, r3, lsl #16
    pkhtb r11, r3, r1, asr #16
    pkhbt r1, r4, r10, lsl #16
    pkhtb r3, r10, r4, asr #16
    pkhbt r4, r5, r12, lsl #16
    pkhtb r10, r12, r5, asr #16
    pkhbt r5, r6, r2, lsl #16
    pkhtb r12, r2, r6, asr #16
    pkhbt r2, r7, r8, lsl #16
    pkhtb r6, r8, r7, asr #16
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
    vmov r1, s12
    str.w r1, [r0], #4
    vmov s1, r0
    vmov r0, s0
    vmov r2, s18
    cmp.w r0, r2
    bne.w fft17_body2
    vpop {s16-s20}
    pop {r2-r12, pc}

