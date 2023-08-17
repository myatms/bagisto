# Set up Laravel after main deployment. Called from CodeDeploy's
# appspec.yml.

# Move the previously downloaded .env file to the right place.
composer update --working-dir=/var/www/html/bagisto
sudo rm -rf /var/www/html/bagisto/.env
sudo mv /tmp/env.txt /var/www/html/bagisto/.env
sudo rm -rf /etc/nginx/nginx.conf
sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf

sudo chown ec2-user:ec2-user /var/www/html/bagisto/.env
sudo chmod 775 /var/www/html/bagisto/.env

sudo php /var/www/html/bagisto/artisan key:generate
sudo php /var/www/html/bagisto/artisan migrate
sudo php /var/www/html/bagisto/artisan db:seed
sudo php /var/www/html/bagisto/artisan vendor:publish --tag=0
sudo php /var/www/html/bagisto/artisan storage:link
sudo chmod -R 777 /var/www/html/bagisto/storage/

# Reload php-fpm to clear OPcache.
sudo systemctl restart php-fpm
sudo systemctl restart nginx

touch /tmp/deployment-done


