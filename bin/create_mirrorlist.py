#!/usr/bin/python

import os
import sys
import re

url_patterns = ["OVZ-http: "]
state_pattern = "State:"
state_enabled_pattern = "%s Enabled" % state_pattern

# Check for parameter
try:
    git_mirrors = sys.argv[1]
    repo = sys.argv[2]
except IndexError:
    sys.stderr.write("Usage: %s $mirrors.masterlist $path_to_repo\n" % sys.argv[0])
    sys.exit(1)

try:
    f = open(git_mirrors, 'r')
    data = f.readlines()
    f.close()
except:
    sys.stderr.write("Failed to proceed %s\n" % git_mirrors)
    sys.exit(1)

mirrorlist_urls = ["http://download.openvz.org/"]

check_state = False

for line in data:
    line = line.rstrip('\n')
    our_url = False
    for pattern in url_patterns:
        if not line.startswith(pattern):
            continue
        our_url = True
        break
    if check_state and line.startswith(state_pattern):
        if not line.startswith(state_enabled_pattern):
            del mirrorlist_urls[len(mirrorlist_urls)-1]
        check_state = False
    if not our_url:
        continue
    mirrorlist_urls.append("http://" + re.sub("^.*: ", "", line))
    check_state = True

for url in mirrorlist_urls:
    print url + repo

