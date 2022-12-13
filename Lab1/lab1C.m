function y=lab1C(N)
x=1;
for i=1 : N
    y=1+1/x;
    x=y;
    fi=(1+sqrt(5))/2 -x;
    disp (['Fi=' num2str(fi)]);
    A(i)=fi;
end
plot(A)
disp([num2str(y)]);
