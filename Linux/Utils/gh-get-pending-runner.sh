#!/bin/bash
for row in $(gh repo list PasseiDireto -L 850 --json name -q '.[] | .name'); do
    gh run list -R PasseiDireto/${row} --json url,name,status,createdAt,startedAt,updatedAt -q '.[] | select(.status=="queued") | .url' >>pending_wfs.txt
done
