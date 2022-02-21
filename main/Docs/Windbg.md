#### 从Dump中提取C#代码

1. 简单程序

   （1）获取所有模块，MyApp_2c2264b0000 为模块，MyApp   (deferred) 是 PE 文件

   ```bash
   0:000> lm 
   start             end                 module name 
   000002c2`264b0000 000002c2`264b8000   MyApp_2c2264b0000   (deferred)              
   00007ff7`e4a50000 00007ff7`e4a7f000   MyApp   (deferred)   
   ```

   （2）保存模块，后续即可反编译

   ```bash
   0:000> !savemodule 000002c2`264b0000 E:\dump\MyApp.exe
   3 sections in file
   section 0 - VA=2000, VASize=6c4, FileAddr=200, FileSize=800
   section 1 - VA=4000, VASize=564, FileAddr=a00, FileSize=600
   section 2 - VA=6000, VASize=c, FileAddr=1000, FileSize=200
   ```

2. 复杂的程序

   （1）找到域

   ```bash
   0:000> !dumpdomain
   --------------------------------------
   System Domain:      00007ffaa59996f0
   ...
   --------------------------------------
   Domain 1:           000002c224b6ca80
   ...
   Assembly:           000002c224bf1980 [...\MyApp.dll]
   ClassLoader:        000002C224BE3F80
     Module
     00007ffa45b5f7d0    ...\MyApp.dll
   ```

   （2）获取模块详细信息

   ```bash
   0:000> !DumpModule /d 00007ffa45b5f7d0
   Name: ...\MyApp.dll
   ...
   BaseAddress:             000002C2264B0000
   ...
   ```

   （3）保存模块，同简单程序

#### 堆

1. 查看托管堆状态

   

#### 线程

1. 查看线程整体状况

   ```bash
   0:000> !t
   ThreadCount:      60
   BackgroundThread: 38
   DeadThread:       22
                                                                            Lock  
          ID OSID ThreadOBJ    State GC Mode     GC Alloc Context  Domain   Count Apt Exception
     11    1 2c24 02487038     28220 Preemptive  00000000:00000000 010df4f8 0     Ukn 
     ...
   ```

2. 查看线程池整体状况

   ```bash
   0:000> !tp
   CPU utilization: 97%
   Worker Thread: Total: 21 Running: 21 Idle: 0 MaxLimit: 8191 MinLimit: 8
   Work Request in Queue: 23
   ...
   --------------------------------------
   Number of Timers: 0
   --------------------------------------
   Completion Port Thread:Total: 1 Free: 1 MaxFree: 16 CurrentLimit: 1 MaxLimit: 1000 MinLimit: 8
   ```

3. 查看所有线程的托管栈信息

   ```bash
   0:000> ~ *e !clrstack
   OS Thread Id: 0x8d8 (44)
   Child SP       IP Call Site
   1ad8d750 7759f901 [InlinedCallFrame: 1ad8d750] 
   ...
   OS Thread Id: 0x26a0 (52)
   Child SP       IP Call Site
   1d32d9d0 7759f901 [InlinedCallFrame: 1d32d9d0] 
   ...
   ```

4. 查看所有线程的托管和非托管栈信息

   ```bash
   0:000> ~ *e !dumpstack
   ```

   



