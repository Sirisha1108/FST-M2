After login to container run below
mapred --daemon start historyserver
cd root/
ls
vim input.txt
vim activity2.pig

# Opens file01.txt in vim. Paste the text from above and save/exit.
$ vim /root/input.txt

# Copy the file into the HDFS
$ hdfs dfs -put /root/input.txt /user/sirishanolli

-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/sirishanolli/input.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE $0 AS word, COUNT($1) AS no_of_lines;
-- To remove the old output folder
rmf hdfs:///user/sirishanolli/results;
-- Store the result in HDFS
STORE cntd INTO 'hdfs:///user/sirishanolli/results';

$ pig /root/activity2.pig
$ hdfs dfs -cat /user/sirishanolli/results/part-r-00000


