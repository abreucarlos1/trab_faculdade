clear all

z = [(-0.5-0.5i);(-0.5+0.5i)]
p = [0; -1; -10]
k = 20
%[z,p,k] = tf2zp(num,den)

%z = [0 -1]
%p = [-2 -5]
%k = [1300]
[num,den] = zp2tf(z,p,k)


figure
grid
bode(num,den)


figure
grid
rlocus(num,den)





