?CCRRROOWWWW

4 3bit words = 12 bits


# registers
v0
v1
li
r1
p1
p2
p3
p4

takes 4 bit to represent

math ops - 2 bits

```
ADD
SUB
MAX
DIF
```


# writeout - 3 bit

Non
Acc
Ans
Reg


# ctrl

never
if carry
if not carry
always




OP 1
OP 2





r1 is index
r2 is current value

port1 is ram addr 1
port2 is ram data 1
port3 is ram addr 2
port4 is ram data 2


# assume that computer was just reset
# port 1 is set to start range
# port 3 is set to end range

```
//load the port 1
p2 max reg->acc 
// compare the registers
p4 sub acc->acc p3 co

// if co
p2 add 1 into acc
```

load the two values

