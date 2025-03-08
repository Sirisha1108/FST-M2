-- Instead of this
inputFile = LOAD 'hdfs:///user/sirishanolli/input.txt' AS (line);

-- Use this
inputFile = LOAD '/root/input.txt' AS (line);
-- Load input file from HDFS
inputFile = LOAD '/root/input.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE $0 AS word, COUNT($1) AS no_of_lines;
-- To remove the old output folder
rmf /root/PigOutput1;
-- Store the result in HDFS
STORE cntd INTO '/root/PigOutput1';

$ pig -x local /root/activity3.pig

#to view the results:
$ cat /root/results/part-r-00000