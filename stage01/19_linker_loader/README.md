## reference
http://www.cfanz.cn/?c=article&a=read&id=24552

## compile linepipe

- 预处理(Pre-processing)
完成宏替换、文件引入，以及去除空行、注释等为词法分析准备
gcc -E main.c -o main.i

- 编译(Comping)
.i源文件编译成汇编文件，
gcc -S main.i -o main.s

- 汇编(Assembling)
把汇编文件转成二进制目标文件，生成ELF(Executable Linkable Format)
gcc -c main.s -o main.o

- 链接(Link)
把二进制目标文件转成可执行二进制文件，也是ELF格式
gcc main.o -o main

- 加载(Load)
把可执行文件加载到机器的内存，准备执行


## debug command

### read elf files
- readelf

- nm

- objdump

- addr2line

- ldd
