CURRENT=/var/www/html/mirrors-current
MASTER=mirrors.masterlist

all: clean mirmon mirrorlist

mirmon:
	bin/masterlist2mirmon ${MASTER}
	mirmon -c etc/mirmon.conf -get update
	cp style.css /var/www/mirmon/

mirrorlist:
	bin/masterlist2mirmon ${MASTER} | egrep -v '^.*rsync' | awk '{print $$2}' | while read m; do echo "$${m}current/"; done > ${CURRENT}
	cat mirrors-stable-mirmon | egrep -v '^.*rsync' | awk '{print $$2}' > mirrors-current
	bin/make-mirrors
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/releases/7.0/x86_64/os/ > /var/www/html/virtuozzo/mirrorlists/7.0/releases-os.mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/releases/7.0/x86_64/debug/ > /var/www/html/virtuozzo/mirrorlists/7.0/releases-debug.mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/updates/7.0/x86_64/os/ > /var/www/html/virtuozzo/mirrorlists/7.0/updates-os.mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/updates/7.0/x86_64/debug/ > /var/www/html/virtuozzo/mirrorlists/7.0/updates-debug.mirrorlist

clean:
	@-rm mirrors-unstable-mirmon mirrors-unstable-mirmon
