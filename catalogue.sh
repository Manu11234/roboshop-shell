source common.sh

print_head "downloading node js"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "installing node js"
yum install nodejs -y &>>${log_file}

print_head "adding user"
useradd roboshop
mkdir /app
print_head "removing app old content"
rm -rf /app/* &>>${log_file}

print_head "downloading roboshop catalogue code"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}

cd /app

print_head "unzip code"
unzip /tmp/catalogue.zip &>>${log_file}

print_head (installing node js package)
npm install &>>${log_file}

print_head "accessing catalogue service"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

systemctl daemon-reload

print_head "enable catalogue"
systemctl enable catalogue &>>${log_file}

print_head "restart catalogue"
systemctl start catalogue &>>${log_file}

print_head "configure mongodb"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

print_head "Installing mongodb"
yum install mongodb-org-shell -y &>>${log_file}

print_head "Accessing schema"
mongo --host mongodb.manudevops.tech </app/schema/catalogue.js &>>${log_file}
