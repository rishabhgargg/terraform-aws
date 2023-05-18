MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/cloud-config; charset="us-ascii"

packages:
- amazon-efs-utils

runcmd:
- yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm 
- systemctl enable amazon-ssm-agent 
- systemctl start amazon-ssm-agent 
- sed -i 's/1024\:4096/1024000\:1024000/g' /etc/sysconfig/docker
- sed -i -e  '$aec2-user soft nofile 1024000\nec2-user hard nofile 1024000\nroot soft nofile 1024000\nroot hard nofile 1024000' /etc/security/limits.conf

--==MYBOUNDARY==--
