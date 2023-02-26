source common.sh

cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install MongoDB"
yum install mongodb-org -y &>>${log_file}

print_head "Update Mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

print_head "Enable MongoDB"
systemctl enable mongod

print_head "Start Mongodb"
systemctl restart mongod

# update /etc/mongod.conf from 127.0.0.1 with 0.0.0.0

