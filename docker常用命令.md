# Docker��������



1����ȡCentos����

 >docker pull centos:latest



2���鿴�����������

 >docker images centos



3�������������� shell bash

 >docker run -i -t centos /bin/bash



4��ֹͣ����

 >docker stop <CONTAINER ID>



5���鿴������־

 >docker logs -f <CONTAINER ID>



6��ɾ����������

 >docker rm $(docker ps -a -q)



7��ɾ������

 >docker rmi <image id/name>



8���ύ�������ĵ�����ֿ���

 >docker run -i -t centos /bin/bash
 >useradd myuser
 >exit
 >docker ps -a |more
 >docker commit <CONTAINER ID> myuser/centos



9�����������������е� hello.sh

 >docker run -i -t myuser/centos /bin/bash
 >touch /home/myuser/hello.sh
 >echo "echo \"Hello,World!\"" > /home/myuser/hello.sh
 >chmod +x /home/myuser/hello.sh
 >exit
 >docker commit <CONTAINER ID> myuser/centos
 >docker run -i -t myuser/centos /bin/sh /home/myuser/hello.sh



10��������������Nginx

�������а�װ��Nginx�����ύ��������**�������������������80�˿ڣ�**
 >docker run -t -i -p 80:80 nginx/centos /bin/bash
 ����Nginx
 >/data/apps/nginx/sbin/nginx
 (�����������ں�̨����!!!)



11��ӳ�������˿�
 >docker run -d -p 192.168.9.11:2201:22 nginx/centos /usr/sbin/sshd -D

��ssh root@192.168.9.11 -p 2201 ����������

docker run -i -d -t -P -p 8080:80 -p 49180:22 centos:base /bin/bash



