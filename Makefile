CURRENT=/var/www/html/mirrors-current
MASTER=mirrors.masterlist

all: mirmon mirrorlist

mirmon:
	bin/masterlist2mirmon ${MASTER} > mirrors-current-mirmon

mirrorlist:
	bin/masterlist2mirmon ${MASTER} | egrep -v '^.*rsync' | awk '{print $$2}' | while read m; do echo "$${m}current/"; done > ${CURRENT}
	bin/masterlist2mirmon ${MASTER} | egrep -v '^.*rsync' | awk '{print $$2}' > mirrors-current
	bin/make-mirrors
