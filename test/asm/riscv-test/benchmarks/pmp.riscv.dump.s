
pmp.riscv:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000080000000 <_start>:
    80000000:	00000093          	li	ra,0
    80000004:	00000113          	li	sp,0
    80000008:	00000193          	li	gp,0
    8000000c:	00000213          	li	tp,0
    80000010:	00000293          	li	t0,0
    80000014:	00000313          	li	t1,0
    80000018:	00000393          	li	t2,0
    8000001c:	00000413          	li	s0,0
    80000020:	00000493          	li	s1,0
    80000024:	00000513          	li	a0,0
    80000028:	00000593          	li	a1,0
    8000002c:	00000613          	li	a2,0
    80000030:	00000693          	li	a3,0
    80000034:	00000713          	li	a4,0
    80000038:	00000793          	li	a5,0
    8000003c:	00000813          	li	a6,0
    80000040:	00000893          	li	a7,0
    80000044:	00000913          	li	s2,0
    80000048:	00000993          	li	s3,0
    8000004c:	00000a13          	li	s4,0
    80000050:	00000a93          	li	s5,0
    80000054:	00000b13          	li	s6,0
    80000058:	00000b93          	li	s7,0
    8000005c:	00000c13          	li	s8,0
    80000060:	00000c93          	li	s9,0
    80000064:	00000d13          	li	s10,0
    80000068:	00000d93          	li	s11,0
    8000006c:	00000e13          	li	t3,0
    80000070:	00000e93          	li	t4,0
    80000074:	00000f13          	li	t5,0
    80000078:	00000f93          	li	t6,0
    8000007c:	0001e2b7          	lui	t0,0x1e
    80000080:	3002a073          	csrs	mstatus,t0
    80000084:	00100293          	li	t0,1
    80000088:	01f29293          	slli	t0,t0,0x1f
    8000008c:	0002da63          	bgez	t0,800000a0 <_start+0xa0>
    80000090:	00100513          	li	a0,1
    80000094:	00001297          	auipc	t0,0x1
    80000098:	f6a2a623          	sw	a0,-148(t0) # 80001000 <tohost>
    8000009c:	ff5ff06f          	j	80000090 <_start+0x90>
    800000a0:	00000297          	auipc	t0,0x0
    800000a4:	04428293          	addi	t0,t0,68 # 800000e4 <trap_entry>
    800000a8:	30529073          	csrw	mtvec,t0
    800000ac:	00004197          	auipc	gp,0x4
    800000b0:	b6418193          	addi	gp,gp,-1180 # 80003c10 <__global_pointer$>
    800000b4:	00008217          	auipc	tp,0x8
    800000b8:	f8b20213          	addi	tp,tp,-117 # 8000803f <_end+0x3f>
    800000bc:	fc027213          	andi	tp,tp,-64
    800000c0:	f1402573          	csrr	a0,mhartid
    800000c4:	00100593          	li	a1,1
    800000c8:	00b57063          	bgeu	a0,a1,800000c8 <_start+0xc8>
    800000cc:	00150113          	addi	sp,a0,1
    800000d0:	01111113          	slli	sp,sp,0x11
    800000d4:	00410133          	add	sp,sp,tp
    800000d8:	01151613          	slli	a2,a0,0x11
    800000dc:	00c20233          	add	tp,tp,a2
    800000e0:	3750206f          	j	80002c54 <_init>

00000000800000e4 <trap_entry>:
    800000e4:	ef010113          	addi	sp,sp,-272
    800000e8:	00113423          	sd	ra,8(sp)
    800000ec:	00213823          	sd	sp,16(sp)
    800000f0:	00313c23          	sd	gp,24(sp)
    800000f4:	02413023          	sd	tp,32(sp)
    800000f8:	02513423          	sd	t0,40(sp)
    800000fc:	02613823          	sd	t1,48(sp)
    80000100:	02713c23          	sd	t2,56(sp)
    80000104:	04813023          	sd	s0,64(sp)
    80000108:	04913423          	sd	s1,72(sp)
    8000010c:	04a13823          	sd	a0,80(sp)
    80000110:	04b13c23          	sd	a1,88(sp)
    80000114:	06c13023          	sd	a2,96(sp)
    80000118:	06d13423          	sd	a3,104(sp)
    8000011c:	06e13823          	sd	a4,112(sp)
    80000120:	06f13c23          	sd	a5,120(sp)
    80000124:	09013023          	sd	a6,128(sp)
    80000128:	09113423          	sd	a7,136(sp)
    8000012c:	09213823          	sd	s2,144(sp)
    80000130:	09313c23          	sd	s3,152(sp)
    80000134:	0b413023          	sd	s4,160(sp)
    80000138:	0b513423          	sd	s5,168(sp)
    8000013c:	0b613823          	sd	s6,176(sp)
    80000140:	0b713c23          	sd	s7,184(sp)
    80000144:	0d813023          	sd	s8,192(sp)
    80000148:	0d913423          	sd	s9,200(sp)
    8000014c:	0da13823          	sd	s10,208(sp)
    80000150:	0db13c23          	sd	s11,216(sp)
    80000154:	0fc13023          	sd	t3,224(sp)
    80000158:	0fd13423          	sd	t4,232(sp)
    8000015c:	0fe13823          	sd	t5,240(sp)
    80000160:	0ff13c23          	sd	t6,248(sp)
    80000164:	34202573          	csrr	a0,mcause
    80000168:	341025f3          	csrr	a1,mepc
    8000016c:	00010613          	mv	a2,sp
    80000170:	2f8020ef          	jal	80002468 <handle_trap>
    80000174:	34151073          	csrw	mepc,a0
    80000178:	000022b7          	lui	t0,0x2
    8000017c:	8002829b          	addiw	t0,t0,-2048 # 1800 <buflen.1+0x17c0>
    80000180:	3002a073          	csrs	mstatus,t0
    80000184:	00813083          	ld	ra,8(sp)
    80000188:	01013103          	ld	sp,16(sp)
    8000018c:	01813183          	ld	gp,24(sp)
    80000190:	02013203          	ld	tp,32(sp)
    80000194:	02813283          	ld	t0,40(sp)
    80000198:	03013303          	ld	t1,48(sp)
    8000019c:	03813383          	ld	t2,56(sp)
    800001a0:	04013403          	ld	s0,64(sp)
    800001a4:	04813483          	ld	s1,72(sp)
    800001a8:	05013503          	ld	a0,80(sp)
    800001ac:	05813583          	ld	a1,88(sp)
    800001b0:	06013603          	ld	a2,96(sp)
    800001b4:	06813683          	ld	a3,104(sp)
    800001b8:	07013703          	ld	a4,112(sp)
    800001bc:	07813783          	ld	a5,120(sp)
    800001c0:	08013803          	ld	a6,128(sp)
    800001c4:	08813883          	ld	a7,136(sp)
    800001c8:	09013903          	ld	s2,144(sp)
    800001cc:	09813983          	ld	s3,152(sp)
    800001d0:	0a013a03          	ld	s4,160(sp)
    800001d4:	0a813a83          	ld	s5,168(sp)
    800001d8:	0b013b03          	ld	s6,176(sp)
    800001dc:	0b813b83          	ld	s7,184(sp)
    800001e0:	0c013c03          	ld	s8,192(sp)
    800001e4:	0c813c83          	ld	s9,200(sp)
    800001e8:	0d013d03          	ld	s10,208(sp)
    800001ec:	0d813d83          	ld	s11,216(sp)
    800001f0:	0e013e03          	ld	t3,224(sp)
    800001f4:	0e813e83          	ld	t4,232(sp)
    800001f8:	0f013f03          	ld	t5,240(sp)
    800001fc:	0f813f83          	ld	t6,248(sp)
    80000200:	11010113          	addi	sp,sp,272
    80000204:	30200073          	mret

Disassembly of section .text:

