MASTER=mirrors.masterlist
WWWPATH=/var/www/html

all: clean mirmon mirrorlist

mirmon: clean
	bin/masterlist2mirmon ${MASTER}
	mirmon -c etc/mirmon-stable.conf -get update  2>&1 | tee mirmon-stable.log
	mirmon -c etc/mirmon-unstable.conf -get update  2>&1 | tee mirmon-unstable.log
	cp mirmon-stable.log mirmon-unstable.log style.css /var/www/mirmon/

mirrorlist:
	bin/create_mirrorlist.py ${MASTER} current/ > ${WWWPATH}/mirrors-current
	bin/create_mirrorlist.py ${MASTER} kernel/branches/rhel4-2.6.9 > ${WWWPATH}/kernel/mirrors-rhel4-2.6.9
	bin/create_mirrorlist.py ${MASTER} kernel/branches/rhel4-2.6.9 > ${WWWPATH}/kernel/mirrors-rhel4-2.6.9
	bin/create_mirrorlist.py ${MASTER} kernel/branches/rhel5-2.6.18 > ${WWWPATH}/kernel/mirrors-rhel5-2.6.18
	bin/create_mirrorlist.py ${MASTER} kernel/branches/rhel5-2.6.18-testing > ${WWWPATH}/kernel/mirrors-rhel5-2.6.18-testing
	bin/create_mirrorlist.py ${MASTER} kernel/branches/rhel6-2.6.32 > ${WWWPATH}/kernel/mirrors-rhel6-2.6.32
	bin/create_mirrorlist.py ${MASTER} kernel/branches/rhel6-2.6.32-testing > ${WWWPATH}/kernel/mirrors-rhel6-2.6.32-testing
	bin/create_mirrorlist.py ${MASTER} virtuozzo/releases/7.0/x86_64/os/ > ${WWWPATH}/virtuozzo/mirrorlists/7.0/releases-os.mirrorlist
	bin/create_mirrorlist.py ${MASTER} virtuozzo/releases/7.0/x86_64/debug/ > ${WWWPATH}/virtuozzo/mirrorlists/7.0/releases-debug.mirrorlist
	bin/create_mirrorlist.py ${MASTER} virtuozzo/updates/7.0/x86_64/os/ > ${WWWPATH}/virtuozzo/mirrorlists/7.0/updates-os.mirrorlist
	bin/create_mirrorlist.py ${MASTER} virtuozzo/updates/7.0/x86_64/debug/ > ${WWWPATH}/virtuozzo/mirrorlists/7.0/updates-debug.mirrorlist
	bin/create_mirrorlist.py ${MASTER} virtuozzo/factory/x86_64/os/ > ${WWWPATH}/virtuozzo/mirrorlists/7.0/factory-os.mirrorlist
	bin/create_mirrorlist.py ${MASTER} virtuozzo/factory/x86_64/debug/ > ${WWWPATH}/virtuozzo/mirrorlists/7.0/factory-debug.mirrorlist

clean:
	@-rm -f mirrors-stable-mirmon mirrors-unstable-mirmon
