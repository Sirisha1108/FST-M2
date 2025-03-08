vim PigProjectActivity1

- Load the CSV file
dialogues = LOAD '/root/inputs' USING PigStorage('\t') AS (names:chararray, dialogues:chararray);
-- Group data using the country column
GroupByDialogues = GROUP dialogues BY names;
-- Generate result format
CountByNames = FOREACH GroupByDialogues GENERATE $0 AS names, COUNT($1) AS no_of_dialogues;
OrderByNames = ORDER CountByNames BY no_of_dialogues DESC;
-- To remove the old output folder
rmf /root/PigProjectOutput;
-- Save result in root folder
STORE OrderByNames INTO '/root/PigProjectOutput' USING PigStorage('\t');