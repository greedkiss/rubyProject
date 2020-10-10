# 日历程序
## 介绍
该日历程序有两个功能  
- 判断是否为润年
- 打印某月的日历  
## 使用方法
用户需先配置ruby环境，[下载地址](ruby-lang.org/en/downloads/)  
*windows环境运行方式*
```shell
ruby calender.rb
```
*linux下运行方式*
```shell
ruby calender.rb
#or
chmod u+x calender.rb
./calender.rb
```
用户输入如2020-10类似的日期格式，程序会返回该年是否是润年并且打印出该月的日历，用户可以输入exit来退出程序  
![运行效果图](https://github.com/greedkiss/markdown_picture/blob/master/calender_running_pic)
## 注意事项
本程序从安全性角度出发，会对用户的输入做一个合法性判断，如果输入格式不符合2020-10之类的格式，程序会返回给用户提示希望用户进行正确的格式输入  
![效果图](https://github.com/greedkiss/markdown_picture/blob/master/calender_error_msg)
