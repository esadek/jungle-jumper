alias fmt := format

love_filename := "junglejumper.love"

default:
    just --list

run:
    love src

format:
    stylua .

[working-directory("src")]
build:
    zip -9 -r {{love_filename}} .
    mv {{love_filename}} ..

build-web: build
    npx love.js -c -t 'Jungle Jumper' {{love_filename}} web
    rm -rf web/theme
    sed -i '' -e '8,10d' -e '15d' -e '22,35d' -e '107,109d' web/index.html
    sed -i '' -e 's/width="800"/width="600"/g' -e 's/height="600"/height="450"/g' web/index.html
    sed -i '' 's|<body>|<body style="margin:0px">|g' web/index.html
    zip -9 -r web.zip web
