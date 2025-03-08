# Copy the contents of the file shown in the previous slide into this

$ vim /root/sales.csv

# Once the file is ready, put it in the HDFS

$ hdfs dfs -put /root/sales.csv /user/sirishanolli

-- Load the CSV file
salesTable = LOAD 'hdfs:///user/sirishanolli/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);

-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;

-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));

--To remove the old output folder
rmf hdfs:///user/sirishanolli/salesOutput;

-- Save result in HDFS folder
STORE CountByCountry INTO 'hdfs:///user/sirishanolli/salesOutput' USING PigStorage('\t');

$ pig /root/activity4.pig

#To view the result, you can use the cat command in the HDFS:
$ hdfs dfs -cat /user/root/salesOutput/part-r-00000
