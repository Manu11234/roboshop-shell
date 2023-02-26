code_dir=$(pwd)
echo -e "\e[35minstalling nginx\e[0m"
yum install nginx -y

echo -e "\e[35mremoving old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35minstalling roboshop code\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[35menabling reverse proxy\e[0m"
pwd
ls -l
cp ${pwd}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35menabling nginx\e[0m"
systemctl enable nginx
echo -e "\e[35mrestarting nginx\e[0m"
systemctl restart nginx
