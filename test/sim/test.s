
./riscv-tests-build/isa/rv64mi-p-illegal:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000080000000 <_start>:
    80000000:	04c0006f          	jal	x0,8000004c <reset_vector>

0000000080000004 <trap_vector>:
    80000004:	34202f73          	csrrs	x30,mcause,x0
    80000008:	00800f93          	addi	x31,x0,8
    8000000c:	03ff0a63          	beq	x30,x31,80000040 <write_tohost>
    80000010:	00900f93          	addi	x31,x0,9
    80000014:	03ff0663          	beq	x30,x31,80000040 <write_tohost>
    80000018:	00b00f93          	addi	x31,x0,11
    8000001c:	03ff0263          	beq	x30,x31,80000040 <write_tohost>
    80000020:	00000f17          	auipc	x30,0x0
    80000024:	2e0f0f13          	addi	x30,x30,736 # 80000300 <mtvec_handler>
    80000028:	000f0463          	beq	x30,x0,80000030 <trap_vector+0x2c>
    8000002c:	000f0067          	jalr	x0,0(x30)
    80000030:	34202f73          	csrrs	x30,mcause,x0
    80000034:	000f5463          	bge	x30,x0,8000003c <handle_exception>
    80000038:	0040006f          	jal	x0,8000003c <handle_exception>

000000008000003c <handle_exception>:
    8000003c:	5391e193          	ori	x3,x3,1337

0000000080000040 <write_tohost>:
    80000040:	00001f17          	auipc	x30,0x1
    80000044:	fc3f2023          	sw	x3,-64(x30) # 80001000 <tohost>
    80000048:	ff9ff06f          	jal	x0,80000040 <write_tohost>

000000008000004c <reset_vector>:
    8000004c:	00000093          	addi	x1,x0,0
    80000050:	00000113          	addi	x2,x0,0
    80000054:	00000193          	addi	x3,x0,0
    80000058:	00000213          	addi	x4,x0,0
    8000005c:	00000293          	addi	x5,x0,0
    80000060:	00000313          	addi	x6,x0,0
    80000064:	00000393          	addi	x7,x0,0
    80000068:	00000413          	addi	x8,x0,0
    8000006c:	00000493          	addi	x9,x0,0
    80000070:	00000513          	addi	x10,x0,0
    80000074:	00000593          	addi	x11,x0,0
    80000078:	00000613          	addi	x12,x0,0
    8000007c:	00000693          	addi	x13,x0,0
    80000080:	00000713          	addi	x14,x0,0
    80000084:	00000793          	addi	x15,x0,0
    80000088:	00000813          	addi	x16,x0,0
    8000008c:	00000893          	addi	x17,x0,0
    80000090:	00000913          	addi	x18,x0,0
    80000094:	00000993          	addi	x19,x0,0
    80000098:	00000a13          	addi	x20,x0,0
    8000009c:	00000a93          	addi	x21,x0,0
    800000a0:	00000b13          	addi	x22,x0,0
    800000a4:	00000b93          	addi	x23,x0,0
    800000a8:	00000c13          	addi	x24,x0,0
    800000ac:	00000c93          	addi	x25,x0,0
    800000b0:	00000d13          	addi	x26,x0,0
    800000b4:	00000d93          	addi	x27,x0,0
    800000b8:	00000e13          	addi	x28,x0,0
    800000bc:	00000e93          	addi	x29,x0,0
    800000c0:	00000f13          	addi	x30,x0,0
    800000c4:	00000f93          	addi	x31,x0,0
    800000c8:	f1402573          	csrrs	x10,mhartid,x0
    800000cc:	00051063          	bne	x10,x0,800000cc <reset_vector+0x80>
    800000d0:	00000297          	auipc	x5,0x0
    800000d4:	01028293          	addi	x5,x5,16 # 800000e0 <reset_vector+0x94>
    800000d8:	30529073          	csrrw	x0,mtvec,x5
    800000dc:	18005073          	csrrwi	x0,satp,0
    800000e0:	00000297          	auipc	x5,0x0
    800000e4:	02428293          	addi	x5,x5,36 # 80000104 <reset_vector+0xb8>
    800000e8:	30529073          	csrrw	x0,mtvec,x5
    800000ec:	0010029b          	addiw	x5,x0,1
    800000f0:	03529293          	slli	x5,x5,0x35
    800000f4:	fff28293          	addi	x5,x5,-1
    800000f8:	3b029073          	csrrw	x0,pmpaddr0,x5
    800000fc:	01f00293          	addi	x5,x0,31
    80000100:	3a029073          	csrrw	x0,pmpcfg0,x5
    80000104:	30405073          	csrrwi	x0,mie,0
    80000108:	00000297          	auipc	x5,0x0
    8000010c:	01428293          	addi	x5,x5,20 # 8000011c <reset_vector+0xd0>
    80000110:	30529073          	csrrw	x0,mtvec,x5
    80000114:	30205073          	csrrwi	x0,medeleg,0
    80000118:	30305073          	csrrwi	x0,mideleg,0
    8000011c:	00000193          	addi	x3,x0,0
    80000120:	00000297          	auipc	x5,0x0
    80000124:	ee428293          	addi	x5,x5,-284 # 80000004 <trap_vector>
    80000128:	30529073          	csrrw	x0,mtvec,x5
    8000012c:	00100513          	addi	x10,x0,1
    80000130:	01f51513          	slli	x10,x10,0x1f
    80000134:	00055c63          	bge	x10,x0,8000014c <reset_vector+0x100>
    80000138:	0ff0000f          	fence	iorw,iorw
    8000013c:	00100193          	addi	x3,x0,1
    80000140:	05d00893          	addi	x17,x0,93
    80000144:	00000513          	addi	x10,x0,0
    80000148:	00000073          	ecall
    8000014c:	00000293          	addi	x5,x0,0
    80000150:	00028a63          	beq	x5,x0,80000164 <reset_vector+0x118>
    80000154:	10529073          	csrrw	x0,stvec,x5
    80000158:	0000b2b7          	lui	x5,0xb
    8000015c:	1092829b          	addiw	x5,x5,265 # b109 <_start-0x7fff4ef7>
    80000160:	30229073          	csrrw	x0,medeleg,x5
    80000164:	30005073          	csrrwi	x0,mstatus,0
    80000168:	00002537          	lui	x10,0x2
    8000016c:	8005051b          	addiw	x10,x10,-2048 # 1800 <_start-0x7fffe800>
    80000170:	30052073          	csrrs	x0,mstatus,x10
    80000174:	00000297          	auipc	x5,0x0
    80000178:	01428293          	addi	x5,x5,20 # 80000188 <reset_vector+0x13c>
    8000017c:	34129073          	csrrw	x0,mepc,x5
    80000180:	f1402573          	csrrs	x10,mhartid,x0
    80000184:	30200073          	mret
    80000188:	00200193          	addi	x3,x0,2

