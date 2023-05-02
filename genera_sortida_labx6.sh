#!/bin/sh

# Assignatura: GSX
# Autor: Josep M Banús Alsina
# Versió: 1.1

# Descripció:
# Comprova la configuració actual i la guarda
# a un fitxer (ex: 'sortida_admin_labx6.txt').
# Aquest fitxer l'adjuntareu al moodle 
# per a avaluar si ho heu fet bé.

# Execució: 
# Al contenidor admin: ./genera_sortida_labx5.sh
# Al final, quan ja us funcionin els scripts.

# Important:
############
# no modifiqueu aquest script ni els seus resultats,
# doncs l'avaluació no seria correcta.

qui=$(hostname | cut -f1 -d'.')
case $qui in
	'admin')	peer='router'
		;;
	*)	echo "error en el hostname '$qui'"
		exit 1
esac
out="./sortida_${qui}_labx6.txt"

date > $out
echo >>$out

dgw=$(ip route | grep default | cut -f3 -d' ')
router=$(host router.gsx.int | grep -o "[0-9\.]\{7,15\}")
echo $dgw = $router >>$out
echo >>$out

ping -q -c11 $dgw >>$out
echo >>$out

ss -lnup >> $out
echo >>$out
nmap -sU -p 161 $peer >> $out
echo >>$out

echo snmp LOCALHOST 
echo LOCALHOST >>$out
./proves_snmp.sh localhost >>$out 2>&1
echo >>$out
echo snmp ROUTER 
echo ROUTER >>$out
./proves_snmp.sh $dgw >>$out 2>&1
echo >>$out
echo snmp SERVER 
echo SERVER >>$out
./proves_snmp.sh ldap.gsx.gei >>$out 2>&1
echo >>$out

echo CRONTAB >>$out
ls -la /var/spool/cron/crontabs >> $out
crontab -l | grep snmp >> $out

echo JOURNAL >>$out
journalctl -p4 | grep GSX >>$out
echo >>$out