0000000080002000 <test_range>:
    80002000:	fa010113          	addi	sp,sp,-96
    80002004:	fffff7b7          	lui	a5,0xfffff
    80002008:	04113c23          	sd	ra,88(sp)
    8000200c:	04813823          	sd	s0,80(sp)
    80002010:	04913423          	sd	s1,72(sp)
    80002014:	05213023          	sd	s2,64(sp)
    80002018:	03313c23          	sd	s3,56(sp)
    8000201c:	03413823          	sd	s4,48(sp)
    80002020:	03513423          	sd	s5,40(sp)
    80002024:	03613023          	sd	s6,32(sp)
    80002028:	01713c23          	sd	s7,24(sp)
    8000202c:	01813823          	sd	s8,16(sp)
    80002030:	01913423          	sd	s9,8(sp)
    80002034:	00f507b3          	add	a5,a0,a5
    80002038:	00001737          	lui	a4,0x1
    8000203c:	3ae7f263          	bgeu	a5,a4,800023e0 <test_range+0x3e0>
    80002040:	00004a97          	auipc	s5,0x4
    80002044:	fc0a8a93          	addi	s5,s5,-64 # 80006000 <l1pt>
    80002048:	01550c33          	add	s8,a0,s5
    8000204c:	018582b3          	add	t0,a1,s8
    80002050:	00050f93          	mv	t6,a0
    80002054:	00058b13          	mv	s6,a1
    80002058:	002c5393          	srli	t2,s8,0x2
    8000205c:	0022d293          	srli	t0,t0,0x2
    80002060:	3a0027f3          	csrr	a5,pmpcfg0
    80002064:	ffff0737          	lui	a4,0xffff0
    80002068:	0ff70713          	addi	a4,a4,255 # ffffffffffff00ff <_tbss_end+0xffffffff7ffe80bb>
    8000206c:	00e7f7b3          	and	a5,a5,a4
    80002070:	3a079073          	csrw	pmpcfg0,a5
    80002074:	3b039073          	csrw	pmpaddr0,t2
    80002078:	3b129073          	csrw	pmpaddr1,t0
    8000207c:	00001737          	lui	a4,0x1
    80002080:	90070713          	addi	a4,a4,-1792 # 900 <buflen.1+0x8c0>
    80002084:	00e7e7b3          	or	a5,a5,a4
    80002088:	3a079073          	csrw	pmpcfg0,a5
    8000208c:	12000073          	sfence.vma
    80002090:	00b50a33          	add	s4,a0,a1
    80002094:	00050893          	mv	a7,a0
    80002098:	00001617          	auipc	a2,0x1
    8000209c:	37860613          	addi	a2,a2,888 # 80003410 <granule>
    800020a0:	0d457c63          	bgeu	a0,s4,80002178 <test_range+0x178>
    800020a4:	fffde937          	lui	s2,0xfffde
    800020a8:	000214b7          	lui	s1,0x21
    800020ac:	00400e93          	li	t4,4
    800020b0:	fffffbb7          	lui	s7,0xfffff
    800020b4:	00001437          	lui	s0,0x1
    800020b8:	00001e17          	auipc	t3,0x1
    800020bc:	35ce0e13          	addi	t3,t3,860 # 80003414 <trap_expected>
    800020c0:	7ff90913          	addi	s2,s2,2047 # fffffffffffde7ff <_tbss_end+0xffffffff7ffd67bb>
    800020c4:	80048493          	addi	s1,s1,-2048 # 20800 <buflen.1+0x207c0>
    800020c8:	00100993          	li	s3,1
    800020cc:	00400313          	li	t1,4
    800020d0:	00100693          	li	a3,1
    800020d4:	01788f33          	add	t5,a7,s7
    800020d8:	011a8833          	add	a6,s5,a7
    800020dc:	fff68593          	addi	a1,a3,-1
    800020e0:	0115f5b3          	and	a1,a1,a7
    800020e4:	06059e63          	bnez	a1,80002160 <test_range+0x160>
    800020e8:	00062503          	lw	a0,0(a2)
    800020ec:	00062c83          	lw	s9,0(a2)
    800020f0:	02750533          	mul	a0,a0,t2
    800020f4:	025c8cb3          	mul	s9,s9,t0
    800020f8:	2e8f7463          	bgeu	t5,s0,800023e0 <test_range+0x3e0>
    800020fc:	0e068e63          	beqz	a3,800021f8 <test_range+0x1f8>
    80002100:	00000793          	li	a5,0
    80002104:	00f80733          	add	a4,a6,a5
    80002108:	00a76863          	bltu	a4,a0,80002118 <test_range+0x118>
    8000210c:	01977663          	bgeu	a4,s9,80002118 <test_range+0x118>
    80002110:	00062703          	lw	a4,0(a2)
    80002114:	00e585b3          	add	a1,a1,a4
    80002118:	00062703          	lw	a4,0(a2)
    8000211c:	00e787b3          	add	a5,a5,a4
    80002120:	fed7e2e3          	bltu	a5,a3,80002104 <test_range+0x104>
    80002124:	00000793          	li	a5,0
    80002128:	00058463          	beqz	a1,80002130 <test_range+0x130>
    8000212c:	00d5b7b3          	sltu	a5,a1,a3
    80002130:	00fe2023          	sw	a5,0(t3)
    80002134:	300027f3          	csrr	a5,mstatus
    80002138:	0127f7b3          	and	a5,a5,s2
    8000213c:	0097e7b3          	or	a5,a5,s1
    80002140:	0bd68463          	beq	a3,t4,800021e8 <test_range+0x1e8>
    80002144:	08dee463          	bltu	t4,a3,800021cc <test_range+0x1cc>
    80002148:	07368a63          	beq	a3,s3,800021bc <test_range+0x1bc>
    8000214c:	300797f3          	csrrw	a5,mstatus,a5
    80002150:	00089003          	lh	zero,0(a7)
    80002154:	30079073          	csrw	mstatus,a5
    80002158:	000e2783          	lw	a5,0(t3)
    8000215c:	08079263          	bnez	a5,800021e0 <test_range+0x1e0>
    80002160:	fff3031b          	addiw	t1,t1,-1
    80002164:	00169693          	slli	a3,a3,0x1
    80002168:	f6031ae3          	bnez	t1,800020dc <test_range+0xdc>
    8000216c:	00062783          	lw	a5,0(a2)
    80002170:	00f888b3          	add	a7,a7,a5
    80002174:	f548ece3          	bltu	a7,s4,800020cc <test_range+0xcc>
    80002178:	fffb0793          	addi	a5,s6,-1
    8000217c:	016fe733          	or	a4,t6,s6
    80002180:	00e7f7b3          	and	a5,a5,a4
    80002184:	08078063          	beqz	a5,80002204 <test_range+0x204>
    80002188:	05813083          	ld	ra,88(sp)
    8000218c:	05013403          	ld	s0,80(sp)
    80002190:	04813483          	ld	s1,72(sp)
    80002194:	04013903          	ld	s2,64(sp)
    80002198:	03813983          	ld	s3,56(sp)
    8000219c:	03013a03          	ld	s4,48(sp)
    800021a0:	02813a83          	ld	s5,40(sp)
    800021a4:	02013b03          	ld	s6,32(sp)
    800021a8:	01813b83          	ld	s7,24(sp)
    800021ac:	01013c03          	ld	s8,16(sp)
    800021b0:	00813c83          	ld	s9,8(sp)
    800021b4:	06010113          	addi	sp,sp,96
    800021b8:	00008067          	ret
    800021bc:	300797f3          	csrrw	a5,mstatus,a5
    800021c0:	00088003          	lb	zero,0(a7)
    800021c4:	30079073          	csrw	mstatus,a5
    800021c8:	f91ff06f          	j	80002158 <test_range+0x158>
    800021cc:	300797f3          	csrrw	a5,mstatus,a5
    800021d0:	0008b003          	ld	zero,0(a7)
    800021d4:	30079073          	csrw	mstatus,a5
    800021d8:	000e2783          	lw	a5,0(t3)
    800021dc:	f80788e3          	beqz	a5,8000216c <test_range+0x16c>
    800021e0:	00200513          	li	a0,2
    800021e4:	7ec000ef          	jal	800029d0 <exit>
    800021e8:	300797f3          	csrrw	a5,mstatus,a5
    800021ec:	0008a003          	lw	zero,0(a7)
    800021f0:	30079073          	csrw	mstatus,a5
    800021f4:	f65ff06f          	j	80002158 <test_range+0x158>
    800021f8:	00001797          	auipc	a5,0x1
    800021fc:	2007ae23          	sw	zero,540(a5) # 80003414 <trap_expected>
    80002200:	300027f3          	csrr	a5,mstatus
    80002204:	00001797          	auipc	a5,0x1
    80002208:	20c7a783          	lw	a5,524(a5) # 80003410 <granule>
    8000220c:	00001617          	auipc	a2,0x1
    80002210:	20460613          	addi	a2,a2,516 # 80003410 <granule>
    80002214:	1367ee63          	bltu	a5,s6,80002350 <test_range+0x350>
    80002218:	000017b7          	lui	a5,0x1
    8000221c:	10078793          	addi	a5,a5,256 # 1100 <buflen.1+0x10c0>
    80002220:	01100293          	li	t0,17
    80002224:	001b5e13          	srli	t3,s6,0x1
    80002228:	fffe0e13          	addi	t3,t3,-1
    8000222c:	018e0e33          	add	t3,t3,s8
    80002230:	002e5e13          	srli	t3,t3,0x2
    80002234:	3a002773          	csrr	a4,pmpcfg0
    80002238:	ffff06b7          	lui	a3,0xffff0
    8000223c:	0ff68693          	addi	a3,a3,255 # ffffffffffff00ff <_tbss_end+0xffffffff7ffe80bb>
    80002240:	00d77733          	and	a4,a4,a3
    80002244:	3a071073          	csrw	pmpcfg0,a4
    80002248:	3b005073          	csrwi	pmpaddr0,0
    8000224c:	3b1e1073          	csrw	pmpaddr1,t3
    80002250:	00e7e7b3          	or	a5,a5,a4
    80002254:	3a079073          	csrw	pmpcfg0,a5
    80002258:	12000073          	sfence.vma
    8000225c:	f34ff6e3          	bgeu	t6,s4,80002188 <test_range+0x188>
    80002260:	fffde937          	lui	s2,0xfffde
    80002264:	000214b7          	lui	s1,0x21
    80002268:	00400e93          	li	t4,4
    8000226c:	0182f293          	andi	t0,t0,24
    80002270:	01800413          	li	s0,24
    80002274:	fffffb37          	lui	s6,0xfffff
    80002278:	000013b7          	lui	t2,0x1
    8000227c:	00001317          	auipc	t1,0x1
    80002280:	19830313          	addi	t1,t1,408 # 80003414 <trap_expected>
    80002284:	7ff90913          	addi	s2,s2,2047 # fffffffffffde7ff <_tbss_end+0xffffffff7ffd67bb>
    80002288:	80048493          	addi	s1,s1,-2048 # 20800 <buflen.1+0x207c0>
    8000228c:	00100993          	li	s3,1
    80002290:	00400893          	li	a7,4
    80002294:	00100593          	li	a1,1
    80002298:	016f8f33          	add	t5,t6,s6
    8000229c:	01fa8833          	add	a6,s5,t6
    800022a0:	fff58513          	addi	a0,a1,-1
    800022a4:	01f57533          	and	a0,a0,t6
    800022a8:	08051663          	bnez	a0,80002334 <test_range+0x334>
    800022ac:	000e0693          	mv	a3,t3
    800022b0:	00100713          	li	a4,1
    800022b4:	0a828663          	beq	t0,s0,80002360 <test_range+0x360>
    800022b8:	00062b83          	lw	s7,0(a2)
    800022bc:	00062783          	lw	a5,0(a2)
    800022c0:	00d70733          	add	a4,a4,a3
    800022c4:	02db8bb3          	mul	s7,s7,a3
    800022c8:	02f706b3          	mul	a3,a4,a5
    800022cc:	107f7a63          	bgeu	t5,t2,800023e0 <test_range+0x3e0>
    800022d0:	f20584e3          	beqz	a1,800021f8 <test_range+0x1f8>
    800022d4:	00000793          	li	a5,0
    800022d8:	00f80733          	add	a4,a6,a5
    800022dc:	01776863          	bltu	a4,s7,800022ec <test_range+0x2ec>
    800022e0:	00d77663          	bgeu	a4,a3,800022ec <test_range+0x2ec>
    800022e4:	00062703          	lw	a4,0(a2)
    800022e8:	00e50533          	add	a0,a0,a4
    800022ec:	00062703          	lw	a4,0(a2)
    800022f0:	00e787b3          	add	a5,a5,a4
    800022f4:	feb7e2e3          	bltu	a5,a1,800022d8 <test_range+0x2d8>
    800022f8:	00000793          	li	a5,0
    800022fc:	00050463          	beqz	a0,80002304 <test_range+0x304>
    80002300:	00b537b3          	sltu	a5,a0,a1
    80002304:	00f32023          	sw	a5,0(t1)
    80002308:	300027f3          	csrr	a5,mstatus
    8000230c:	0127f7b3          	and	a5,a5,s2
    80002310:	0097e7b3          	or	a5,a5,s1
    80002314:	09d58063          	beq	a1,t4,80002394 <test_range+0x394>
    80002318:	08beee63          	bltu	t4,a1,800023b4 <test_range+0x3b4>
    8000231c:	09358463          	beq	a1,s3,800023a4 <test_range+0x3a4>
    80002320:	300797f3          	csrrw	a5,mstatus,a5
    80002324:	000f9003          	lh	zero,0(t6)
    80002328:	30079073          	csrw	mstatus,a5
    8000232c:	00032783          	lw	a5,0(t1)
    80002330:	ea0798e3          	bnez	a5,800021e0 <test_range+0x1e0>
    80002334:	fff8889b          	addiw	a7,a7,-1
    80002338:	00159593          	slli	a1,a1,0x1
    8000233c:	f60892e3          	bnez	a7,800022a0 <test_range+0x2a0>
    80002340:	00062783          	lw	a5,0(a2)
    80002344:	00ff8fb3          	add	t6,t6,a5
    80002348:	f54fe4e3          	bltu	t6,s4,80002290 <test_range+0x290>
    8000234c:	e3dff06f          	j	80002188 <test_range+0x188>
    80002350:	000027b7          	lui	a5,0x2
    80002354:	90078793          	addi	a5,a5,-1792 # 1900 <buflen.1+0x18c0>
    80002358:	01900293          	li	t0,25
    8000235c:	ec9ff06f          	j	80002224 <test_range+0x224>
    80002360:	001e7793          	andi	a5,t3,1
    80002364:	06078a63          	beqz	a5,800023d8 <test_range+0x3d8>
    80002368:	04000b93          	li	s7,64
    8000236c:	00200713          	li	a4,2
    80002370:	fff7cc13          	not	s8,a5
    80002374:	fffb8b9b          	addiw	s7,s7,-1 # ffffffffffffefff <_tbss_end+0xffffffff7fff6fbb>
    80002378:	0186f6b3          	and	a3,a3,s8
    8000237c:	00171713          	slli	a4,a4,0x1
    80002380:	00179793          	slli	a5,a5,0x1
    80002384:	f20b8ae3          	beqz	s7,800022b8 <test_range+0x2b8>
    80002388:	00f6fc33          	and	s8,a3,a5
    8000238c:	fe0c12e3          	bnez	s8,80002370 <test_range+0x370>
    80002390:	f29ff06f          	j	800022b8 <test_range+0x2b8>
    80002394:	300797f3          	csrrw	a5,mstatus,a5
    80002398:	000fa003          	lw	zero,0(t6)
    8000239c:	30079073          	csrw	mstatus,a5
    800023a0:	f8dff06f          	j	8000232c <test_range+0x32c>
    800023a4:	300797f3          	csrrw	a5,mstatus,a5
    800023a8:	000f8003          	lb	zero,0(t6)
    800023ac:	30079073          	csrw	mstatus,a5
    800023b0:	f7dff06f          	j	8000232c <test_range+0x32c>
    800023b4:	300797f3          	csrrw	a5,mstatus,a5
    800023b8:	000fb003          	ld	zero,0(t6)
    800023bc:	30079073          	csrw	mstatus,a5
    800023c0:	00032783          	lw	a5,0(t1)
    800023c4:	e0079ee3          	bnez	a5,800021e0 <test_range+0x1e0>
    800023c8:	00062783          	lw	a5,0(a2)
    800023cc:	00ff8fb3          	add	t6,t6,a5
    800023d0:	ed4fe0e3          	bltu	t6,s4,80002290 <test_range+0x290>
    800023d4:	db5ff06f          	j	80002188 <test_range+0x188>
    800023d8:	00200713          	li	a4,2
    800023dc:	eddff06f          	j	800022b8 <test_range+0x2b8>
    800023e0:	00300513          	li	a0,3
    800023e4:	5ec000ef          	jal	800029d0 <exit>

