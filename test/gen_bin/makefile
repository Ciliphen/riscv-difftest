TARGET = test

all:./build/$(TARGET).bin

./build/$(TARGET).bin:./build/$(TARGET)
	riscv64-unknown-linux-gnu-objcopy -O binary ./build/$(TARGET) ./build/$(TARGET).bin

./build/$(TARGET):./build/$(TARGET).o
	riscv64-unknown-linux-gnu-ld -T ./linker.ld -o ./build/$(TARGET) ./build/$(TARGET).o

./build/$(TARGET).o:./build/$(TARGET).s
	riscv64-unknown-linux-gnu-as -o ./build/$(TARGET).o ./build/$(TARGET).s