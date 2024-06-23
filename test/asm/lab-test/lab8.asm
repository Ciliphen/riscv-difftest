
./build/test:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_start>:
    80000000:	00200193          	addi	x3,x0,2
    80000004:	30102573          	csrrs	x10,misa,x0
    80000008:	03e55513          	srli	x10,x10,0x3e
    8000000c:	00200393          	addi	x7,x0,2
    80000010:	26751463          	bne	x10,x7,80000278 <fail>

0000000080000014 <test_3>:
    80000014:	00300193          	addi	x3,x0,3
    80000018:	f1402573          	csrrs	x10,mhartid,x0
    8000001c:	00000393          	addi	x7,x0,0
    80000020:	24751c63          	bne	x10,x7,80000278 <fail>
    80000024:	f1302573          	csrrs	x10,mimpid,x0
    80000028:	f1302573          	csrrs	x10,mimpid,x0
    8000002c:	f1202573          	csrrs	x10,marchid,x0
    80000030:	f1102573          	csrrs	x10,mvendorid,x0
    80000034:	00000293          	addi	x5,x0,0
    80000038:	3052a073          	csrrs	x0,mtvec,x5
    8000003c:	3412a073          	csrrs	x0,mepc,x5
    80000040:	000022b7          	lui	x5,0x2
    80000044:	8002829b          	addiw	x5,x5,-2048 # 1800 <_start-0x7fffe800>
    80000048:	3002b073          	csrrc	x0,mstatus,x5
    8000004c:	30002373          	csrrs	x6,mstatus,x0
    80000050:	0062f2b3          	and	x5,x5,x6
    80000054:	02029463          	bne	x5,x0,8000007c <test_5>

0000000080000058 <test_4>:
    80000058:	00400193          	addi	x3,x0,4
    8000005c:	30002573          	csrrs	x10,mstatus,x0
    80000060:	0030059b          	addiw	x11,x0,3
    80000064:	02059593          	slli	x11,x11,0x20
    80000068:	00b57533          	and	x10,x10,x11
    8000006c:	0010039b          	addiw	x7,x0,1
    80000070:	02139393          	slli	x7,x7,0x21
    80000074:	20751263          	bne	x10,x7,80000278 <fail>
    80000078:	0200006f          	jal	x0,80000098 <test_6>

000000008000007c <test_5>:
    8000007c:	00500193          	addi	x3,x0,5
    80000080:	30002573          	csrrs	x10,mstatus,x0
    80000084:	0030059b          	addiw	x11,x0,3
    80000088:	02059593          	slli	x11,x11,0x20
    8000008c:	00b57533          	and	x10,x10,x11
    80000090:	00000393          	addi	x7,x0,0
    80000094:	1e751263          	bne	x10,x7,80000278 <fail>

0000000080000098 <test_6>:
    80000098:	00600193          	addi	x3,x0,6
    8000009c:	c0003073          	csrrc	x0,cycle,x0
    800000a0:	00000393          	addi	x7,x0,0
    800000a4:	1c701a63          	bne	x0,x7,80000278 <fail>

00000000800000a8 <test_7>:
    800000a8:	00700193          	addi	x3,x0,7
    800000ac:	c0002073          	csrrs	x0,cycle,x0
    800000b0:	00000393          	addi	x7,x0,0
    800000b4:	1c701263          	bne	x0,x7,80000278 <fail>

00000000800000b8 <test_8>:
    800000b8:	00800193          	addi	x3,x0,8
    800000bc:	c0007073          	csrrci	x0,cycle,0
    800000c0:	00000393          	addi	x7,x0,0
    800000c4:	1a701a63          	bne	x0,x7,80000278 <fail>

00000000800000c8 <test_9>:
    800000c8:	00900193          	addi	x3,x0,9
    800000cc:	c0006073          	csrrsi	x0,cycle,0
    800000d0:	00000393          	addi	x7,x0,0
    800000d4:	1a701263          	bne	x0,x7,80000278 <fail>

