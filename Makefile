build: export/web_release.zip export/homeicide_windows.zip export/homeicide_linux.zip

export/web/index.html:
	mkdir -p export/web
	godot --headless --export-release "Web" $@
export/web_release.zip: export/web/index.html
	zip --junk-paths -r $@ export/web/*

export/windows/homeicide.exe:
	mkdir -p export/windows
	godot --headless --export-release "Windows Desktop" $@
export/homeicide_windows.zip: export/windows/homeicide.exe
	zip --junk-paths -r $@ export/windows/*

export/linux/homeicide:
	mkdir -p export/linux
	godot --headless --export-release "Linux" $@
export/homeicide_linux.zip: export/linux/homeicide
	zip --junk-paths -r $@ export/linux/*


clean:
	rm -rf export/*


trim-whitespace:
	find -name '*.gd' | xargs sed -Ei 's/[ 	]+$$//'

downscale-textures:
	find Assets Levels -name '*.png' -exec mogrify -resize 6.25% {} +

.PHONY: clean build build-windows build-linux trim-whitespace downscale-textures
