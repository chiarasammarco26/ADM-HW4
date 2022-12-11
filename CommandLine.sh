 #!/bin/bash

#1) Which location has the maximum number of purchases been made?

awk 'BEGIN{
        FS="," #fields delimiter
        count=0 }
{
        sum[$5]++
        if (sum[$5]>count){
                count=sum[$5]
                max=$5 }
}
END{print "The location with the highest number of purchases is:",max, "with",count,"transactions"}' bank_transactions.csv

#2) In the dataset provided, did females spend more than males, or vice versa?

#First of all we extract all the purchases made respectively by females and males from the "TransactionAmount"
#column and save these two subsets in two different csv files
grep "F" bank_transactions.csv|cut -d, -f9 >F_TransactionAmount.csv
grep "M" bank_transactions.csv|cut -d, -f9 >M_TransactionAmount.csv

# we save the total amount of purchases for females and males in two variables
Female=$(awk '{Tot=Tot+$1} END{print Tot}' F_TransactionAmount.csv)
Male=$(awk '{Total=Total+$1} END{print Total}' M_TransactionAmount.csv)

echo "Total amount transactions of females: " $Female
echo "Total amount transactions of males: " $Male
# note that both results are represented in their scientific notation 

r=$(awk 'BEGIN{print ('$Male'>'$Female')?1:0}') # if Male > Female r=1 | else r=0

if [ $r -eq 1 ]
then
        echo "males spend more than females"
else
        echo "females spend more than males"
fi

#3) Report the customer with the highest average transaction amount in the dataset.

awk -F, 'BEGIN { FS="," } 
{
	if(NR>1){
		a[$2]= a[$2] + $9; count[$2]++} 
END{
	for(i in a){
		a[i]=a[i]/count[i]} 
	asort(a, asorted); 
	for(i in a) {
		if(a[i] == asorted[length(asorted)]) 
			print "customer with the highest average transaction amount:", i, "with", a[i]} 
}' bank_transactions.csv


