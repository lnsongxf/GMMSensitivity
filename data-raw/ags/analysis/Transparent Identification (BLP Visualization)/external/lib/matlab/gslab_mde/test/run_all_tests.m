function run_all_tests

addpath(genpath(fullfile(fileparts(pwd), 'external'))) 
addpath(genpath(fullfile(fileparts(pwd), 'depend'))) 
addpath(genpath(fullfile(fileparts(pwd), 'm'))) 

runxunit ../test 

exit