00000000800023e8 <exhaustive_test.constprop.0>:
    800023e8:	fd010113          	addi	sp,sp,-48
    800023ec:	00913c23          	sd	s1,24(sp)
    800023f0:	01213823          	sd	s2,16(sp)
    800023f4:	01413023          	sd	s4,0(sp)
    800023f8:	02113423          	sd	ra,40(sp)
    800023fc:	02813023          	sd	s0,32(sp)
    80002400:	01313423          	sd	s3,8(sp)
    80002404:	00050493          	mv	s1,a0
    80002408:	02050a13          	addi	s4,a0,32
    8000240c:	00001917          	auipc	s2,0x1
    80002410:	00490913          	addi	s2,s2,4 # 80003410 <granule>
    80002414:	00092783          	lw	a5,0(s2)
    80002418:	409a09b3          	sub	s3,s4,s1
    8000241c:	0007841b          	sext.w	s0,a5
    80002420:	00f9ee63          	bltu	s3,a5,8000243c <exhaustive_test.constprop.0+0x54>
    80002424:	00040593          	mv	a1,s0
    80002428:	00048513          	mv	a0,s1
    8000242c:	bd5ff0ef          	jal	80002000 <test_range>
    80002430:	00092783          	lw	a5,0(s2)
    80002434:	00f40433          	add	s0,s0,a5
    80002438:	fe89f6e3          	bgeu	s3,s0,80002424 <exhaustive_test.constprop.0+0x3c>
    8000243c:	00092783          	lw	a5,0(s2)
    80002440:	00f484b3          	add	s1,s1,a5
    80002444:	fd44e8e3          	bltu	s1,s4,80002414 <exhaustive_test.constprop.0+0x2c>
    80002448:	02813083          	ld	ra,40(sp)
    8000244c:	02013403          	ld	s0,32(sp)
    80002450:	01813483          	ld	s1,24(sp)
    80002454:	01013903          	ld	s2,16(sp)
    80002458:	00813983          	ld	s3,8(sp)
    8000245c:	00013a03          	ld	s4,0(sp)
    80002460:	03010113          	addi	sp,sp,48
    80002464:	00008067          	ret

