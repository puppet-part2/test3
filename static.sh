objdump -d ${1} | grep -Eo '\$0x[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]' | cut -c 2- | sort -u |awk '{print "\""$1"\"" }' > dicttest