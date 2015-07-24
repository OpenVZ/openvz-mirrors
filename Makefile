CURRENT=/var/www/html/mirrors-current
MASTER=mirrors.masterlist

all: mirmon mirrorlist

mirmon:
	bin/masterlist2mirmon ${MASTER} > mirrors-current-mirmon
	mirmon -c etc/mirmon.conf -get update

mirrorlist:
	bin/masterlist2mirmon ${MASTER} | egrep -v '^.*rsync' | awk '{print $$2}' | while read m; do echo "$${m}current/"; done > ${CURRENT}
	bin/masterlist2mirmon ${MASTER} | egrep -v '^.*rsync' | awk '{print $$2}' > mirrors-current
	bin/make-mirrors
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/releases/7.0/x86_64/os/ > /var/www/html/virtuozzo/releases/7.0/x86_64/os/mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/releases/7.0/x86_64/debug/ > /var/www/html/virtuozzo/releases/7.0/x86_64/debug/mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/updates/7.0/x86_64/os/ > /var/www/html/virtuozzo/updates/7.0/x86_64/os/mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/updates/7.0/x86_64/debug/ > /var/www/html/virtuozzo/updates/7.0/x86_64/debug/mirrorlist
