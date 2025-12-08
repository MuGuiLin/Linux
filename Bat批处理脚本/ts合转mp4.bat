# 在windows系统中，可以调用copy命令进行文件合并
# copy命令格式：
#   copy /b  所有ts文件的父目录/*.ts  合成后的文件的绝对路径
# 举例：
#   1，将F:\f\目录下的所有ts文件合成为一个名为new.ts的文件，并存放在E:\f\下面
#       copy /b  F:\f\*.ts  E:\f\new.ts
#
#   2，将F:\f\目录下的所有ts文件合成为一个名为new.mp4的文件，并存放在E:\f\下面
#       copy /b  F:\f\*.ts  E:\f\new.mp4

# 将当前目录中所有的ts文件合成为一个名为xxx.mp4的文件
copy /b  *.ts  xxx.mp4