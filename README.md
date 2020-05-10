# smart_switch_hack
# 模块说明
无线模块使用的是esp8285 相当于esp8266 + 内置1MB Flash
# 信号说明
![screenshot](https://github.com/wuxx/smart_switch_hack/blob/master/doc/pcb.jpg)

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
按键一端接地，另一端直接接的GPIO0

## LED1
靠近直插电容的LED
GPIO12 - 电阻- LED - GND  
同时还接了继电器  
GPIO12 - 电阻4.7K - 三极管J3（S8050）B级 - 继电器  


## LED2
靠近天线的LED
GPIO13  - LED - 电阻561 - 3.3V

# 烧录命令
`cd image`  
`./flash_write_esp8285.sh`

# 测试
请替换命令行中的IP地址  
`curl -X POST http://192.168.31.153/gpio?gpio12=0`
`curl -X POST http://192.168.31.153/gpio?gpio12=1`

# 何处购买智能开关
请自行搜索 米家天猫小度智能音箱语音控制WiFi智能插座国标5孔智能远程定时

# 免责声明
智能开关破解及使用涉及220V市电，具有一定危险性，本人仅提供技术思路，风险自担。
