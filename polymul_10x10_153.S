.p2align 2,,3
.syntax unified

.text
.global polymul_10x10_153
.type polymul_10x10_153, %function
polymul_10x10_153:
    push {r2-r12, lr}
    adr lr, wpad
    mov r12, #4591
    movw r11, #18015
    movt r11, #14
    vmov s18, lr
    vmov s19, r12
    vmov s20, r11
    add r10, r0, #3060
    vmov s21, r10
polymul_10x10_153_body:
    ldr r8, [r1, #4]
    ldr r9, [r1, #8]
    ldr r10, [r1, #12]
    ldr r11, [r1, #16]
    ldr r7, [r1], #20
    ldm r0, {r2-r6}
    vmov s0, r0
    vmov s1, r1
    smuadx r0, r2, r11
    smladx r0, r3, r10, r0
    smladx r0, r4, r9, r0
    smladx r0, r5, r8, r0
    smladx r0, r6, r7, r0
    smuadx r1, r2, r10
    smladx r1, r3, r9, r1
    smladx r1, r4, r8, r1
    smladx r1, r5, r7, r1
    smuadx r12, r2, r9
    smladx r12, r3, r8, r12
    smladx r12, r4, r7, r12
    smuadx lr, r2, r8
    smladx lr, r3, r7, lr
    vmov s2, r0 @ c9
    vmov s3, r1 @ c7
    vmov s4, r12 @ c5
    vmov s5, lr @ c3
    smuadx r0, r2, r7
    smuadx r1, r3, r11
    smladx r1, r4, r10, r1
    smladx r1, r5, r9, r1
    smladx r1, r6, r8, r1
    smuadx r12, r4, r11
    smladx r12, r5, r10, r12
    smladx r12, r6, r9, r12
    smuadx lr, r5, r11
    smladx lr, r6, r10, lr
    vmov s6, r0 @ c1
    vmov s7, r1 @ c11
    vmov s8, r12 @ c13
    vmov s9, lr @ c15
    smuadx r0, r6, r11
    pkhbt r12, r7, r11 @ b09
    pkhbt r11, r11, r10 @ b87
    pkhbt r10, r10, r9 @ b65
    pkhbt r9, r9, r8 @ b43
    pkhbt r8, r8, r7 @ b21
    smulbb r1, r6, r12
    smlad r1, r2, r11, r1
    smlad r1, r3, r10, r1
    smlad r1, r4, r9, r1
    smlad r1, r5, r8, r1
    smulbb r7, r5, r12
    smlad r7, r2, r10, r7
    smlad r7, r3, r9, r7
    smlad r7, r4, r8, r7
    smulbb lr, r4, r12
    smlad lr, r2, r9, lr
    smlad lr, r3, r8, lr
    vmov s10, r0 @ c17
    vmov s11, r1 @ c8
    vmov s12, r7 @ c6
    vmov s13, lr @ c4
    smulbb r0, r3, r12
    smlad r0, r2, r8, r0
    smultt r1, r2, r12
    smlad r1, r3, r11, r1
    smlad r1, r4, r10, r1
    smlad r1, r5, r9, r1
    smlad r1, r6, r8, r1
    smultt r7, r3, r12
    smlad r7, r4, r11, r7
    smlad r7, r5, r10, r7
    smlad r7, r6, r9, r7
    smultt lr, r4, r12
    smlad lr, r5, r11, lr
    smlad lr, r6, r10, lr
    vmov s14, r0 @ c2
    vmov s15, r1 @ c10
    vmov s16, r7 @ c12
    vmov s17, lr @ c14
    smultt r0, r5, r12
    smlad r0, r6, r11, r0 @ c16
    smultt r1, r6, r12 @ c18
    smulbb r7, r2, r12 @ c0
    vmov lr, s18
    ldr r10, [lr], #4 @ wi
    vmov s18, lr
    vmov r11, s20 @ 935519
    vmov r12, s19 @ 4591
    vmov r2, s11 @ c8
    vmov r3, s2 @ c9
    vmov r4, s12 @ c6
    vmov r5, s10 @ c17
    vmov r6, s3 @ c7
    vmov r8, s15 @ c10
    smmulr r9, r3, r11
    mls r3, r9, r12, r3
    smmulr r9, r1, r11
    mls r1, r9, r12, r1
    mla r1, r1, r10, r2
    smmulr r9, r1, r11
    mls r1, r9, r12, r1
    pkhbt r1, r1, r3, lsl #16 @ d89
    smmulr r9, r0, r11
    mls r0, r9, r12, r0
    mla r0, r0, r10, r4
    smmulr r9, r0, r11
    mls r0, r9, r12, r0
    smmulr r9, r5, r11
    mls r5, r9, r12, r5
    mla r5, r5, r10, r6
    smmulr r9, r5, r11
    mls r5, r9, r12, r5
    pkhbt r2, r0, r5, lsl #16 @ d67
    smmulr r9, r8, r11
    mls r8, r9, r12, r8
    mla r8, r8, r10, r7
    smmulr r9, r8, r11
    mls r3, r9, r12, r8 @ d0
    vmov r4, s6
    vmov r5, s7
    vmov r6, s14
    vmov r7, s16
    vmov r8, s5
    vmov r9, s8
    smmulr r0, r5, r11
    mls r5, r0, r12, r5
    mla r4, r5, r10, r4
    smmulr r0, r4, r11
    mls r4, r0, r12, r4
    pkhbt r3, r3, r4, lsl #16 @ d01
    smmulr r0, r7, r11
    mls r7, r0, r12, r7
    mla r6, r7, r10, r6
    smmulr r0, r6, r11
    mls r6, r0, r12, r6
    smmulr r0, r9, r11
    mls r9, r0, r12, r9
    mla r8, r9, r10, r8
    smmulr r0, r8, r11
    mls r8, r0, r12, r8
    pkhbt r4, r6, r8, lsl #16 @ d23
    vmov r5, s13
    vmov r6, s17
    vmov r7, s4
    vmov r8, s9
    vmov r0, s0
    smmulr r9, r6, r11
    mls r6, r9, r12, r6
    mla r5, r6, r10, r5
    smmulr r9, r5, r11
    mls r5, r9, r12, r5
    smmulr r9, r8, r11
    mls r8, r9, r12, r8
    mla r7, r8, r10, r7
    smmulr r9, r7, r11
    mls r7, r9, r12, r7
    pkhbt r5, r5, r7, lsl #16 @ d45
    str.w r4, [r0, #4]
    str.w r5, [r0, #8]
    str.w r2, [r0, #12]
    str.w r1, [r0, #16]
    str.w r3, [r0], #20
    vmov r1, s1
    vmov r2, s21
    cmp.w r0, r2
    bne.w polymul_10x10_153_body

    pop {r2-r12, pc}

wpad:
    .word 1
    .word 4280
    .word 310
    .word 2559
    .word 2985
    .word 3638
    .word 1715
    .word 3782
    .word 3685
    .word 2571
    .word 3844
    .word 2767
    .word 286
    .word 2874
    .word 1431
    .word 1905
    .word 4375
    .word 2902
    .word 3592
    .word 3092
    .word 2498
    .word 746
    .word 2135
    .word 1710
    .word 3749
    .word 175
    .word 667
    .word 2531
    .word 2511
    .word 4140
    .word 3519
    .word 2840
    .word 2823
    .word 2170
    .word 7
    .word 2414
    .word 1754
    .word 835
    .word 2002
    .word 3079
    .word 1950
    .word 4153
    .word 1005
    .word 4224
    .word 3953
    .word 1172
    .word 2788
    .word 631
    .word 1225
    .word 78
    .word 3288
    .word 3713
    .word 2189
    .word 3280
    .word 1516
    .word 1397
    .word 1678
    .word 49
    .word 3125
    .word 1417
    .word 1434
    .word 3944
    .word 3804
    .word 4468
    .word 1525
    .word 3189
    .word 2022
    .word 125
    .word 2444
    .word 241
    .word 3096
    .word 1254
    .word 546
    .word 61
    .word 3984
    .word 1550
    .word 5
    .word 3036
    .word 4417
    .word 3613
    .word 1152
    .word 3511
    .word 737
    .word 343
    .word 62
    .word 3673
    .word 856
    .word 2564
    .word 1430
    .word 597
    .word 875
    .word 3335
    .word 381
    .word 3308
    .word 4187
    .word 1687
    .word 3959
    .word 3730
    .word 1493
    .word 35
    .word 2888
    .word 1668
    .word 2336
    .word 3473
    .word 3373
    .word 342
    .word 3822
    .word 427
    .word 2756
    .word 1401
    .word 434
    .word 828
    .word 4179
    .word 4175
    .word 2401
    .word 1622
    .word 568
    .word 1763
    .word 2627
    .word 201
    .word 3155
    .word 1269
    .word 167
    .word 2667
    .word 1534
    .word 390
    .word 1356
    .word 656
    .word 2579
    .word 3799
    .word 2989
    .word 2394
    .word 2494
    .word 245
    .word 1852
    .word 1707
    .word 1679
    .word 1205
    .word 2172
    .word 3976
    .word 3034
    .word 3038
    .word 928
    .word 625
    .word 4292
    .word 1169
    .word 3721
    .word 1556
    .word 2730
    .word 305
    .word 1407
    .word 3159
    .word 25