00000000800000d8 <test_10>:
    800000d8:	00a00193          	addi	x3,x0,10
    800000dc:	34001073          	csrrw	x0,mscratch,x0
    800000e0:	34002573          	csrrs	x10,mscratch,x0
    800000e4:	00000393          	addi	x7,x0,0
    800000e8:	18751863          	bne	x10,x7,80000278 <fail>

00000000800000ec <test_11>:
    800000ec:	00b00193          	addi	x3,x0,11
    800000f0:	34005573          	csrrwi	x10,mscratch,0
    800000f4:	3407d573          	csrrwi	x10,mscratch,15
    800000f8:	00000393          	addi	x7,x0,0
    800000fc:	16751e63          	bne	x10,x7,80000278 <fail>

0000000080000100 <test_12>:
    80000100:	00c00193          	addi	x3,x0,12
    80000104:	34086073          	csrrsi	x0,mscratch,16
    80000108:	34002573          	csrrs	x10,mscratch,x0
    8000010c:	01f00393          	addi	x7,x0,31
    80000110:	16751463          	bne	x10,x7,80000278 <fail>
    80000114:	3401d073          	csrrwi	x0,mscratch,3

0000000080000118 <test_13>:
    80000118:	00d00193          	addi	x3,x0,13
    8000011c:	34002573          	csrrs	x10,mscratch,x0
    80000120:	00300393          	addi	x7,x0,3
    80000124:	14751a63          	bne	x10,x7,80000278 <fail>

0000000080000128 <test_14>:
    80000128:	00e00193          	addi	x3,x0,14
    8000012c:	3400f5f3          	csrrci	x11,mscratch,1
    80000130:	00300393          	addi	x7,x0,3
    80000134:	14759263          	bne	x11,x7,80000278 <fail>

0000000080000138 <test_15>:
    80000138:	00f00193          	addi	x3,x0,15
    8000013c:	34026673          	csrrsi	x12,mscratch,4
    80000140:	00200393          	addi	x7,x0,2
    80000144:	12761a63          	bne	x12,x7,80000278 <fail>

0000000080000148 <test_16>:
    80000148:	01000193          	addi	x3,x0,16
    8000014c:	340156f3          	csrrwi	x13,mscratch,2
    80000150:	00600393          	addi	x7,x0,6
    80000154:	12769263          	bne	x13,x7,80000278 <fail>

0000000080000158 <test_17>:
    80000158:	01100193          	addi	x3,x0,17
    8000015c:	0bad2537          	lui	x10,0xbad2
    80000160:	dea5051b          	addiw	x10,x10,-534 # bad1dea <_start-0x7452e216>
    80000164:	340515f3          	csrrw	x11,mscratch,x10
    80000168:	00200393          	addi	x7,x0,2
    8000016c:	10759663          	bne	x11,x7,80000278 <fail>

0000000080000170 <test_18>:
    80000170:	01200193          	addi	x3,x0,18
    80000174:	00002537          	lui	x10,0x2
    80000178:	dea5051b          	addiw	x10,x10,-534 # 1dea <_start-0x7fffe216>
    8000017c:	340535f3          	csrrc	x11,mscratch,x10
    80000180:	0bad23b7          	lui	x7,0xbad2
    80000184:	dea3839b          	addiw	x7,x7,-534 # bad1dea <_start-0x7452e216>
    80000188:	0e759863          	bne	x11,x7,80000278 <fail>

000000008000018c <test_19>:
    8000018c:	01300193          	addi	x3,x0,19
    80000190:	0000c537          	lui	x10,0xc
    80000194:	eef5051b          	addiw	x10,x10,-273 # beef <_start-0x7fff4111>
    80000198:	340525f3          	csrrs	x11,mscratch,x10
    8000019c:	0bad03b7          	lui	x7,0xbad0
    800001a0:	0c759c63          	bne	x11,x7,80000278 <fail>

00000000800001a4 <test_20>:
    800001a4:	01400193          	addi	x3,x0,20
    800001a8:	0bad2537          	lui	x10,0xbad2
    800001ac:	dea5051b          	addiw	x10,x10,-534 # bad1dea <_start-0x7452e216>
    800001b0:	34051573          	csrrw	x10,mscratch,x10
    800001b4:	0badc3b7          	lui	x7,0xbadc
    800001b8:	eef3839b          	addiw	x7,x7,-273 # badbeef <_start-0x74524111>
    800001bc:	0a751e63          	bne	x10,x7,80000278 <fail>

