.p2align 2,,3
.syntax unified

.text
.global polymul_10x10_153_mr
.type polymul_10x10_153_mr, %function
@ polymul_10x10_153_mr(fpad, gpad), fpad = fpad * gpad, 10x10 polynomial multiplication * 153 times
polymul_10x10_153_mr:
    push {r2-r12, lr}
    vpush {s16}
    adr lr, wpad
    movw.w r12, #4591
    movt.w r12, #49905
    vmov s14, lr
    vmov s15, r12
    add r10, r0, #3060
    vmov s16, r10
polymul_10x10_153_mr_body:
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
    smultt r3, r5, r12
    smlad r3, r6, r11, r3 @ c16
    smultt r4, r6, r12 @ c18
    smulbb r5, r2, r12 @ c0
@ r0 = c2, r1 = c10, r3 = c16, r4 = c18, r5 = c0, r7 = c12, lr = c14
    vmov r2, s14
    ldr r11, [r2], #4 @ wi
    vmov s14, r2
    vmov r12, s15 @ mr q, qinv
    vmov r2, s6 @ c1
    vmov r6, s7 @ c11
    vmov r8, s5 @ c3
    vmov r9, s8 @ c13
    smulbt r10, r1, r12
    smlabb r1, r10, r12, r1
    smlabt r1, r11, r1, r5
    smulbt r10, r1, r12
    smlabb r1, r10, r12, r1 @ d0/R
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6
    smlabt r6, r11, r6, r2
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6 @ d1/R
    pkhtb r1, r6, r1, asr #16
    smulbt r10, r7, r12
    smlabb r7, r10, r12, r7
    smlabt r7, r11, r7, r0
    smulbt r10, r7, r12
    smlabb r7, r10, r12, r7 @ d2/R
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9
    smlabt r9, r11, r9, r8
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9 @ d3/R
    pkhtb r2, r9, r7, asr #16
@ r3 = c16, r4 = c18, lr = c14
    vmov r0, s13 @ c4
    vmov r5, s4 @ c5
    vmov r6, s9 @ c15
    vmov r7, s12 @ c6
    vmov r8, s3 @ c7
    vmov r9, s10 @ c17
    smulbt r10, lr, r12
    smlabb lr, r10, r12, lr
    smlabt lr, r11, lr, r0
    smulbt r10, lr, r12
    smlabb lr, r10, r12, lr @ d4/R
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6
    smlabt r6, r11, r6, r5
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6 @ d5/R
    pkhtb lr, r6, lr, asr #16
    smulbt r10, r3, r12
    smlabb r3, r10, r12, r3
    smlabt r3, r11, r3, r7
    smulbt r10, r3, r12
    smlabb r3, r10, r12, r3 @ d6/R
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9
    smlabt r9, r11, r9, r8
    smulbt r10, r9, r12
    smlabb r9, r10, r12, r9 @ d7/R
    pkhtb r3, r9, r3, asr #16
    vmov r0, s0
    vmov r5, s11 @ c8
    vmov r6, s2 @ c9
    smulbt r10, r4, r12
    smlabb r4, r10, r12, r4
    smlabt r4, r11, r4, r5
    smulbt r10, r4, r12
    smlabb r4, r10, r12, r4 @ d8/R
    smulbt r10, r6, r12
    smlabb r6, r10, r12, r6 @ d9/R
    pkhtb r4, r6, r4, asr #16
    str.w r2, [r0, #4]
    str.w lr, [r0, #8]
    str.w r3, [r0, #12]
    str.w r4, [r0, #16]
    str.w r1, [r0], #20
    vmov r1, s1
    vmov r2, s16
    cmp.w r0, r2
    bne.w polymul_10x10_153_mr_body
    vpop {s16}
    pop {r2-r12, pc}

wpad:
    .word 1262
    .word -2247
    .word 985
    .word 1985
    .word -2141
    .word 156
    .word 1969
    .word -1756
    .word -213
    .word -1235
    .word -1559
    .word -1797
    .word -1757
    .word 98
    .word 1659
    .word -1574
    .word -1723
    .word -1294
    .word 1787
    .word -246
    .word -1541
    .word 297
    .word -547
    .word 250
    .word -2083
    .word 482
    .word 1601
    .word -1214
    .word 1092
    .word 122
    .word 1481
    .word -1491
    .word 10
    .word -2287
    .word -348
    .word -1956
    .word 686
    .word -2160
    .word 1474
    .word 1712
    .word 124
    .word -1836
    .word 1194
    .word 537
    .word -1731
    .word 762
    .word 1750
    .word 2079
    .word -1217
    .word 2025
    .word -808
    .word -1605
    .word -1264
    .word -1722
    .word -1255
    .word 70
    .word 1185
    .word 2155
    .word 81
    .word -2236
    .word 854
    .word 684
    .word -1538
    .word 868
    .word 921
    .word -1789
    .word -832
    .word 1656
    .word -824
    .word 1136
    .word 211
    .word -1347
    .word 402
    .word -1065
    .word 663
    .word 334
    .word 1719
    .word -2053
    .word 780
    .word 743
    .word -1523
    .word 567
    .word -1879
    .word 1312
    .word 197
    .word -1584
    .word 1387
    .word -887
    .word 397
    .word 490
    .word -2181
    .word -1177
    .word -1233
    .word 1477
    .word -247
    .word -1230
    .word 1250
    .word 1485
    .word 1856
    .word -1740
    .word -598
    .word -2253
    .word 610
    .word -1479
    .word 869
    .word 50
    .word -1777
    .word 1727
    .word -1906
    .word 527
    .word 1379
    .word -1812
    .word -1161
    .word -1618
    .word 2
    .word -622
    .word 620
    .word -1729
    .word 572
    .word 1157
    .word 1213
    .word -781
    .word -432
    .word 551
    .word -1494
    .word 943
    .word -1171
    .word 1492
    .word -321
    .word 1334
    .word -1684
    .word 350
    .word -1998
    .word 1593
    .word 405
    .word 1055
    .word -2144
    .word 1089
    .word 237
    .word -251
    .word 14
    .word 471
    .word 431
    .word -902
    .word -876
    .word 1567
    .word -691
    .word -1276
    .word 2010
    .word -734
    .word -1083
    .word 1670
    .word -587