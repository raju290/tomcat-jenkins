~#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd.service
systemctl enable httpd.service 
yum install wget -y
yum install docker -y
service docker start
cd /opt
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz
tar -xf jdk-8u201-linux-x64.tar.gz
rm -rf jdk-8u201-linux-x64.tar.gz
mv jdk1.8.0_201 java8

echo "export JAVA_HOME=/opt/java8" >> /etc/profile
echo "export PATH=$PATH:/opt/java8/bin:/opt/java8/jre/bin" >> /etc/profile
source /etc/profile

wget http://mirrors.estointernet.in/apache/tomcat/tomcat-7/v7.0.92/bin/apache-tomcat-7.0.92.tar.gz
tar -xvf apache-tomcat-7.0.92.tar.gz
rm -rvf apache-tomcat-7.0.92.tar.gz
mv apache-tomcat-7.0.92/ tom7
cd /opt/tom7/webapps/
wget https://updates.jenkins-ci.org/download/war/2.155/jenkins.war

sed -i '$d' /opt/tom7/conf/tomcat-users.xml
echo '<role rolename="manager-gui"/>' >> /opt/tom7/conf/tomcat-users.xml
echo '<user username="tomcat" password="tomcat" roles="manager-gui"/>' >> /opt/tom7/conf/tomcat-users.xml
echo '</tomcat-users>' >> /opt/tom7/conf/tomcat-users.xml

bash /opt/tom7/bin/startup.sh
