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

%2d)
%z = [-1]
%p = [0; -5; (-1+3i); (-1-3i)]
%k = 20

num = [1]
den = [3 2]
[z,p,k] = tf2zp(num,den)

%2e)
%z = [-0.5]
%p = [0 -1 0]
%k = 1

%[num,den] = zp2tf(z,p,k)
%tf(num,den)

%figure
%grid
%bode(num,den)


%figure
%grid
%rlocus(num,den)





