source common.sh

print_head "installing nginx"
yum install nginx -y &>>${log_file}
status_check $?

print_head "removing old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
status_check $?

print_head "installing roboshop code"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}
status_check $?

print_head "enabling reverse proxy"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
status_check $?

print_head "enabling nginx"
systemctl enable nginx &>>${log_file}
status_check $?

print_head "restarting nginx"
systemctl restart nginx &>>${log_file}
status_check $?

