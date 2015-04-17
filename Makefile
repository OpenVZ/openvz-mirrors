CURRENT=/var/www/html/mirrors-current
MASTER=mirrors.masterlist

all: mirmon mirrorlist

mirmon:
	bin/masterlist2mirmon ${MASTER} > mirrors-current-mirmon

mirrorlist: mirmon
	bin/masterlist2mirmon ${MASTER} | egrep -v '^.*rsync' | awk '{print $$2}' > mirrors-current
	cp mirrors-current ${CURRENT}
	bin/make-mirrors