0000000080002468 <handle_trap>:
    80002468:	ff010113          	addi	sp,sp,-16
    8000246c:	00113423          	sd	ra,8(sp)
    80002470:	00200793          	li	a5,2
    80002474:	04f50263          	beq	a0,a5,800024b8 <handle_trap+0x50>
    80002478:	00001797          	auipc	a5,0x1
    8000247c:	f9c7a783          	lw	a5,-100(a5) # 80003414 <trap_expected>
    80002480:	04078063          	beqz	a5,800024c0 <handle_trap+0x58>
    80002484:	00500793          	li	a5,5
    80002488:	02f51c63          	bne	a0,a5,800024c0 <handle_trap+0x58>
    8000248c:	0005d783          	lhu	a5,0(a1)
    80002490:	00001717          	auipc	a4,0x1
    80002494:	f8072223          	sw	zero,-124(a4) # 80003414 <trap_expected>
    80002498:	00200513          	li	a0,2
    8000249c:	0037f793          	andi	a5,a5,3
    800024a0:	00078463          	beqz	a5,800024a8 <handle_trap+0x40>
    800024a4:	00400513          	li	a0,4
    800024a8:	00813083          	ld	ra,8(sp)
    800024ac:	00a58533          	add	a0,a1,a0
    800024b0:	01010113          	addi	sp,sp,16
    800024b4:	00008067          	ret
    800024b8:	00000513          	li	a0,0
    800024bc:	514000ef          	jal	800029d0 <exit>
    800024c0:	00100513          	li	a0,1
    800024c4:	50c000ef          	jal	800029d0 <exit>

