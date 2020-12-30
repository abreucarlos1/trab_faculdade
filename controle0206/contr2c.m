clear all

%2a)
%z = [-1]
%p = [-2 -5]
%k = 10

%2b)
%z = [(-0.5-0.5i); (-0.5+0.5i)]
%p = [0; -1; -10]
%k = 20

%2c)
%z = [-2]
%p = [0; -1; (-4+6.9i); (-4-6.9i)]
%k = 320


%[z,p,k] = tf2zp(num,den)

%z = [0 -1]
%p = [-2 -5]
%k = [1300]
[num,den] = zp2tf(z,p,k)
tf(num,den)

figure
grid
bode(num,den)


figure
grid
rlocus(num,den)





