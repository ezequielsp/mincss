#!/bin/bash
# Call the closure compiler to minify css. 
# Takes a filename mycss.x.y.css and outputs mycss.x.y.min.css, a minified version.

# The location of the closure compiler jar. You'll probably need to edit this.
CLOSURE_COMPILER=/usr/local/jar/closure-stylesheets-20111230.jar

case "$1" in
""|"-h"|"--help")
    echo "Usage: mincss path/to/css/file.css"
    exit 1;
    ;;
esac

cssDir=`dirname $1`
cssFile=`basename $1`

# There's no way to get "from the beginning to the Nth to last field" when
# specifying a range via cut, but we can get "from the Nth field to the end".
# By reversing the string, cutting, and reversing back, we get the desired
# effect. The following gets myfile.min.css from myfile.css
mincssFile=`echo $cssFile | rev | cut -d"." -f2- | rev`.min.css

cssFilePath=$cssDir/$cssFile
mincssFilePath=$cssDir/$mincssFile

java -jar $CLOSURE_COMPILER $cssFilePath > $mincssFilePath
echo "$cssFilePath minified. Now located at $mincssFilePath"