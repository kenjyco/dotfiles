alias ip-public="wget http://bot.whatismyipaddress.com -qO - && echo"
ip-local() { ifconfig | grep "inet addr" | grep -v ":127" | awk '{print $2}' | cut -c 6- ; }
