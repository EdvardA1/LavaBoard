f = open("test_map.txt", "w")

a = list(range(-4,5))
uniq_only = dict
value = 0 #lava timer, lägre ->tidigare lava.
for x in a:
	b = str(x)
	for j in a:
		if ( (abs(x)==4) or (abs(j)==4)):
			value = 100
		else:
			value = 1000
		b1 = str(j)
		f.write(b + "," + b1 + " " + str(value) + "\n")

f.close()
