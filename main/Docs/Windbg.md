### 从Dump中提取C#代码

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