000000008000018c <bad2>:
    8000018c:	00000000          	.word	0x00000000
    80000190:	1300006f          	jal	x0,800002c0 <fail>
    80000194:	000022b7          	lui	x5,0x2
    80000198:	8002829b          	addiw	x5,x5,-2048 # 1800 <_start-0x7fffe800>
    8000019c:	3002b073          	csrrc	x0,mstatus,x5
    800001a0:	00001337          	lui	x6,0x1
    800001a4:	8003031b          	addiw	x6,x6,-2048 # 800 <_start-0x7ffff800>
    800001a8:	30032073          	csrrs	x0,mstatus,x6
    800001ac:	300023f3          	csrrs	x7,mstatus,x0
    800001b0:	0053f3b3          	and	x7,x7,x5
    800001b4:	12731463          	bne	x6,x7,800002dc <pass>

00000000800001b8 <test_vectored_interrupts>:
    800001b8:	34415073          	csrrwi	x0,mip,2
    800001bc:	30415073          	csrrwi	x0,mie,2
    800001c0:	00000297          	auipc	x5,0x0
    800001c4:	14128293          	addi	x5,x5,321 # 80000301 <mtvec_handler+0x1>
    800001c8:	30529473          	csrrw	x8,mtvec,x5
    800001cc:	305022f3          	csrrs	x5,mtvec,x0
    800001d0:	0012f293          	andi	x5,x5,1
    800001d4:	00028663          	beq	x5,x0,800001e0 <msip>
    800001d8:	30046073          	csrrsi	x0,mstatus,8
    800001dc:	0000006f          	jal	x0,800001dc <test_vectored_interrupts+0x24>

00000000800001e0 <msip>:
    800001e0:	30541073          	csrrw	x0,mtvec,x8
    800001e4:	30315073          	csrrwi	x0,mideleg,2
    800001e8:	00000297          	auipc	x5,0x0
    800001ec:	02828293          	addi	x5,x5,40 # 80000210 <msip+0x30>
    800001f0:	34129073          	csrrw	x0,mepc,x5
    800001f4:	000022b7          	lui	x5,0x2
    800001f8:	8002829b          	addiw	x5,x5,-2048 # 1800 <_start-0x7fffe800>
    800001fc:	3002b073          	csrrc	x0,mstatus,x5
    80000200:	00001337          	lui	x6,0x1
    80000204:	8003031b          	addiw	x6,x6,-2048 # 800 <_start-0x7ffff800>
    80000208:	30032073          	csrrs	x0,mstatus,x6
    8000020c:	30200073          	mret
    80000210:	10500073          	wfi
    80000214:	0002f2b3          	and	x5,x5,x0
    80000218:	000c02b7          	lui	x5,0xc0
    8000021c:	1002b073          	csrrc	x0,sstatus,x5
    80000220:	00037333          	and	x6,x6,x0
    80000224:	000c0337          	lui	x6,0xc0
    80000228:	10032073          	csrrs	x0,sstatus,x6
    8000022c:	100023f3          	csrrs	x7,sstatus,x0
    80000230:	0053f3b3          	and	x7,x7,x5
    80000234:	06038463          	beq	x7,x0,8000029c <bare_s_1>
    80000238:	1002b073          	csrrc	x0,sstatus,x5
    8000023c:	12000073          	sfence.vma	x0,x0
    80000240:	180022f3          	csrrs	x5,satp,x0

