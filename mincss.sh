#!/bin/bash
#: Title       : mincss
#: Date        : 2015-11-22
#: Author      : "Ezequiel S. Pereira" <ezequielsp@hotmail.com.br>
#: Version     : 1.0
#: Description : Call the closure stylesheets to minify css. 
#: Options     : None

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.
CLOSURE_COMPILER=/usr/local/jar/closure-stylesheets-20111230.jar

# Initialize our own variables:
output_file=""

USAGE="Usage: mincss -o myfile file1.css file2.css file3.css ... fileN.css"

if [ "$#" -eq 0 ]; then
	echo "$USAGE"
	exit 1
fi

while getopts "o:" opt; do
    case "$opt" in
      o) output_file=$OPTARG ;;
    esac
done
shift $((OPTIND-1))

[ "$1" = "--" ] && shift
for i in $@; 
  do 
    if [ ! -f $i ] 
    	then  
		echo "Input file $i does not exist"
		exit 1;
	fi
done;

mincssFilePath="$output_file.min.css"
if [ "$#" -gt 0 ]
	then
	java -jar $CLOSURE_COMPILER $@ > $mincssFilePath
	echo "$@  minified. Now located at $mincssFilePath"
fi