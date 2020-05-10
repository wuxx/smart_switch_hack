# smart_switch_hack
市面上的智能开关实际上并没那么智能，只能使用厂商提供的app和功能逻辑，于是我破解了一个现成的智能开关方案，并且刷了自己的固件进去，可以实现更自由的逻辑控制，而且成本很低。

# 模块说明
无线模块使用的是esp8285，内部封装了1MB Flash，相当于esp8266 + 1MB Flash

# 信号说明
![PCB](https://github.com/wuxx/smart_switch_hack/blob/master/doc/pcb.jpg)

左上方6个孔为下载口，从左到右依次为：  
1 3.3V  
2 EXT_RSTB  
3 U0TXD  
4 U0RXD  
5 GPIO0  
6 GND  

# 电路说明
板子上有两个LED，一个继电器，一个按键，经过检测，说明如下

## 按键
按键一端接地，另一端接GPIO0
GPIO0 - KEY - GND

## 继电器 & LED1
靠近直插电容的LED，颜色为红色  
GPIO12 - 电阻- LED - GND  
同时还接了继电器  
GPIO12 - 电阻4.7K - 三极管J3（S8050）B级 - 继电器  

## LED2
靠近天线的LED，颜色为蓝色  
GPIO13 - LED - 电阻561 - 3.3V

# 烧录命令
`cd image && ./flash_write_esp8285.sh`  

# 测试
请替换命令行中的IP地址  
`curl -X POST http://192.168.31.153/gpio?gpio12=0`  
`curl -X POST http://192.168.31.153/gpio?gpio12=1`

# 何处购买
智能开关 请自行淘宝搜索 米家天猫小度智能音箱语音控制WiFi智能插座国标5孔智能远程定时  
烧录使用日常的串口工具即可，如CP2102、ch340、等，亦可使用DAP的串口，建议烧录前先备份原始固件，备份命令  
`cd image && ./flash_dump.sh`  
可自行焊接上插针烧录，也可以直接使用探针夹烧录，无需焊接  
![flash](https://github.com/wuxx/smart_switch_hack/blob/master/doc/flash.jpg)

# 源码
源码基于[esp-link](https://github.com/jeelabs/esp-link)，patch位于src目录下，目前实现为直接http请求，暂无UI实现。

# TODO
- UI实现

# 免责声明
智能开关破解及使用涉及220V市电，具有一定危险性，本人仅提供技术思路，风险自担。
