Problem:

Find the following on a per symbol basis:
- Maximum time gap
  (time gap = Amount of time that passes between consecutive trades of a symbol)
  if only 1 trade is in the file then the gap is 0.
- Total Volume traded (Sum of the quantity for all trades in a symbol).
- Max Trade Price.
- Weighted Average Price.  Average price per unit traded not per trade.
  Result should be truncated to whole numbers.
  Example: the following trades
	20 shares of aaa @ 18
	5 shares of aaa @ 7
	Weighted Average Price = ((20 * 18) + (5 * 7)) / (20 + 5) = 15

Output:

Your solution should produce a file called 'output.csv'.

file should be a comma separate file with this format:
'<symbol>', <MaxTimeGap>,<Volume>,<WeightedAveragePrice>,<MaxPrice>
The output should be sorted by symbol ascending ('aaa' should be first).
Sample Input:
52924702314,aaa,13,1136
52924702549,aac,20,477

52925641407,aab,31,907
52927350412,aab,29,724
52927783980,aac,21,638
52930489178,aaa,18,1222
52931654404,aaa,9,1077
52933453444,aab,9,756

Sample Output:
aaa,5786864,40,1161,1222
aab,6103032,69,810,907
aac,3081431,41,559,638
