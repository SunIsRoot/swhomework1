#!/bin/bash

echo " User Name: Lee Heesun"
echo " Student Number: 12211672"
echo " [ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the ‘IMDb URL’ from ‘u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"
while true
do
read -p "Enter your choice [ 1-9 ] " number
if [ "$number" = "1" ]
then read -p "Please enter 'movie id'(1~1682): " id
     cat u.item | awk -F\| -v this="$id" ' $1==this {print $0}'
elif [ "$number" = "2" ]
then read -p "Do you want to get the data of ‘action’ genre movies from ' u.item ’?(y/n) : " ans
case $ans in
y)
     cat u.item | sort -k 1 -g | awk -F\| ' $7==1 {print $1, $2}' | head -n 10 ;;
n)
echo "okay bye..";;
*)
echo "입력 양식이 틀렸습니다. 다시 처음 메뉴선택창으로 돌아갑니다.";;
esac

elif [ "$number" = "3" ]
then read -p "Please enter the 'movie id’(1~1682): " id
cat u.data | awk -v count=0 -v sum=0 -v this="$id" 'this==$2 {sum += $3; count++;} END{OFMT="%6.5f";print "average rating of " this" : " sum/count}'

elif [ "$number" = "4" ]
then read -p "Do you want to delete the IMDb URL’ from ‘ u.item ’?(y/n) : " ans
case $ans in
y)
     cat u.item | sed 's/h[^)]*)//g' | head -n 10;;
n)
echo "okay bye..";;
*)
echo "입력 양식이 틀렸습니다. 다시 처음 메뉴선택창으로 돌아갑니다.";;
esac

elif [ "$number" = "5" ]
then read -p "Do you want to get the data about users from ‘u.user’?(y/n) : " ans
case $ans in
y)
     cat u.user |sed 's/M/male/g;s/F/female/g;'| awk -F\|  '{print "user "$1" is "$2" years old " $3, $4 }' | head -n 10 ;;
n)
echo "okay bye..";;
*)
echo "입력 양식이 틀렸습니다. 다시 처음 메뉴선택창으로 돌아갑니다.";;
esac

elif [ "$number" = "6" ]
then read -p "Do you want to Modify the format of ‘release data’ in ‘ u.item ’?(y/n) : " ans
case $ans in
y)
	cat u.item |sed 's/Jan/01/g;s/Feb/02/g;s/Mar/03/g;s/Apr/04/g;s/May/05/g;s/Jun/06/g;s/Jul/07/g;s/Aug/08/g;s/Sep/09/g;s/Oct/10/g;s/Nov/11/g;s/Dec/12/g' | sed -E 's/([0-9]+)(-)([0-9]+)(-)([0-9]+)/\5\3\1/' | tail -n 10 ;;
n)
echo "okay bye..";;
*)
echo "입력 양식이 틀렸습니다. 다시 처음 메뉴선택창으로 돌아갑니다.";;
esac

elif [ "$number" = "7" ]
then read -p "Please enter the ‘user id’(1~943): " id
result=$(sort u.data -k 2 -g | awk -v this="$id" 'this==$1 {printf $2"|"}' )

printf "$result\n";

for i in $(seq 1 10)
do
	rs=$(echo $result | awk -F\| -v idx="$i" '{printf $(idx)}')
	cat u.item | awk -F\| -v res="$rs" '$1==res{print $1"|" $2}'
done

elif [ "$number" = "8" ]
then read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n) : " ans
case $ans in
y)
     cat u.user |sed 's/M/male/g;s/F/female/g;'| awk -F\|  '{print "user "$1" is "$2" years old " $3, $4 }' | head -n 10 ;;
n)
echo "okay bye..";;
*)
echo "입력 양식이 틀렸습니다. 다시 처음 메뉴선택창으로 돌아갑니다.";;
esac

elif [ "$number" = "9" ]
then printf "Bye!\n"
break;

fi
done