00000000800024c8 <vprintfmt>:
    800024c8:	e9010113          	addi	sp,sp,-368
    800024cc:	16813023          	sd	s0,352(sp)
    800024d0:	14913c23          	sd	s1,344(sp)
    800024d4:	15213823          	sd	s2,336(sp)
    800024d8:	15413023          	sd	s4,320(sp)
    800024dc:	13513c23          	sd	s5,312(sp)
    800024e0:	13613823          	sd	s6,304(sp)
    800024e4:	13713423          	sd	s7,296(sp)
    800024e8:	16113423          	sd	ra,360(sp)
    800024ec:	15313423          	sd	s3,328(sp)
    800024f0:	13813023          	sd	s8,288(sp)
    800024f4:	11913c23          	sd	s9,280(sp)
    800024f8:	11b13423          	sd	s11,264(sp)
    800024fc:	00050913          	mv	s2,a0
    80002500:	00058493          	mv	s1,a1
    80002504:	00060413          	mv	s0,a2
    80002508:	00068b93          	mv	s7,a3
    8000250c:	02500a13          	li	s4,37
    80002510:	05500b13          	li	s6,85
    80002514:	00001a97          	auipc	s5,0x1
    80002518:	da4a8a93          	addi	s5,s5,-604 # 800032b8 <main+0x4a8>
    8000251c:	0140006f          	j	80002530 <vprintfmt+0x68>
    80002520:	04050c63          	beqz	a0,80002578 <vprintfmt+0xb0>
    80002524:	00048593          	mv	a1,s1
    80002528:	00140413          	addi	s0,s0,1 # 1001 <buflen.1+0xfc1>
    8000252c:	000900e7          	jalr	s2
    80002530:	00044503          	lbu	a0,0(s0)
    80002534:	ff4516e3          	bne	a0,s4,80002520 <vprintfmt+0x58>
    80002538:	00144683          	lbu	a3,1(s0)
    8000253c:	00140993          	addi	s3,s0,1
    80002540:	00098713          	mv	a4,s3
    80002544:	02000c93          	li	s9,32
    80002548:	fff00c13          	li	s8,-1
    8000254c:	fff00d93          	li	s11,-1
    80002550:	00000593          	li	a1,0
    80002554:	fdd6879b          	addiw	a5,a3,-35
    80002558:	0ff7f793          	zext.b	a5,a5
    8000255c:	00170413          	addi	s0,a4,1
    80002560:	06fb6663          	bltu	s6,a5,800025cc <vprintfmt+0x104>
    80002564:	00279793          	slli	a5,a5,0x2
    80002568:	015787b3          	add	a5,a5,s5
    8000256c:	0007a783          	lw	a5,0(a5)
    80002570:	015787b3          	add	a5,a5,s5
    80002574:	00078067          	jr	a5
    80002578:	16813083          	ld	ra,360(sp)
    8000257c:	16013403          	ld	s0,352(sp)
    80002580:	15813483          	ld	s1,344(sp)
    80002584:	15013903          	ld	s2,336(sp)
    80002588:	14813983          	ld	s3,328(sp)
    8000258c:	14013a03          	ld	s4,320(sp)
    80002590:	13813a83          	ld	s5,312(sp)
    80002594:	13013b03          	ld	s6,304(sp)
    80002598:	12813b83          	ld	s7,296(sp)
    8000259c:	12013c03          	ld	s8,288(sp)
    800025a0:	11813c83          	ld	s9,280(sp)
    800025a4:	10813d83          	ld	s11,264(sp)
    800025a8:	17010113          	addi	sp,sp,368
    800025ac:	00008067          	ret
    800025b0:	00068c93          	mv	s9,a3
    800025b4:	00174683          	lbu	a3,1(a4)
    800025b8:	00040713          	mv	a4,s0
    800025bc:	00170413          	addi	s0,a4,1
    800025c0:	fdd6879b          	addiw	a5,a3,-35
    800025c4:	0ff7f793          	zext.b	a5,a5
    800025c8:	f8fb7ee3          	bgeu	s6,a5,80002564 <vprintfmt+0x9c>
    800025cc:	00048593          	mv	a1,s1
    800025d0:	02500513          	li	a0,37
    800025d4:	000900e7          	jalr	s2
    800025d8:	00098413          	mv	s0,s3
    800025dc:	f55ff06f          	j	80002530 <vprintfmt+0x68>
    800025e0:	fd068c1b          	addiw	s8,a3,-48
    800025e4:	00174683          	lbu	a3,1(a4)
    800025e8:	00900793          	li	a5,9
    800025ec:	fd06871b          	addiw	a4,a3,-48
    800025f0:	0006861b          	sext.w	a2,a3
    800025f4:	2ee7e663          	bltu	a5,a4,800028e0 <vprintfmt+0x418>
    800025f8:	00040713          	mv	a4,s0
    800025fc:	00900813          	li	a6,9
    80002600:	00174683          	lbu	a3,1(a4)
    80002604:	002c179b          	slliw	a5,s8,0x2
    80002608:	018787bb          	addw	a5,a5,s8
    8000260c:	0017979b          	slliw	a5,a5,0x1
    80002610:	00c787bb          	addw	a5,a5,a2
    80002614:	fd06851b          	addiw	a0,a3,-48
    80002618:	00170713          	addi	a4,a4,1
    8000261c:	fd078c1b          	addiw	s8,a5,-48
    80002620:	0006861b          	sext.w	a2,a3
    80002624:	fca87ee3          	bgeu	a6,a0,80002600 <vprintfmt+0x138>
    80002628:	f20dd6e3          	bgez	s11,80002554 <vprintfmt+0x8c>
    8000262c:	000c0d93          	mv	s11,s8
    80002630:	fff00c13          	li	s8,-1
    80002634:	f21ff06f          	j	80002554 <vprintfmt+0x8c>
    80002638:	00174683          	lbu	a3,1(a4)
    8000263c:	00040713          	mv	a4,s0
    80002640:	f15ff06f          	j	80002554 <vprintfmt+0x8c>
    80002644:	00048593          	mv	a1,s1
    80002648:	02500513          	li	a0,37
    8000264c:	000900e7          	jalr	s2
    80002650:	ee1ff06f          	j	80002530 <vprintfmt+0x68>
    80002654:	000bac03          	lw	s8,0(s7)
    80002658:	00174683          	lbu	a3,1(a4)
    8000265c:	008b8b93          	addi	s7,s7,8
    80002660:	00040713          	mv	a4,s0
    80002664:	fc5ff06f          	j	80002628 <vprintfmt+0x160>
    80002668:	00048593          	mv	a1,s1
    8000266c:	03000513          	li	a0,48
    80002670:	11a13823          	sd	s10,272(sp)
    80002674:	000900e7          	jalr	s2
    80002678:	00048593          	mv	a1,s1
    8000267c:	07800513          	li	a0,120
    80002680:	000900e7          	jalr	s2
    80002684:	01000613          	li	a2,16
    80002688:	008b8713          	addi	a4,s7,8
    8000268c:	000bb783          	ld	a5,0(s7)
    80002690:	00070b93          	mv	s7,a4
    80002694:	02c7f5b3          	remu	a1,a5,a2
    80002698:	000c899b          	sext.w	s3,s9
    8000269c:	00410693          	addi	a3,sp,4
    800026a0:	00100713          	li	a4,1
    800026a4:	00b12023          	sw	a1,0(sp)
    800026a8:	1ec7ea63          	bltu	a5,a2,8000289c <vprintfmt+0x3d4>
    800026ac:	02c7d7b3          	divu	a5,a5,a2
    800026b0:	00468693          	addi	a3,a3,4
    800026b4:	00070c13          	mv	s8,a4
    800026b8:	0017071b          	addiw	a4,a4,1
    800026bc:	02c7f5b3          	remu	a1,a5,a2
    800026c0:	feb6ae23          	sw	a1,-4(a3)
    800026c4:	fec7f4e3          	bgeu	a5,a2,800026ac <vprintfmt+0x1e4>
    800026c8:	fffd8c9b          	addiw	s9,s11,-1
    800026cc:	fff70d1b          	addiw	s10,a4,-1
    800026d0:	01b75c63          	bge	a4,s11,800026e8 <vprintfmt+0x220>
    800026d4:	00048593          	mv	a1,s1
    800026d8:	00098513          	mv	a0,s3
    800026dc:	fffc8c9b          	addiw	s9,s9,-1
    800026e0:	000900e7          	jalr	s2
    800026e4:	ffac98e3          	bne	s9,s10,800026d4 <vprintfmt+0x20c>
    800026e8:	002c1c13          	slli	s8,s8,0x2
    800026ec:	018109b3          	add	s3,sp,s8
    800026f0:	ffc10c93          	addi	s9,sp,-4
    800026f4:	00900c13          	li	s8,9
    800026f8:	0009a783          	lw	a5,0(s3)
    800026fc:	03000513          	li	a0,48
    80002700:	00fc7463          	bgeu	s8,a5,80002708 <vprintfmt+0x240>
    80002704:	05700513          	li	a0,87
    80002708:	00048593          	mv	a1,s1
    8000270c:	00a7853b          	addw	a0,a5,a0
    80002710:	ffc98993          	addi	s3,s3,-4
    80002714:	000900e7          	jalr	s2
    80002718:	ff9990e3          	bne	s3,s9,800026f8 <vprintfmt+0x230>
    8000271c:	11013d03          	ld	s10,272(sp)
    80002720:	e11ff06f          	j	80002530 <vprintfmt+0x68>
    80002724:	11a13823          	sd	s10,272(sp)
    80002728:	00100793          	li	a5,1
    8000272c:	008b8c13          	addi	s8,s7,8
    80002730:	00b7c463          	blt	a5,a1,80002738 <vprintfmt+0x270>
    80002734:	16058863          	beqz	a1,800028a4 <vprintfmt+0x3dc>
    80002738:	000bb983          	ld	s3,0(s7)
    8000273c:	1809c463          	bltz	s3,800028c4 <vprintfmt+0x3fc>
    80002740:	00098793          	mv	a5,s3
    80002744:	000c0b93          	mv	s7,s8
    80002748:	00a00613          	li	a2,10
    8000274c:	f49ff06f          	j	80002694 <vprintfmt+0x1cc>
    80002750:	00174683          	lbu	a3,1(a4)
    80002754:	0015859b          	addiw	a1,a1,1
    80002758:	00040713          	mv	a4,s0
    8000275c:	df9ff06f          	j	80002554 <vprintfmt+0x8c>
    80002760:	11a13823          	sd	s10,272(sp)
    80002764:	01000613          	li	a2,16
    80002768:	00100793          	li	a5,1
    8000276c:	008b8713          	addi	a4,s7,8
    80002770:	f0b7cee3          	blt	a5,a1,8000268c <vprintfmt+0x1c4>
    80002774:	f0059ce3          	bnez	a1,8000268c <vprintfmt+0x1c4>
    80002778:	000be783          	lwu	a5,0(s7)
    8000277c:	00070b93          	mv	s7,a4
    80002780:	f15ff06f          	j	80002694 <vprintfmt+0x1cc>
    80002784:	11a13823          	sd	s10,272(sp)
    80002788:	000bbd03          	ld	s10,0(s7)
    8000278c:	008b8b93          	addi	s7,s7,8
    80002790:	060d0063          	beqz	s10,800027f0 <vprintfmt+0x328>
    80002794:	0db05463          	blez	s11,8000285c <vprintfmt+0x394>
    80002798:	02d00793          	li	a5,45
    8000279c:	06fc9c63          	bne	s9,a5,80002814 <vprintfmt+0x34c>
    800027a0:	000d4503          	lbu	a0,0(s10)
    800027a4:	02050863          	beqz	a0,800027d4 <vprintfmt+0x30c>
    800027a8:	fff00993          	li	s3,-1
    800027ac:	000c4663          	bltz	s8,800027b8 <vprintfmt+0x2f0>
    800027b0:	fffc0c1b          	addiw	s8,s8,-1
    800027b4:	013c0e63          	beq	s8,s3,800027d0 <vprintfmt+0x308>
    800027b8:	00048593          	mv	a1,s1
    800027bc:	000900e7          	jalr	s2
    800027c0:	001d4503          	lbu	a0,1(s10)
    800027c4:	fffd8d9b          	addiw	s11,s11,-1
    800027c8:	001d0d13          	addi	s10,s10,1
    800027cc:	fe0510e3          	bnez	a0,800027ac <vprintfmt+0x2e4>
    800027d0:	f5b056e3          	blez	s11,8000271c <vprintfmt+0x254>
    800027d4:	00048593          	mv	a1,s1
    800027d8:	02000513          	li	a0,32
    800027dc:	fffd8d9b          	addiw	s11,s11,-1
    800027e0:	000900e7          	jalr	s2
    800027e4:	fe0d98e3          	bnez	s11,800027d4 <vprintfmt+0x30c>
    800027e8:	11013d03          	ld	s10,272(sp)
    800027ec:	d45ff06f          	j	80002530 <vprintfmt+0x68>
    800027f0:	00001d17          	auipc	s10,0x1
    800027f4:	aa8d0d13          	addi	s10,s10,-1368 # 80003298 <main+0x488>
    800027f8:	02800513          	li	a0,40
    800027fc:	fbb056e3          	blez	s11,800027a8 <vprintfmt+0x2e0>
    80002800:	02d00793          	li	a5,45
    80002804:	00001d17          	auipc	s10,0x1
    80002808:	a94d0d13          	addi	s10,s10,-1388 # 80003298 <main+0x488>
    8000280c:	02800513          	li	a0,40
    80002810:	f8fc8ce3          	beq	s9,a5,800027a8 <vprintfmt+0x2e0>
    80002814:	000d861b          	sext.w	a2,s11
    80002818:	000d0793          	mv	a5,s10
    8000281c:	018d06b3          	add	a3,s10,s8
    80002820:	000c1863          	bnez	s8,80002830 <vprintfmt+0x368>
    80002824:	0200006f          	j	80002844 <vprintfmt+0x37c>
    80002828:	00178793          	addi	a5,a5,1
    8000282c:	00d78663          	beq	a5,a3,80002838 <vprintfmt+0x370>
    80002830:	0007c703          	lbu	a4,0(a5)
    80002834:	fe071ae3          	bnez	a4,80002828 <vprintfmt+0x360>
    80002838:	41a787b3          	sub	a5,a5,s10
    8000283c:	40f60dbb          	subw	s11,a2,a5
    80002840:	01b05e63          	blez	s11,8000285c <vprintfmt+0x394>
    80002844:	000c8c9b          	sext.w	s9,s9
    80002848:	00048593          	mv	a1,s1
    8000284c:	000c8513          	mv	a0,s9
    80002850:	fffd8d9b          	addiw	s11,s11,-1
    80002854:	000900e7          	jalr	s2
    80002858:	fe0d98e3          	bnez	s11,80002848 <vprintfmt+0x380>
    8000285c:	000d4503          	lbu	a0,0(s10)
    80002860:	ea050ee3          	beqz	a0,8000271c <vprintfmt+0x254>
    80002864:	fff00993          	li	s3,-1
    80002868:	f45ff06f          	j	800027ac <vprintfmt+0x2e4>
    8000286c:	fffdc793          	not	a5,s11
    80002870:	43f7d793          	srai	a5,a5,0x3f
    80002874:	00fdf7b3          	and	a5,s11,a5
    80002878:	00174683          	lbu	a3,1(a4)
    8000287c:	00078d9b          	sext.w	s11,a5
    80002880:	00040713          	mv	a4,s0
    80002884:	cd1ff06f          	j	80002554 <vprintfmt+0x8c>
    80002888:	000ba503          	lw	a0,0(s7)
    8000288c:	00048593          	mv	a1,s1
    80002890:	008b8b93          	addi	s7,s7,8
    80002894:	000900e7          	jalr	s2
    80002898:	c99ff06f          	j	80002530 <vprintfmt+0x68>
    8000289c:	00000c13          	li	s8,0
    800028a0:	e29ff06f          	j	800026c8 <vprintfmt+0x200>
    800028a4:	000ba983          	lw	s3,0(s7)
    800028a8:	e95ff06f          	j	8000273c <vprintfmt+0x274>
    800028ac:	11a13823          	sd	s10,272(sp)
    800028b0:	00a00613          	li	a2,10
    800028b4:	eb5ff06f          	j	80002768 <vprintfmt+0x2a0>
    800028b8:	11a13823          	sd	s10,272(sp)
    800028bc:	00800613          	li	a2,8
    800028c0:	ea9ff06f          	j	80002768 <vprintfmt+0x2a0>
    800028c4:	00048593          	mv	a1,s1
    800028c8:	02d00513          	li	a0,45
    800028cc:	000900e7          	jalr	s2
    800028d0:	413007b3          	neg	a5,s3
    800028d4:	000c0b93          	mv	s7,s8
    800028d8:	00a00613          	li	a2,10
    800028dc:	db9ff06f          	j	80002694 <vprintfmt+0x1cc>
    800028e0:	00040713          	mv	a4,s0
    800028e4:	d45ff06f          	j	80002628 <vprintfmt+0x160>

