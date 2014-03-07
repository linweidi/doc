#!/usr/usc/bin/python
import os
cmd1 = 'make clean'
#os.system(cmd1)
cmd2 = 'make sim'
#os.system(cmd2)
fileIngolden=open('Result_golden','r')
fileInress=open('Result','r')
fileOut=open('Report.txt','w')
I=1;
count=0
for aLine in fileIngolden :
	var=fileInress.readline()
	if(var != aLine) :
		fileOut.write('At location %i, the data mismatch!\n' %(I))
		fileOut.write('The expected data is: %s, the actual data is: %s\n' %(aLine,var))
		count = count + 1
	I=I+1
if(count==0) :
	fileOut.write('Congratulations! Your design has passed the test successfully.')
else :
	fileOut.write('Test fails. The total number of mismatches is %i' %(count))
fileIngolden.close()
fileInress.close()
fileOut.close()
