function z = funcion_objetivo(C, X, r, b)
sumas=C.*X;
z=0;
M=1;
for i=1:5
    for j=1:15
       z=z+sumas(i,j);
    end
end

sumasrestr=r.*X;

%restriccion1
restr1=0;
for j=1:15
    restr1=restr1+sumasrestr(1,j);
end

if (restr1 <= b(1))dif1=0;
else dif1=restr1 - b(1);
end
%restriccion2
restr2=0;
for j=1:15
    restr2=restr2+sumasrestr(2,j);
end

if (restr2 <= b(2)) dif2=0;
else dif2=restr2 - b(2);
end

%restriccion3
restr3=0;
for j=1:15
    restr3=restr3+sumasrestr(3,j);
end

if (restr3 <= b(3)) dif3=0;
else dif3=restr3 - b(3);
end

%restriccion4
restr4=0;
for j=1:15
    restr4=restr4+sumasrestr(4,j);
end

if (restr4 <= b(4)) dif4=0;
else dif4=restr4 - b(4);
end

%restriccion5
restr5=0;
for j=1:15
    restr5=restr5+sumasrestr(5,j);
end

if (restr5 <= b(5)) dif5=0;
else dif5=restr5 - b(5);
end
disp([dif1,dif2,dif3,dif4,dif5])
z=z-M*dif1-M*dif2-M*dif3-M*dif4-M*dif5;

end

