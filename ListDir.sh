#!/bin/bash
preStr="\providecommand{\main}"
make_path () { # $1 is dir $2 is level
	if [ $2 -eq 0 ]
	then
		curPath="."
	else
		curPath=".."
		if [ $2 -gt 1 ]
		then
			cnt=$2
			until [ $cnt -eq 1 ]
			do
				curPath="${curPath}/.."
				((cnt--))
			done
		fi
	fi
	filePath="${1}/.path.tex"
	echo "% in dir ${1}" > ${filePath}
	echo "${preStr}{${curPath}}" >> ${filePath}
	for u in "${1}/"*
	do
		if [ -d ${u} ]
		then
			make_path ${u} $(( $2 + 1 ))
		fi
	done
}
make_path "." 0
