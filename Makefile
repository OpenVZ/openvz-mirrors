CURRENT=/var/www/html/mirrors-current
MASTER=mirrors.masterlist

all: clean mirmon mirrorlist

mirmon:
	bin/masterlist2mirmon ${MASTER}
	mirmon -c etc/mirmon-stable.conf -get update
	mirmon -c etc/mirmon-unstable.conf -get update
	cp style.css /var/www/mirmon/

mirrorlist:
	cat mirrors-stable-mirmon | egrep -v '^.*rsync' | awk '{print $$2}' | while read m; do echo "$${m}current/"; done > ${CURRENT}
	bin/make-mirrors
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/releases/7.0/x86_64/os/ > /var/www/html/virtuozzo/mirrorlists/7.0/releases-os.mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/releases/7.0/x86_64/debug/ > /var/www/html/virtuozzo/mirrorlists/7.0/releases-debug.mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/updates/7.0/x86_64/os/ > /var/www/html/virtuozzo/mirrorlists/7.0/updates-os.mirrorlist
	bin/create_mirrorlist.py mirrors.masterlist virtuozzo/updates/7.0/x86_64/debug/ > /var/www/html/virtuozzo/mirrorlists/7.0/updates-debug.mirrorlist

clean:
	@-rm -f mirrors-stable-mirmon mirrors-unstable-mirmon