00000000800028e8 <sprintf_putch.0>:
    800028e8:	0005b783          	ld	a5,0(a1)
    800028ec:	00a78023          	sb	a0,0(a5)
    800028f0:	0005b783          	ld	a5,0(a1)
    800028f4:	00178793          	addi	a5,a5,1
    800028f8:	00f5b023          	sd	a5,0(a1)
    800028fc:	00008067          	ret

0000000080002900 <putchar>:
    80002900:	04022803          	lw	a6,64(tp) # 40 <buflen.1>
    80002904:	00020793          	mv	a5,tp
    80002908:	010787b3          	add	a5,a5,a6
    8000290c:	f9010113          	addi	sp,sp,-112
    80002910:	0018069b          	addiw	a3,a6,1
    80002914:	04d22023          	sw	a3,64(tp) # 40 <buflen.1>
    80002918:	00a78023          	sb	a0,0(a5)
    8000291c:	03f10713          	addi	a4,sp,63
    80002920:	00a00793          	li	a5,10
    80002924:	fc077713          	andi	a4,a4,-64
    80002928:	00f50c63          	beq	a0,a5,80002940 <putchar+0x40>
    8000292c:	04000793          	li	a5,64
    80002930:	00f68863          	beq	a3,a5,80002940 <putchar+0x40>
    80002934:	00000513          	li	a0,0
    80002938:	07010113          	addi	sp,sp,112
    8000293c:	00008067          	ret
    80002940:	04000793          	li	a5,64
    80002944:	00f73023          	sd	a5,0(a4)
    80002948:	00100793          	li	a5,1
    8000294c:	00f73423          	sd	a5,8(a4)
    80002950:	00020613          	mv	a2,tp
    80002954:	00c73823          	sd	a2,16(a4)
    80002958:	00d73c23          	sd	a3,24(a4)
    8000295c:	0ff0000f          	fence
    80002960:	ffffe697          	auipc	a3,0xffffe
    80002964:	6e068693          	addi	a3,a3,1760 # 80001040 <fromhost>
    80002968:	ffffe797          	auipc	a5,0xffffe
    8000296c:	68e7bc23          	sd	a4,1688(a5) # 80001000 <tohost>
    80002970:	0006b783          	ld	a5,0(a3)
    80002974:	fe078ee3          	beqz	a5,80002970 <putchar+0x70>
    80002978:	ffffe797          	auipc	a5,0xffffe
    8000297c:	6c07b423          	sd	zero,1736(a5) # 80001040 <fromhost>
    80002980:	0ff0000f          	fence
    80002984:	04022023          	sw	zero,64(tp) # 40 <buflen.1>
    80002988:	00073783          	ld	a5,0(a4)
    8000298c:	00000513          	li	a0,0
    80002990:	07010113          	addi	sp,sp,112
    80002994:	00008067          	ret

0000000080002998 <tohost_exit>:
    80002998:	00151793          	slli	a5,a0,0x1
    8000299c:	0017e793          	ori	a5,a5,1
    800029a0:	ffffe717          	auipc	a4,0xffffe
    800029a4:	66f73023          	sd	a5,1632(a4) # 80001000 <tohost>
    800029a8:	0ff0000f          	fence
    800029ac:	00100193          	li	gp,1
    800029b0:	05d00893          	li	a7,93
    800029b4:	00000513          	li	a0,0
    800029b8:	00000073          	ecall
    800029bc:	0000006f          	j	800029bc <tohost_exit+0x24>
    800029c0:	ff010113          	addi	sp,sp,-16
    800029c4:	53900513          	li	a0,1337
    800029c8:	00113423          	sd	ra,8(sp)
    800029cc:	fcdff0ef          	jal	80002998 <tohost_exit>

00000000800029d0 <exit>:
    800029d0:	ff010113          	addi	sp,sp,-16
    800029d4:	00113423          	sd	ra,8(sp)
    800029d8:	fc1ff0ef          	jal	80002998 <tohost_exit>

00000000800029dc <abort>:
    800029dc:	ff010113          	addi	sp,sp,-16
    800029e0:	08600513          	li	a0,134
    800029e4:	00113423          	sd	ra,8(sp)
    800029e8:	fb1ff0ef          	jal	80002998 <tohost_exit>

00000000800029ec <printstr>:
    800029ec:	00054783          	lbu	a5,0(a0)
    800029f0:	f9010113          	addi	sp,sp,-112
    800029f4:	03f10693          	addi	a3,sp,63
    800029f8:	fc06f693          	andi	a3,a3,-64
    800029fc:	06078263          	beqz	a5,80002a60 <printstr+0x74>
    80002a00:	00050793          	mv	a5,a0
    80002a04:	0017c703          	lbu	a4,1(a5)
    80002a08:	00178793          	addi	a5,a5,1
    80002a0c:	fe071ce3          	bnez	a4,80002a04 <printstr+0x18>
    80002a10:	40a787b3          	sub	a5,a5,a0
    80002a14:	04000713          	li	a4,64
    80002a18:	00e6b023          	sd	a4,0(a3)
    80002a1c:	00100713          	li	a4,1
    80002a20:	00e6b423          	sd	a4,8(a3)
    80002a24:	00a6b823          	sd	a0,16(a3)
    80002a28:	00f6bc23          	sd	a5,24(a3)
    80002a2c:	0ff0000f          	fence
    80002a30:	ffffe717          	auipc	a4,0xffffe
    80002a34:	61070713          	addi	a4,a4,1552 # 80001040 <fromhost>
    80002a38:	ffffe797          	auipc	a5,0xffffe
    80002a3c:	5cd7b423          	sd	a3,1480(a5) # 80001000 <tohost>
    80002a40:	00073783          	ld	a5,0(a4)
    80002a44:	fe078ee3          	beqz	a5,80002a40 <printstr+0x54>
    80002a48:	ffffe797          	auipc	a5,0xffffe
    80002a4c:	5e07bc23          	sd	zero,1528(a5) # 80001040 <fromhost>
    80002a50:	0ff0000f          	fence
    80002a54:	0006b783          	ld	a5,0(a3)
    80002a58:	07010113          	addi	sp,sp,112
    80002a5c:	00008067          	ret
    80002a60:	00000793          	li	a5,0
    80002a64:	fb1ff06f          	j	80002a14 <printstr+0x28>

0000000080002a68 <thread_entry>:
    80002a68:	00050463          	beqz	a0,80002a70 <thread_entry+0x8>
    80002a6c:	0000006f          	j	80002a6c <thread_entry+0x4>
    80002a70:	00008067          	ret

0000000080002a74 <printhex>:
    80002a74:	fd010113          	addi	sp,sp,-48
    80002a78:	00050793          	mv	a5,a0
    80002a7c:	02113423          	sd	ra,40(sp)
    80002a80:	00810513          	addi	a0,sp,8
    80002a84:	01710713          	addi	a4,sp,23
    80002a88:	00900813          	li	a6,9
    80002a8c:	0080006f          	j	80002a94 <printhex+0x20>
    80002a90:	00068713          	mv	a4,a3
    80002a94:	00f7f613          	andi	a2,a5,15
    80002a98:	00060693          	mv	a3,a2
    80002a9c:	03000593          	li	a1,48
    80002aa0:	00c87463          	bgeu	a6,a2,80002aa8 <printhex+0x34>
    80002aa4:	05700593          	li	a1,87
    80002aa8:	00b686bb          	addw	a3,a3,a1
    80002aac:	00d70023          	sb	a3,0(a4)
    80002ab0:	0047d793          	srli	a5,a5,0x4
    80002ab4:	fff70693          	addi	a3,a4,-1
    80002ab8:	fce51ce3          	bne	a0,a4,80002a90 <printhex+0x1c>
    80002abc:	00010c23          	sb	zero,24(sp)
    80002ac0:	f2dff0ef          	jal	800029ec <printstr>
    80002ac4:	02813083          	ld	ra,40(sp)
    80002ac8:	03010113          	addi	sp,sp,48
    80002acc:	00008067          	ret

0000000080002ad0 <printf>:
    80002ad0:	fa010113          	addi	sp,sp,-96
    80002ad4:	02810313          	addi	t1,sp,40
    80002ad8:	02b13423          	sd	a1,40(sp)
    80002adc:	02c13823          	sd	a2,48(sp)
    80002ae0:	02d13c23          	sd	a3,56(sp)
    80002ae4:	00050613          	mv	a2,a0
    80002ae8:	00030693          	mv	a3,t1
    80002aec:	00000517          	auipc	a0,0x0
    80002af0:	e1450513          	addi	a0,a0,-492 # 80002900 <putchar>
    80002af4:	00000593          	li	a1,0
    80002af8:	00113c23          	sd	ra,24(sp)
    80002afc:	04e13023          	sd	a4,64(sp)
    80002b00:	04f13423          	sd	a5,72(sp)
    80002b04:	05013823          	sd	a6,80(sp)
    80002b08:	05113c23          	sd	a7,88(sp)
    80002b0c:	00613423          	sd	t1,8(sp)
    80002b10:	9b9ff0ef          	jal	800024c8 <vprintfmt>
    80002b14:	01813083          	ld	ra,24(sp)
    80002b18:	00000513          	li	a0,0
    80002b1c:	06010113          	addi	sp,sp,96
    80002b20:	00008067          	ret

