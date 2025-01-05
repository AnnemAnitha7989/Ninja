#!/bin/bash
set -x
#read action
#read path
#read dirnamecase $1 in
addDir)
	if [[ ! -e $3 ]];
	then
	mkdir -p $2/$3
	echo "create your dir successfully."
	else
	echo "$3 already exist"
	fi
	;;
deleteDir)
	rmdir  $2/$3
	echo "delete successfully"
	;;
listFiles)
	ls -al $2 | grep "^-"
	echo "get all list of files"
	;;
listDirs)
	ls -al $2 | grep "^d"
	echo "get all list of directories"
	;;
listAll)
	ls -al $2
        echo "get all"
        ;;
addFile)
		if [[ ! -e  $2/$3 ]];
		then
			touch $2/$3
			echo "create file successfully"
		else
			echo $4 >>  $2/$3
			echo "add first line of content"
		fi
	;;
addContentToFile)
			echo -e "$4" >> $2/$3
        		echo "added additional content"
			;;
addContentToFileBeginning)
			echo -e "$4\n$(<$2/$3)" > $2/$3
                        echo "add content on beginning"
                        ;;
showFileBeginningContent)
			head -n $4 $2/$3
			echo "top 5 lines"
			;;
showFileEndContent)
			tail -n $4 $2/$3
			echo "tail 5 lines"
			;;
showFileContentAtLine)
			head -n $4 $2/$3 | tail -n $5
			echo "only one line"
			;;
showFileContentForLineRange)
			head -n $4 $2/$3 | tail -n $5
			echo "between lines"
			;;
moveFile)
			if [[ ! -e $3 ]];
			then
			mv $2 $3
			echo "move file1 in same location with different name"
			else
			mv $2 $3
                        echo "move file2 into directory2 folder"
			fi
                        ;;
copyFile)
			if [[ ! -e $3 ]];
                        then
                        cp $2 $3
                        echo "copy file2 in same location but with different name"
                        else
                        cp $2 $3
                        echo "copy file2 in different location with same  name"
                        fi
                        ;;
clearFileContent)
			> $2/$3
			echo "clear content in the file"
			;;deleteFile)
			rm -r $2/$3
			echo "File deleted"
			;;
*)
	echo "your action is wrong"
	;;
esac
