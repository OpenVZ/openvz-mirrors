Monitoring of OpenVZ mirrors
============================

This Git repository provides the information and configuration
used by the [OpenVZ](https://openvz.org/) project and
its mirror infrastructure.

If you want to provide an OpenVZ mirror you should setup it according to
[steps](https://openvz.org/Setting_up_a_mirror) described in OpenVZ wiki.
Your mirror site should make the contents of this directory available
via HTTP, FTP or rsync protocols.

The status of OpenVZ mirror infrastructure can be checked at
[mirrors.openvz.org](http://mirrors.openvz.org/).

## How to setup:

- install mirmon package: ```yum install -y mirmon```
- checkout this source repository
- setup regular execution via crontab:

```
# crontab -l

MAILTO=""

00 * * * *     $(/bin/date +\%s > /var/www/html/timestamp)
00 * * * *     cd /home/sergeyb/ovz/; git pull && make
```
- touch stable-state unstable-state

Thanks for your interest and help in providing an OpenVZ mirror!

## Software to monitor the status of mirrors

* [MirMon](http://www.staff.science.uu.nl/~penni101/mirmon/) ([demo](http://spacehopper.org/mirmon/))
* [Mirror manager](https://fedorahosted.org/mirrormanager/) ([demo](https://admin.fedoraproject.org/mirrormanager/))
* [Debian Mirror Checker](https://github.com/rgeissert/ftpsync/blob/master/mirrorcheck/bin/dmc.pl) ([demo](http://mirror.debian.org/status.html))
* [MirrorBrain](http://mirrorbrain.org/)
* [Arch Linux](https://www.archlinux.org/mirrors/)