00000000800001c0 <test_21>:
    800001c0:	01500193          	addi	x3,x0,21
    800001c4:	00002537          	lui	x10,0x2
    800001c8:	dea5051b          	addiw	x10,x10,-534 # 1dea <_start-0x7fffe216>
    800001cc:	34053573          	csrrc	x10,mscratch,x10
    800001d0:	0bad23b7          	lui	x7,0xbad2
    800001d4:	dea3839b          	addiw	x7,x7,-534 # bad1dea <_start-0x7452e216>
    800001d8:	0a751063          	bne	x10,x7,80000278 <fail>

00000000800001dc <test_22>:
    800001dc:	01600193          	addi	x3,x0,22
    800001e0:	0000c537          	lui	x10,0xc
    800001e4:	eef5051b          	addiw	x10,x10,-273 # beef <_start-0x7fff4111>
    800001e8:	34052573          	csrrs	x10,mscratch,x10
    800001ec:	0bad03b7          	lui	x7,0xbad0
    800001f0:	08751463          	bne	x10,x7,80000278 <fail>

00000000800001f4 <test_23>:
    800001f4:	01700193          	addi	x3,x0,23
    800001f8:	34002573          	csrrs	x10,mscratch,x0
    800001fc:	0badc3b7          	lui	x7,0xbadc
    80000200:	eef3839b          	addiw	x7,x7,-273 # badbeef <_start-0x74524111>
    80000204:	06751a63          	bne	x10,x7,80000278 <fail>
    80000208:	30102573          	csrrs	x10,misa,x0
    8000020c:	02057513          	andi	x10,x10,32
    80000210:	00050263          	beq	x10,x0,80000214 <test_23+0x20>
    80000214:	30102573          	csrrs	x10,misa,x0
    80000218:	01455513          	srli	x10,x10,0x14
    8000021c:	00157513          	andi	x10,x10,1
    80000220:	04050263          	beq	x10,x0,80000264 <finish>
    80000224:	3060d073          	csrrwi	x0,mcounteren,1
    80000228:	30102573          	csrrs	x10,misa,x0
    8000022c:	01255513          	srli	x10,x10,0x12
    80000230:	00157513          	andi	x10,x10,1
    80000234:	00050463          	beq	x10,x0,8000023c <test_23+0x48>
    80000238:	1060d073          	csrrwi	x0,scounteren,1
    8000023c:	10000293          	addi	x5,x0,256
    80000240:	3002b073          	csrrc	x0,mstatus,x5
    80000244:	00000297          	auipc	x5,0x0
    80000248:	01028293          	addi	x5,x5,16 # 80000254 <test_24>
    8000024c:	34129073          	csrrw	x0,mepc,x5
    80000250:	00000013          	addi	x0,x0,0

0000000080000254 <test_24>:
    80000254:	01800193          	addi	x3,x0,24
    80000258:	00000013          	addi	x0,x0,0
    8000025c:	00000393          	addi	x7,x0,0
    80000260:	00701c63          	bne	x0,x7,80000278 <fail>

0000000080000264 <finish>:
    80000264:	00100193          	addi	x3,x0,1
    80000268:	05d00893          	addi	x17,x0,93
    8000026c:	00000513          	addi	x10,x0,0
    80000270:	00000073          	ecall
    80000274:	00301e63          	bne	x0,x3,80000290 <pass>

0000000080000278 <fail>:
    80000278:	00018063          	beq	x3,x0,80000278 <fail>
    8000027c:	00119193          	slli	x3,x3,0x1
    80000280:	0011e193          	ori	x3,x3,1
    80000284:	05d00893          	addi	x17,x0,93
    80000288:	00018513          	addi	x10,x3,0
    8000028c:	00000073          	ecall

0000000080000290 <pass>:
    80000290:	00100193          	addi	x3,x0,1
    80000294:	05d00893          	addi	x17,x0,93
    80000298:	00000513          	addi	x10,x0,0
    8000029c:	00000073          	ecall
