# Prepares for the deployment. Called from CodeDeploy's appspec.yml.

touch /tmp/deployment-started

aws s3 cp s3://mms-codedeploy/env.txt /tmp/env.txt
aws s3 cp s3://mms-codedeploy/nginx.conf /tmp/nginx.conf
sudo chown -R ec2-user:ec2-user /var/www/html/
sudo chmod -R 775 /var/www/html/

touch /tmp/deployment-cleared

