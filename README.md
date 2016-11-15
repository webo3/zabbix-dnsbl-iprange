zabbix-dnsbl-iprange
------------------

zabbix-dnsbl-iprange is based on :

https://zabbix.tips/are-your-servers-blacklisted/

###### Requirements:

CentOS/RHEL
# yum install bind-utils

Debian/Ubuntu
# apt-get install dnsutils

###### Instructions:

Copy “externalscripts/*” to your Zabbix Servers and place it in the correct folder “/usr/lib/zabbix/externalscripts” *

* Check your server and proxy configuration file for the correct folder, look for the tag “ExternalScripts”

Make the script executable: chmod +x /usr/lib/zabbix/externalscripts/*.sh

Create the following value map:
(Administration -> General -> Value mapping: Create value map)

  Name: IP Blacklist
* 0 -> Not listed
* 1 -> Listed

Import the template.

Create assign to you host, the edit the /usr/lib/zabbix/externalscripts/get_ips.sh to add you host ip range that you want to verify.
