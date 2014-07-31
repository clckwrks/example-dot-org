# This makefile just exists to fetch the javascript dependencies. The primary installation is done via cabal.

all: js/json2/json2.js js/jstree-master/dist/jstree.js js/jquery/jquery.js

js/json2/json2.js:
	mkdir -p js/json2
	wget https://raw.github.com/douglascrockford/JSON-js/master/json2.js -O js/json2/json2.js

js/jstree-master/dist/jstree.js:
	mkdir -p js
	wget https://github.com/vakata/jstree/archive/master.zip -O js/jstree-master.zip
	cd js ; unzip jstree-master.zip

js/jquery/jquery.js:
	mkdir -p js/jquery
	wget http://code.jquery.com/jquery-1.11.1.js -O js/jquery/jquery.js

.PHONY: all
