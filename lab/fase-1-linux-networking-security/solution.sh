#!/bin/bash
# Reference Solution for the Hands-On Lab (Only open if you get stuck!)

# Task 1: Build the Directory Structure
mkdir -p ~/app-deploy/{configs,scripts,logs}
cp -r ~/app-deploy/configs ~/app-deploy/configs-backup

# Task 2: Text Creation, Redirection, and Tee
echo "#!/bin/bash" > ~/app-deploy/scripts/deploy.sh
echo 'echo "Starting Deployment"' >> ~/app-deploy/scripts/deploy.sh
uname -a | tee ~/app-deploy/logs/system_info.log

# Task 3: Configure Numeric Permissions
chmod 755 ~/app-deploy/scripts/deploy.sh
echo "DB_PASS=secret123" > ~/app-deploy/configs/database.env
chmod 600 ~/app-deploy/configs/database.env

# Task 4: Wildcards and Finding Files
touch ~/app-deploy/configs/web-1.conf ~/app-deploy/configs/web-2.conf ~/app-deploy/configs/web-test.conf
ls ~/app-deploy/configs/web-[12].conf
find ~/app-deploy -name "*.conf" > ~/app-deploy/logs/found_configs.txt

# Task 5: Hard Links and Symbolic Links
echo "SERVER_PORT=8080" > ~/app-deploy/configs/master.conf
ln ~/app-deploy/configs/master.conf ~/app-deploy/configs/hard_master.conf
ln -s ~/app-deploy/configs/master.conf ~/app-deploy/quick_access.conf
mv ~/app-deploy/configs/master.conf ~/app-deploy/configs/master.conf.bak