0000000080000244 <bad5>:
    80000244:	00000000          	.word	0x00000000
    80000248:	0780006f          	jal	x0,800002c0 <fail>

000000008000024c <bad6>:
    8000024c:	12000073          	sfence.vma	x0,x0
    80000250:	0700006f          	jal	x0,800002c0 <fail>

0000000080000254 <bad7>:
    80000254:	180022f3          	csrrs	x5,satp,x0
    80000258:	0680006f          	jal	x0,800002c0 <fail>

000000008000025c <test_tsr>:
    8000025c:	00000297          	auipc	x5,0x0
    80000260:	02028293          	addi	x5,x5,32 # 8000027c <bad8>
    80000264:	14129073          	csrrw	x0,sepc,x5
    80000268:	10000293          	addi	x5,x0,256
    8000026c:	1002a073          	csrrs	x0,sstatus,x5
    80000270:	02000293          	addi	x5,x0,32
    80000274:	1002b073          	csrrc	x0,sstatus,x5
    80000278:	10200073          	sret

000000008000027c <bad8>:
    8000027c:	00000000          	.word	0x00000000
    80000280:	0400006f          	jal	x0,800002c0 <fail>
    80000284:	00000297          	auipc	x5,0x0
    80000288:	01028293          	addi	x5,x5,16 # 80000294 <bad9+0x4>
    8000028c:	14129073          	csrrw	x0,sepc,x5

0000000080000290 <bad9>:
    80000290:	10200073          	sret
    80000294:	02c0006f          	jal	x0,800002c0 <fail>
    80000298:	0240006f          	jal	x0,800002bc <skip_bare_s>

000000008000029c <bare_s_1>:
    8000029c:	12000073          	sfence.vma	x0,x0
    800002a0:	0200006f          	jal	x0,800002c0 <fail>

00000000800002a4 <bare_s_2>:
    800002a4:	12000073          	sfence.vma	x0,x0
    800002a8:	0180006f          	jal	x0,800002c0 <fail>
    800002ac:	180022f3          	csrrs	x5,satp,x0

00000000800002b0 <bare_s_3>:
    800002b0:	00000000          	.word	0x00000000
    800002b4:	00c0006f          	jal	x0,800002c0 <fail>
    800002b8:	fa5ff06f          	jal	x0,8000025c <test_tsr>

00000000800002bc <skip_bare_s>:
    800002bc:	02301063          	bne	x0,x3,800002dc <pass>

00000000800002c0 <fail>:
    800002c0:	0ff0000f          	fence	iorw,iorw
    800002c4:	00018063          	beq	x3,x0,800002c4 <fail+0x4>
    800002c8:	00119193          	slli	x3,x3,0x1
    800002cc:	0011e193          	ori	x3,x3,1
    800002d0:	05d00893          	addi	x17,x0,93
    800002d4:	00018513          	addi	x10,x3,0
    800002d8:	00000073          	ecall

00000000800002dc <pass>:
    800002dc:	0ff0000f          	fence	iorw,iorw
    800002e0:	00100193          	addi	x3,x0,1
    800002e4:	05d00893          	addi	x17,x0,93
    800002e8:	00000513          	addi	x10,x0,0
    800002ec:	00000073          	ecall
    800002f0:	00000013          	addi	x0,x0,0
    800002f4:	00000013          	addi	x0,x0,0
    800002f8:	00000013          	addi	x0,x0,0
    800002fc:	00000013          	addi	x0,x0,0