0000000080002b24 <sprintf>:
    80002b24:	fa010113          	addi	sp,sp,-96
    80002b28:	03010e13          	addi	t3,sp,48
    80002b2c:	02813023          	sd	s0,32(sp)
    80002b30:	00a13423          	sd	a0,8(sp)
    80002b34:	00050413          	mv	s0,a0
    80002b38:	02c13823          	sd	a2,48(sp)
    80002b3c:	02d13c23          	sd	a3,56(sp)
    80002b40:	00058613          	mv	a2,a1
    80002b44:	00000517          	auipc	a0,0x0
    80002b48:	da450513          	addi	a0,a0,-604 # 800028e8 <sprintf_putch.0>
    80002b4c:	00810593          	addi	a1,sp,8
    80002b50:	000e0693          	mv	a3,t3
    80002b54:	02113423          	sd	ra,40(sp)
    80002b58:	04f13423          	sd	a5,72(sp)
    80002b5c:	04e13023          	sd	a4,64(sp)
    80002b60:	05013823          	sd	a6,80(sp)
    80002b64:	05113c23          	sd	a7,88(sp)
    80002b68:	01c13c23          	sd	t3,24(sp)
    80002b6c:	95dff0ef          	jal	800024c8 <vprintfmt>
    80002b70:	00813783          	ld	a5,8(sp)
    80002b74:	00078023          	sb	zero,0(a5)
    80002b78:	00813503          	ld	a0,8(sp)
    80002b7c:	02813083          	ld	ra,40(sp)
    80002b80:	4085053b          	subw	a0,a0,s0
    80002b84:	02013403          	ld	s0,32(sp)
    80002b88:	06010113          	addi	sp,sp,96
    80002b8c:	00008067          	ret

0000000080002b90 <memcpy>:
    80002b90:	00c5e7b3          	or	a5,a1,a2
    80002b94:	00f567b3          	or	a5,a0,a5
    80002b98:	0077f793          	andi	a5,a5,7
    80002b9c:	00c506b3          	add	a3,a0,a2
    80002ba0:	02078463          	beqz	a5,80002bc8 <memcpy+0x38>
    80002ba4:	00c58633          	add	a2,a1,a2
    80002ba8:	00050793          	mv	a5,a0
    80002bac:	02d57e63          	bgeu	a0,a3,80002be8 <memcpy+0x58>
    80002bb0:	0005c703          	lbu	a4,0(a1)
    80002bb4:	00158593          	addi	a1,a1,1
    80002bb8:	00178793          	addi	a5,a5,1
    80002bbc:	fee78fa3          	sb	a4,-1(a5)
    80002bc0:	feb618e3          	bne	a2,a1,80002bb0 <memcpy+0x20>
    80002bc4:	00008067          	ret
    80002bc8:	fed57ee3          	bgeu	a0,a3,80002bc4 <memcpy+0x34>
    80002bcc:	00050793          	mv	a5,a0
    80002bd0:	0005b703          	ld	a4,0(a1)
    80002bd4:	00878793          	addi	a5,a5,8
    80002bd8:	00858593          	addi	a1,a1,8
    80002bdc:	fee7bc23          	sd	a4,-8(a5)
    80002be0:	fed7e8e3          	bltu	a5,a3,80002bd0 <memcpy+0x40>
    80002be4:	00008067          	ret
    80002be8:	00008067          	ret

0000000080002bec <memset>:
    80002bec:	00c567b3          	or	a5,a0,a2
    80002bf0:	0077f793          	andi	a5,a5,7
    80002bf4:	00c50633          	add	a2,a0,a2
    80002bf8:	02078063          	beqz	a5,80002c18 <memset+0x2c>
    80002bfc:	0ff5f713          	zext.b	a4,a1
    80002c00:	00050793          	mv	a5,a0
    80002c04:	04c57663          	bgeu	a0,a2,80002c50 <memset+0x64>
    80002c08:	00178793          	addi	a5,a5,1
    80002c0c:	fee78fa3          	sb	a4,-1(a5)
    80002c10:	fec79ce3          	bne	a5,a2,80002c08 <memset+0x1c>
    80002c14:	00008067          	ret
    80002c18:	010107b7          	lui	a5,0x1010
    80002c1c:	10178793          	addi	a5,a5,257 # 1010101 <buflen.1+0x10100c1>
    80002c20:	01079793          	slli	a5,a5,0x10
    80002c24:	10178793          	addi	a5,a5,257
    80002c28:	01079793          	slli	a5,a5,0x10
    80002c2c:	0ff5f713          	zext.b	a4,a1
    80002c30:	10178793          	addi	a5,a5,257
    80002c34:	02f70733          	mul	a4,a4,a5
    80002c38:	fcc57ee3          	bgeu	a0,a2,80002c14 <memset+0x28>
    80002c3c:	00050793          	mv	a5,a0
    80002c40:	00878793          	addi	a5,a5,8
    80002c44:	fee7bc23          	sd	a4,-8(a5)
    80002c48:	fec7ece3          	bltu	a5,a2,80002c40 <memset+0x54>
    80002c4c:	00008067          	ret
    80002c50:	00008067          	ret

0000000080002c54 <_init>:
    80002c54:	fd010113          	addi	sp,sp,-48
    80002c58:	00005797          	auipc	a5,0x5
    80002c5c:	3a878793          	addi	a5,a5,936 # 80008000 <_end>
    80002c60:	01313423          	sd	s3,8(sp)
    80002c64:	00005997          	auipc	s3,0x5
    80002c68:	39c98993          	addi	s3,s3,924 # 80008000 <_end>
    80002c6c:	01213823          	sd	s2,16(sp)
    80002c70:	40f98933          	sub	s2,s3,a5
    80002c74:	02813023          	sd	s0,32(sp)
    80002c78:	00913c23          	sd	s1,24(sp)
    80002c7c:	00050413          	mv	s0,a0
    80002c80:	00058493          	mv	s1,a1
    80002c84:	00020513          	mv	a0,tp
    80002c88:	00078593          	mv	a1,a5
    80002c8c:	00090613          	mv	a2,s2
    80002c90:	02113423          	sd	ra,40(sp)
    80002c94:	01413023          	sd	s4,0(sp)
    80002c98:	00020a13          	mv	s4,tp
    80002c9c:	ef5ff0ef          	jal	80002b90 <memcpy>
    80002ca0:	00005617          	auipc	a2,0x5
    80002ca4:	3a460613          	addi	a2,a2,932 # 80008044 <_tbss_end>
    80002ca8:	41360633          	sub	a2,a2,s3
    80002cac:	00000593          	li	a1,0
    80002cb0:	012a0533          	add	a0,s4,s2
    80002cb4:	f39ff0ef          	jal	80002bec <memset>
    80002cb8:	00048593          	mv	a1,s1
    80002cbc:	00040513          	mv	a0,s0
    80002cc0:	da9ff0ef          	jal	80002a68 <thread_entry>
    80002cc4:	00000593          	li	a1,0
    80002cc8:	00000513          	li	a0,0
    80002ccc:	144000ef          	jal	80002e10 <main>
    80002cd0:	cc9ff0ef          	jal	80002998 <tohost_exit>

0000000080002cd4 <strlen>:
    80002cd4:	00054783          	lbu	a5,0(a0)
    80002cd8:	00078e63          	beqz	a5,80002cf4 <strlen+0x20>
    80002cdc:	00050793          	mv	a5,a0
    80002ce0:	0017c703          	lbu	a4,1(a5)
    80002ce4:	00178793          	addi	a5,a5,1
    80002ce8:	fe071ce3          	bnez	a4,80002ce0 <strlen+0xc>
    80002cec:	40a78533          	sub	a0,a5,a0
    80002cf0:	00008067          	ret
    80002cf4:	00000513          	li	a0,0
    80002cf8:	00008067          	ret

0000000080002cfc <strnlen>:
    80002cfc:	00b506b3          	add	a3,a0,a1
    80002d00:	00050793          	mv	a5,a0
    80002d04:	00059863          	bnez	a1,80002d14 <strnlen+0x18>
    80002d08:	0240006f          	j	80002d2c <strnlen+0x30>
    80002d0c:	00178793          	addi	a5,a5,1
    80002d10:	00f68a63          	beq	a3,a5,80002d24 <strnlen+0x28>
    80002d14:	0007c703          	lbu	a4,0(a5)
    80002d18:	fe071ae3          	bnez	a4,80002d0c <strnlen+0x10>
    80002d1c:	40a78533          	sub	a0,a5,a0
    80002d20:	00008067          	ret
    80002d24:	40a68533          	sub	a0,a3,a0
    80002d28:	00008067          	ret
    80002d2c:	00000513          	li	a0,0
    80002d30:	00008067          	ret

