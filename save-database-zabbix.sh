#! /bin/bash

path=`dirname $0`
cd "$path"

#Def de variables
user=zabbix	# Utilisateur de la base de données
passwd=zabbix	# Mot de passe de l'utilisateur de la base
db=zabbix	# Nom de la base
#nbsav=10	#Nombre de sauvegardes à conserver


#On fabrique les variables systeme
#dte=$(date +"%Y-%m-%d--%H-%M-%S")
dte=$(date +"%A")
fic="$db/$db-$dte.sql"


#### SCRIPT ####

if [ -d $db ]
then
	echo "On sauvegarde dans $db"
else
	echo "On créé le dossier de sauvegarde $db"
	mkdir $db
fi

echo "On sauvegarde de la base $db dans $fic"
mysqldump -u $user -p$passwd $db > "$fic"

echo "On compresse $fic avec gzip : $fic.gz"
gzip -f "$fic"


#nbfic=$(ls -C1X "$db" | wc -l)
#diff=$(echo $(($nbfic-$nbsav)))

#echo "On calcule le nombre de fichiers à supprimer pour ne garder que les $nbsav derniers : $diff"

#i=1 #Compteur du for
#for f in $(ls -C1X "$db")
#do
#	if [ $i -le $diff ]	
#	then
#		oldsav="$db/$f"
#		echo "On supprime $db/$f"
#		rm -f "$db/$f"
#		let i++
#	else
#		echo "Aucune ancienne sauvegarde supprimée"
#		break;
#	fi
#done
