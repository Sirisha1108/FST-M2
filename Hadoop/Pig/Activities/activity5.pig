-- Instead of this
inputFile = LOAD 'hdfs:///user/root/input.txt' AS (line);

-- Use this
inputFile = LOAD '/root/input.txt' AS (line);

-- Load the CSV file
salesTable = LOAD '/root/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- To remove the old output folder
rmf /root/salesOutput;
-- Save result in HDFS folder
STORE CountByCountry INTO '/root/salesOutput' USING PigStorage('\t');

$ pig -x local /root/activity5.pig

$ cat /root/salesOutput/part-r-00000