build:css
	elm-format src/*.elm --yes
	elm make src/Main.elm --output main.min.js --debug # --optimize
	#bun run uglifyjs  main.js --mangle --compress  > main.min.js

css:
	tailwind -i input.css -o style.css --minify

watch:
	find src/*.elm | entr make build