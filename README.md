Mirror setup for openvz.org
=========================

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

```
# cronrab -l

MAILTO=""

*/5 * * * *     $(/bin/date +\%s > /var/www/html/timestamp)
*/5 * * * *     cd /home/sergeyb/ovz/; git pull && make mirmon && mirmon -c etc/mirmon.conf -get update
*/5 * * * *     cd /home/sergeyb/ovz/; git pull && make mirrorlist
```

Thanks for your interest and help in providing an OpenVZ mirror!

## Software to monitor the status of mirrors

* [MirMon](http://www.staff.science.uu.nl/~penni101/mirmon/) ([demo](http://spacehopper.org/mirmon/))
* [Mirror manager](https://fedorahosted.org/mirrormanager/) ([demo](https://admin.fedoraproject.org/mirrormanager/))
* [Debian Mirror Checker](https://github.com/rgeissert/ftpsync/blob/master/mirrorcheck/bin/dmc.pl) ([demo](http://mirror.debian.org/status.html))
