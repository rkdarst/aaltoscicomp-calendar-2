ICS=$(wildcard calendars/*.yaml)
OUT=$(patsubst calendars/%.yaml,out/%.ics,$(ICS))

build: $(OUT)
	rm -f out/index.html
	echo "Available calendars:</br>" >> out/index.html
	files="$(shell cd out ; ls *.ics)" ; \
	for file in $${files}; do \
	    echo $${file} ; \
	    echo "<a href=\"$$file\">$$file</a></br>" >> out/index.html ; \
	done
	echo -n "<br>git revision $(shell git rev-parse --short HEAD), built at " >> out/index.html
	date >> out/index.html

out/%.ics: calendars/%.yaml
	mkdir -p out
	python3 yaml2ics/yaml2ics.py $< > $@


clean:
	rm -r out

install:
	pip install -r yaml2ics/requirements.txt
