# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    mysql.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbantam <mbantam@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/02 22:00:09 by mbantam           #+#    #+#              #
#    Updated: 2020/09/02 22:19:28 by mbantam          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password