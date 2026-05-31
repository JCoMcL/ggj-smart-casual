default: clean export/web_release.zip

export/web_release.zip: export/web/index.html
	zip --junk-paths -r $@ export/web/*

export/web/index.html:
	mkdir -p export/web
	godot --headless --export-release "Web" $@

export/windows/homeicide.exe:
	mkdir -p export/windows
	godot --headless --export-release "Windows Desktop" $@

export/linux:
	mkdir -p export
	godot --headless --export-release "Linux" $@

clean:
	rm -rf export/web export/windows export/linux
	rm -f export/web_release.zip

build: export/web/index.html
build-windows: export/windows/homeicide.exe
build-linux: export/linux

trim-whitespace:
	find -name '*.gd' | xargs sed -Ei 's/[ 	]+$$//'

downscale-textures:
	find Assets Levels -name '*.png' -exec mogrify -resize 6.25% {} +

.PHONY: clean build build-windows build-linux trim-whitespace downscale-textures
