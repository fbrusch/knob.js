BUILD: dist/knob.js index.html

clean:
	rm dist/knob.js index.html

dist/knob.js: knob.coffee
	coffee -bc -o dist knob.coffee

index.html: index.jade
	jade -P index.jade
