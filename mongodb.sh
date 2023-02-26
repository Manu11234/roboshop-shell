source common.sh

cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install MongoDB"
yum install mongodb-org -y &>>${log_file}

print_head "Enable MongoDB"
systemctl enable mongod

print_head "Start Mongodb"
systemctl start mongod

# update /etc/mongod.conf from 127.0.0.1 with 0.0.0.0

