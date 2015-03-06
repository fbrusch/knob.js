BUILD: dist/knob.js index.html template.html

TEST: test.html

clean:
	rm dist/knob.js index.html

template.html: template.jade
	jade -P template.jade

dist/knob.js: knob.coffee template.html
	coffee -bcp knob.coffee| browserify -t brfs -o dist/knob.js -

test.html: test.jade
	jade -P test.jade

index.html: index.jade
	jade -P index.jade

watch:
	nodemon --exec "make BUILD" -e "jade coffee"