0000000080002d34 <strcmp>:
    80002d34:	00054783          	lbu	a5,0(a0)
    80002d38:	00158593          	addi	a1,a1,1
    80002d3c:	00150513          	addi	a0,a0,1
    80002d40:	fff5c703          	lbu	a4,-1(a1)
    80002d44:	00078a63          	beqz	a5,80002d58 <strcmp+0x24>
    80002d48:	fee786e3          	beq	a5,a4,80002d34 <strcmp>
    80002d4c:	0007851b          	sext.w	a0,a5
    80002d50:	40e5053b          	subw	a0,a0,a4
    80002d54:	00008067          	ret
    80002d58:	00000513          	li	a0,0
    80002d5c:	ff5ff06f          	j	80002d50 <strcmp+0x1c>

0000000080002d60 <strcpy>:
    80002d60:	00050793          	mv	a5,a0
    80002d64:	0005c703          	lbu	a4,0(a1)
    80002d68:	00178793          	addi	a5,a5,1
    80002d6c:	00158593          	addi	a1,a1,1
    80002d70:	fee78fa3          	sb	a4,-1(a5)
    80002d74:	fe0718e3          	bnez	a4,80002d64 <strcpy+0x4>
    80002d78:	00008067          	ret

0000000080002d7c <atol>:
    80002d7c:	00054703          	lbu	a4,0(a0)
    80002d80:	02000693          	li	a3,32
    80002d84:	00050793          	mv	a5,a0
    80002d88:	00d71863          	bne	a4,a3,80002d98 <atol+0x1c>
    80002d8c:	0017c703          	lbu	a4,1(a5)
    80002d90:	00178793          	addi	a5,a5,1
    80002d94:	fed70ce3          	beq	a4,a3,80002d8c <atol+0x10>
    80002d98:	02d00693          	li	a3,45
    80002d9c:	04d70e63          	beq	a4,a3,80002df8 <atol+0x7c>
    80002da0:	02b00693          	li	a3,43
    80002da4:	04d70063          	beq	a4,a3,80002de4 <atol+0x68>
    80002da8:	0007c683          	lbu	a3,0(a5)
    80002dac:	00000593          	li	a1,0
    80002db0:	04068c63          	beqz	a3,80002e08 <atol+0x8c>
    80002db4:	00000513          	li	a0,0
    80002db8:	00178793          	addi	a5,a5,1
    80002dbc:	00251713          	slli	a4,a0,0x2
    80002dc0:	fd06861b          	addiw	a2,a3,-48
    80002dc4:	0007c683          	lbu	a3,0(a5)
    80002dc8:	00a70733          	add	a4,a4,a0
    80002dcc:	00171713          	slli	a4,a4,0x1
    80002dd0:	00e60533          	add	a0,a2,a4
    80002dd4:	fe0692e3          	bnez	a3,80002db8 <atol+0x3c>
    80002dd8:	02058a63          	beqz	a1,80002e0c <atol+0x90>
    80002ddc:	40a00533          	neg	a0,a0
    80002de0:	00008067          	ret
    80002de4:	0017c683          	lbu	a3,1(a5)
    80002de8:	00178793          	addi	a5,a5,1
    80002dec:	00068e63          	beqz	a3,80002e08 <atol+0x8c>
    80002df0:	00000593          	li	a1,0
    80002df4:	fc1ff06f          	j	80002db4 <atol+0x38>
    80002df8:	0017c683          	lbu	a3,1(a5)
    80002dfc:	00100593          	li	a1,1
    80002e00:	00178793          	addi	a5,a5,1
    80002e04:	fa0698e3          	bnez	a3,80002db4 <atol+0x38>
    80002e08:	00000513          	li	a0,0
    80002e0c:	00008067          	ret

Disassembly of section .text.startup:

0000000080002e10 <main>:
    80002e10:	ff010113          	addi	sp,sp,-16
    80002e14:	00113423          	sd	ra,8(sp)
    80002e18:	3a005073          	csrwi	pmpcfg0,0
    80002e1c:	fff00793          	li	a5,-1
    80002e20:	3b079073          	csrw	pmpaddr0,a5
    80002e24:	3b002673          	csrr	a2,pmpaddr0
    80002e28:	00167793          	andi	a5,a2,1
    80002e2c:	0e079e63          	bnez	a5,80002f28 <main+0x118>
    80002e30:	00200793          	li	a5,2
    80002e34:	00100713          	li	a4,1
    80002e38:	04200593          	li	a1,66
    80002e3c:	00171713          	slli	a4,a4,0x1
    80002e40:	0017879b          	addiw	a5,a5,1
    80002e44:	00e676b3          	and	a3,a2,a4
    80002e48:	00b78463          	beq	a5,a1,80002e50 <main+0x40>
    80002e4c:	fe0688e3          	beqz	a3,80002e3c <main+0x2c>
    80002e50:	00004717          	auipc	a4,0x4
    80002e54:	1b070713          	addi	a4,a4,432 # 80007000 <scratch>
    80002e58:	00c75713          	srli	a4,a4,0xc
    80002e5c:	00002517          	auipc	a0,0x2
    80002e60:	1a450513          	addi	a0,a0,420 # 80005000 <l2pt>
    80002e64:	00001817          	auipc	a6,0x1
    80002e68:	19c80813          	addi	a6,a6,412 # 80004000 <l3pt>
    80002e6c:	00a71713          	slli	a4,a4,0xa
    80002e70:	00100593          	li	a1,1
    80002e74:	00f595b3          	sll	a1,a1,a5
    80002e78:	00c55613          	srli	a2,a0,0xc
    80002e7c:	0c776793          	ori	a5,a4,199
    80002e80:	00c85693          	srli	a3,a6,0xc
    80002e84:	00003897          	auipc	a7,0x3
    80002e88:	17c88893          	addi	a7,a7,380 # 80006000 <l1pt>
    80002e8c:	00a69693          	slli	a3,a3,0xa
    80002e90:	00f83423          	sd	a5,8(a6)
    80002e94:	00a61613          	slli	a2,a2,0xa
    80002e98:	fff00793          	li	a5,-1
    80002e9c:	0016e713          	ori	a4,a3,1
    80002ea0:	00166613          	ori	a2,a2,1
    80002ea4:	00c8d693          	srli	a3,a7,0xc
    80002ea8:	03f79793          	slli	a5,a5,0x3f
    80002eac:	00000317          	auipc	t1,0x0
    80002eb0:	56b32223          	sw	a1,1380(t1) # 80003410 <granule>
    80002eb4:	00c8b023          	sd	a2,0(a7)
    80002eb8:	00e53023          	sd	a4,0(a0)
    80002ebc:	00f6e7b3          	or	a5,a3,a5
    80002ec0:	18079073          	csrw	satp,a5
    80002ec4:	fff00793          	li	a5,-1
    80002ec8:	3b279073          	csrw	pmpaddr2,a5
    80002ecc:	001907b7          	lui	a5,0x190
    80002ed0:	3a079073          	csrw	pmpcfg0,a5
    80002ed4:	00001537          	lui	a0,0x1
    80002ed8:	d10ff0ef          	jal	800023e8 <exhaustive_test.constprop.0>
    80002edc:	00002537          	lui	a0,0x2
    80002ee0:	fe050513          	addi	a0,a0,-32 # 1fe0 <buflen.1+0x1fa0>
    80002ee4:	d04ff0ef          	jal	800023e8 <exhaustive_test.constprop.0>
    80002ee8:	000015b7          	lui	a1,0x1
    80002eec:	00001537          	lui	a0,0x1
    80002ef0:	910ff0ef          	jal	80002000 <test_range>
    80002ef4:	000015b7          	lui	a1,0x1
    80002ef8:	80058593          	addi	a1,a1,-2048 # 800 <buflen.1+0x7c0>
    80002efc:	00001537          	lui	a0,0x1
    80002f00:	900ff0ef          	jal	80002000 <test_range>
    80002f04:	000015b7          	lui	a1,0x1
    80002f08:	00002537          	lui	a0,0x2
    80002f0c:	80050513          	addi	a0,a0,-2048 # 1800 <buflen.1+0x17c0>
    80002f10:	80058593          	addi	a1,a1,-2048 # 800 <buflen.1+0x7c0>
    80002f14:	8ecff0ef          	jal	80002000 <test_range>
    80002f18:	00813083          	ld	ra,8(sp)
    80002f1c:	00000513          	li	a0,0
    80002f20:	01010113          	addi	sp,sp,16
    80002f24:	00008067          	ret
    80002f28:	00200793          	li	a5,2
    80002f2c:	f25ff06f          	j	80002e50 <main+0x40>
    80002f30:	ff010113          	addi	sp,sp,-16
    80002f34:	00000517          	auipc	a0,0x0
    80002f38:	36c50513          	addi	a0,a0,876 # 800032a0 <main+0x490>
    80002f3c:	00113423          	sd	ra,8(sp)
    80002f40:	aadff0ef          	jal	800029ec <printstr>
    80002f44:	00813083          	ld	ra,8(sp)
    80002f48:	fff00513          	li	a0,-1
    80002f4c:	01010113          	addi	sp,sp,16
    80002f50:	00008067          	ret
