#!/bin/bash

grep --color -Pri \
  '(/|2F)?\K([\w\.\-_]+)\.(amazonaws\.com|digitaloceanspaces\.com|blob\.core\.windows\.net)(/|%2F)?([\w\.\-_]+)?' out/
