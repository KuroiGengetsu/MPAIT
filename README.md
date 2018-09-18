# MPAIT

Microcomputer interface and computer technology

微型计算机接口与技术

该仓库主要是为南京邮电大学 **汇编语言语法实验** 以及 **日常课程** 准备的

## 使用方法

编辑器编辑好 `.asm` 文件之后, 在 cmd 中执行:

```cmd
> ml /c XXX.asm
> link16 XXX.obj
```

编译好之后, 打开 DOSBox, 然后:

```DOS
> mount d D:\...\asm文件所在目录
> d:
> dir
> XXX.exe
```

就可以运行

> DOSBox 的刷新方法: C-F4
> DOSBox 结束进程的方法: C-F9