function lab_one_A (a, b, select)
if nargin == 2
    select='sum';
end
    
x=hex2dec(a);
y=hex2dec(b);
if (strcmp (select, 'sum'))
       s=x+y;
elseif (strcmp (select, 'sub'))
           s= x-y;
       else disp(['wrong input'])
           s=0;
end 

disp(['Res dec:' num2str(s)]);
disp(['Res HEX:' dec2hex(s)]);
end


