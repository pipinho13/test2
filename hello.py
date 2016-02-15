def computepay(h,r):
   if h<=40:
       result=h*r
   elif h>40:
       result=40*r+(h-40)*r*1.5
   return result

hrs = raw_input("Enter Hours:")
rate = raw_input("Rate:")
h=float(hrs)
r=float(rate)
p = computepay(h,r)
print p


text = "X-DSPAM-Confidence:    0.8475"
pos=text.find('0')
text[pos:]
largest = None
smallest = None
while True:
    num = raw_input("Enter a number: ")
    if num == "done" : break
    try:
        number=int(num)
	
        
    except:
        print "Invalid input"
    if largest is None or number>largest:
       largest=number
    if smallest is None or number<smallest:
       smallest=number

print "Maximum is", largest
print "Minimum is", smallest




####Assigment 7.1
# Use words.txt as the file name
fname = raw_input("Enter file name: ")
fh = open(fname)
for line in fh:
   line=line.rstrip()
   line=line.upper()
   print line 
   
   
####Assigment 7.2

# Use the file name mbox-short.txt as the file name
fname = raw_input("Enter file name: ")
fh = open(fname)
count=0
word=0
for line in fh:
    if not line.startswith("X-DSPAM-Confidence:") : continue
    startpos=line.find(':')  
    endpos=line.find('\n')
    word=word+float(line[startpos+1:endpos])
    count=count+1
    average=word/count
    
print "Average spam confidence:", average



###Assigment 8.1
fname = raw_input("Enter file name: ")
fh = open(fname)
lst = list()
for line in fh:
    line.rstrip()
    words=line.split()
    lst.extend(words)
    
output=list(set(lst))
output.sort()
print output


#### b tropos

fname = raw_input("Enter file name: ")
fh = open(fname)
lst = list()
lst2 = list()
lstsecond=list()
for line in fh:
    line.rstrip()
    words=line.split()
    lst.extend(words)
   


for words in lst:
    if words not in lst2:
        lst2.append(words)

print sorted(lst2)







####8.2

fname = raw_input("Enter file name: ")
if len(fname) < 1 : fname = "mbox-short.txt"
count = 0
fh = open(fname)
for line in fh:
    line=line.rstrip()
    if line=='': continue
    words=line.split()
    if words[0]!='From': continue
    count=count+1    
    print words[1]
    


print "There were", count, "lines in the file with From as the first word"





#### 9.4
9.4 Write a program to read through the mbox-short.txt and figure out who has the sent the greatest number of mail messages. The program looks for 'From ' lines and takes the second word of those lines as the person who sent the mail. The program creates a Python dictionary that maps the sender's mail address to a count of the number of times they appear in the file. After the dictionary is produced, the program reads through the dictionary using a maximum loop to find the most prolific committer.
name = raw_input("Enter file:")
if len(name) < 1 : name = "mbox-short.txt"
handle = open(name)
lst=list()
for line in handle:
    line=line.rstrip()
    if line=='': continue
    words=line.split()
    if words[0]!='From': continue
    lst.append(words[1])

cou=dict()
for wrd in lst:
    cou[wrd]=cou.get(wrd,0)+1

maxval=None
maxkee=None
for kee,val in cou.items():
    if maxval==None or maxval<val:
       maxval=val
       maxkee=kee
      
print maxkee, maxval
    



	
####10.2 Write a program to read through the mbox-short.txt and figure out the distribution by hour of the day for each of the messages. You can pull the hour out from the 'From ' line by finding the time and then splitting the string a second time using a colon.	

name = raw_input("Enter file:")
if len(name) < 1 : name = "mbox-short.txt"
handle = open(name)
lst=list()
for line in handle:
    line=line.rstrip()
    if line=='': continue
    words=line.split()
    if words[0]!='From': continue
    lst.append(words[5])
lst2=list()
for time in lst:
    hours=time.split(":")
    lst2.append(hours[0])
counts=dict()
for hours in lst2:
    counts[hours]=counts.get(hours,0)+1
lst3=list()
for key, val in counts.items():
    lst3.append((key, val))

lst3.sort()
for key, val in lst3:
    print key, val

        




###11.1 calculate the same of the numbers within a text
import re
hand = open ('regex_sum_236287.txt')
stufflist=list()
numlist=list()
for line in hand:
    line = line.rstrip()
    stuff=re.findall('[0-9]+', line)
    if len(stuff)>=1:
        for number in stuff:
            num=float(number)
            numlist.append(num)
print sum(numlist)



		
####asheta		
		
import re
s = 'Hello from csev@umich.edu to cwen@iupui.edu about the meeting @2PM'
lst = re.findall('\S+@\S+', s)
print lst;



import re
hand = open('mbox-short.txt')
for line in hand:
    line = line.rstrip()
    x = re.findall('\S+@\S+, line)
    if len(x) > 0:
    print x
