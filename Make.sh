#!/bin/sh
for f in *.rb; do
    ruby -c "$f"
done
