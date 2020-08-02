.p2align 2,,3
.syntax unified

.text
.global mod_reduce
.type mod_reduce, %function
@mod_reduce(int16_t* h, int16_t* hpad)
mod_reduce:
    push {r2-r12, lr}
    add.w r2, r1, #1522
    add.w r3, r1, #3042
    vmov s0, r0
    mov.w lr, #0
    movw.w r10, #18015
    movt.w r10, #14
    @ mov.w r10, #14
    @ mov.w r11, #32768
    mov.w r12, #4591
    ldr.w r4, [r1], #4
loop:
    ldr.w r5, [r1], #4
    ldr.w r6, [r2], #4
    sadd16 r4, r4, r6
    pkhtb r7, lr, r6, asr #16
    pkhbt r6, lr, r6, lsl #16
    sadd16 r4, r4, r6
    sadd16 r5, r5, r7
    @ smlawb r6, r10, r4, r11
    @ smlawt r7, r10, r4, r11
    @ mul r8, r6, r12
    @ mul r9, r7, r12
    @ pkhbt r8, r8, r9, lsl #16
    @ ssub16 r4, r4, r8
    sbfx r6, r4, #0, #16
    sbfx r7, r4, #16, #16
    smmulr r8, r6, r10
    mls r6, r8, r12, r6
    smmulr r8, r7, r10
    mls r7, r8, r12, r7
    pkhbt r4, r6, r7, lsl #16
    str.w r4, [r0], #4
    ldr.w r4, [r1], #4
    ldr.w r6, [r2], #4
    sadd16 r5, r5, r6
    pkhtb r7, lr, r6, asr #16
    pkhbt r6, lr, r6, lsl #16
    sadd16 r5, r5, r6
    sadd16 r4, r4, r7
    @ smlawb r6, r10, r5, r11
    @ smlawt r7, r10, r5, r11
    @ mul r8, r6, r12
    @ mul r9, r7, r12
    @ pkhbt r8, r8, r9, lsl #16
    @ ssub16 r5, r5, r8
    sbfx r6, r5, #0, #16
    sbfx r7, r5, #16, #16
    smmulr r8, r6, r10
    mls r6, r8, r12, r6
    smmulr r8, r7, r10
    mls r7, r8, r12, r7
    pkhbt r5, r6, r7, lsl #16
    str.w r5, [r0], #4
    cmp.w r2, r3
    bne.w loop
    sbfx r4, r4, #0, #16
    smmulr r8, r4, r10
    mls r4, r8, r12, r4
    @ smlawb r6, r10, r4, r11
    @ mls r4, r6, r12, r4
    vmov r0, s0
    ldr.w r5, [r0, #1518]
    pkhbt r5, r5, r4, lsl #16
    str.w r5, [r0, #1518]
    pop {r2-r12, pc}

