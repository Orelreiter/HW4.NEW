#!/bin/bash
wget  https://www.ynetnews.com/category/3082

# Shortlists the amount of articles to articles with 9 characters.
grep -o 'https://www.ynetnews.com/article/[a-zA-Z0-9]\{9,\}' 3082 > hw4.txt

#sort the articles and saves only one appearance of each link and also counts how many articles there are
grep -x '.\{42\}' hw4.txt > hw4updated.txt
cat hw4updated.txt | sort | uniq > hw4uniq.txt 

count=$(more hw4uniq.txt | wc -l)
echo $count >> results.csv
article_list=($(more hw4uniq.txt))

#Going over each unique article by a loop, searching for the needed mentions separately and counting each one separately into a sum. 


for (( i=0; i<$count;i++ ));
do
		
		wget -O tmp.txt ${article_list[i]} &> /dev/null
		mentions_of_netanyahu=$(more tmp.txt | grep  -o Netanyahu | wc -l)
		mentions_of_gantz=$(more tmp.txt | grep  -o Gantz | wc -l)
		
		if [[ $mentions_of_gantz == 0 && $mentions_of_netanyahu == 0 ]]; then
			echo "${article_list[i]},-" >> results.csv
		else
			echo "${article_list[i]}, Netanyahu, $mentions_of_netanyahu, Gantz, $mentions_of_gantz"  >> results.csv
		fi
	done
	
