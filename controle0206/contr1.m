clear all



z = [0 -1]
p = [-2 -5]
k = [1300]
[num,den] = zp2tf(z,p,k)


figure
grid
bode(num,den)


figure
grid
rlocus(num,den)





