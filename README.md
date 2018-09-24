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

## 汇编语言通用框架

```masm
DATAS SEGMENT
    ;; 存放数据

DATAS ENDS

CODES SEGMENT
    ;; 代码段
    ASSUME CS:CODES, DS:DATAS

START:
    ;; 初始化段首址
    MOV AX, DATAS
    MOV DS, AX

    ;; 主程序, 代码写在下面

    ;; 按下任意键即可退出程序
    MOV AH, 4CH
    INT 21H

    ;; 代码段结束
CODES ENDS

    END START
```
