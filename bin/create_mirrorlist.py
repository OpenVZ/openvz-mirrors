#!/usr/bin/python

import os
import sys
import re

url_patterns = ["OVZ-http: "]

# Check for parameter
try:
    git_mirrors = sys.argv[1]
    repo = sys.argv[2]
except IndexError:
    sys.stderr.write("Usage: %s %mirrors.masterlist %path_to_repo\n" % sys.argv[0])
    sys.exit(1)

try:
    f = open(git_mirrors, 'r')
    data = f.readlines()
    f.close()
except:
    sys.stderr.write("Failed to proceed %s\n" % git_mirrors)
    sys.exit(1)

mirrorlist_urls = ["http://download.openvz.org/"]

for line in data:
    line = line.rstrip('\n')
    our_url = False
    for pattern in url_patterns:
        if not line.startswith(pattern):
            continue
        our_url = True
        break
    if not our_url:
        continue
    mirrorlist_urls.append("http://" + re.sub("^.*: ", "", line))

for url in mirrorlist_urls:
    print url + repo