0000000080000300 <mtvec_handler>:
    80000300:	0400006f          	jal	x0,80000340 <synchronous_exception>
    80000304:	eddff06f          	jal	x0,800001e0 <msip>
    80000308:	fb9ff06f          	jal	x0,800002c0 <fail>
    8000030c:	fb5ff06f          	jal	x0,800002c0 <fail>
    80000310:	fb1ff06f          	jal	x0,800002c0 <fail>
    80000314:	fadff06f          	jal	x0,800002c0 <fail>
    80000318:	fa9ff06f          	jal	x0,800002c0 <fail>
    8000031c:	fa5ff06f          	jal	x0,800002c0 <fail>
    80000320:	fa1ff06f          	jal	x0,800002c0 <fail>
    80000324:	f9dff06f          	jal	x0,800002c0 <fail>
    80000328:	f99ff06f          	jal	x0,800002c0 <fail>
    8000032c:	f95ff06f          	jal	x0,800002c0 <fail>
    80000330:	f91ff06f          	jal	x0,800002c0 <fail>
    80000334:	f8dff06f          	jal	x0,800002c0 <fail>
    80000338:	f89ff06f          	jal	x0,800002c0 <fail>
    8000033c:	f85ff06f          	jal	x0,800002c0 <fail>

0000000080000340 <synchronous_exception>:
    80000340:	00200313          	addi	x6,x0,2
    80000344:	342022f3          	csrrs	x5,mcause,x0
    80000348:	f6629ce3          	bne	x5,x6,800002c0 <fail>
    8000034c:	341022f3          	csrrs	x5,mepc,x0
    80000350:	343023f3          	csrrs	x7,mtval,x0
    80000354:	00038e63          	beq	x7,x0,80000370 <synchronous_exception+0x30>
    80000358:	0002d303          	lhu	x6,0(x5)
    8000035c:	0063c3b3          	xor	x7,x7,x6
    80000360:	0022d303          	lhu	x6,2(x5)
    80000364:	01031313          	slli	x6,x6,0x10
    80000368:	0063c3b3          	xor	x7,x7,x6
    8000036c:	f4039ae3          	bne	x7,x0,800002c0 <fail>
    80000370:	00000317          	auipc	x6,0x0
    80000374:	e1c30313          	addi	x6,x6,-484 # 8000018c <bad2>
    80000378:	06628463          	beq	x5,x6,800003e0 <synchronous_exception+0xa0>
    8000037c:	00000317          	auipc	x6,0x0
    80000380:	ec830313          	addi	x6,x6,-312 # 80000244 <bad5>
    80000384:	06628463          	beq	x5,x6,800003ec <synchronous_exception+0xac>
    80000388:	00000317          	auipc	x6,0x0
    8000038c:	ec430313          	addi	x6,x6,-316 # 8000024c <bad6>
    80000390:	04628863          	beq	x5,x6,800003e0 <synchronous_exception+0xa0>
    80000394:	00000317          	auipc	x6,0x0
    80000398:	ec030313          	addi	x6,x6,-320 # 80000254 <bad7>
    8000039c:	04628263          	beq	x5,x6,800003e0 <synchronous_exception+0xa0>
    800003a0:	00000317          	auipc	x6,0x0
    800003a4:	edc30313          	addi	x6,x6,-292 # 8000027c <bad8>
    800003a8:	04628863          	beq	x5,x6,800003f8 <synchronous_exception+0xb8>
    800003ac:	00000317          	auipc	x6,0x0
    800003b0:	ee430313          	addi	x6,x6,-284 # 80000290 <bad9>
    800003b4:	04628863          	beq	x5,x6,80000404 <synchronous_exception+0xc4>
    800003b8:	00000317          	auipc	x6,0x0
    800003bc:	ee430313          	addi	x6,x6,-284 # 8000029c <bare_s_1>
    800003c0:	02628663          	beq	x5,x6,800003ec <synchronous_exception+0xac>
    800003c4:	00000317          	auipc	x6,0x0
    800003c8:	ee030313          	addi	x6,x6,-288 # 800002a4 <bare_s_2>
    800003cc:	00628a63          	beq	x5,x6,800003e0 <synchronous_exception+0xa0>
    800003d0:	00000317          	auipc	x6,0x0
    800003d4:	ee030313          	addi	x6,x6,-288 # 800002b0 <bare_s_3>
    800003d8:	00628463          	beq	x5,x6,800003e0 <synchronous_exception+0xa0>
    800003dc:	ee5ff06f          	jal	x0,800002c0 <fail>
    800003e0:	00828293          	addi	x5,x5,8
    800003e4:	34129073          	csrrw	x0,mepc,x5
    800003e8:	30200073          	mret
    800003ec:	00100337          	lui	x6,0x100
    800003f0:	30032073          	csrrs	x0,mstatus,x6
    800003f4:	fedff06f          	jal	x0,800003e0 <synchronous_exception+0xa0>
    800003f8:	00400337          	lui	x6,0x400
    800003fc:	30032073          	csrrs	x0,mstatus,x6
    80000400:	fe1ff06f          	jal	x0,800003e0 <synchronous_exception+0xa0>
    80000404:	fddff06f          	jal	x0,800003e0 <synchronous_exception+0xa0>
    80000408:	c0001073          	unimp
	...
