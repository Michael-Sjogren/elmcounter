build:css
	elm make src/Main.elm --output main.js --optimize
	bun run uglifyjs  main.js --mangle --compress  > main.min.js

css:
	tailwind -i input.css -o style.css --minify

watch:
	find src/*.elm | entr make build