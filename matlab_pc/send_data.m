s=Ini_Serial();
fscanf(s);
for i=1:90%length(L1der)/2000
for k=1:400
index=k+(i-1)*400;
data1 = prepare_data(L1der(index),L1derDC(index),L2der(index),L2derDC(index));
data2 = prepare_data(L1izq(index),L1izqDC(index),L2izq(index),L2izqDC(index));
data= strcat(data1,data2);
fprintf(s,data);
end


a = fscanf(s);

recdata= strsplit(a,',');
ACL1(i)=str2double(recdata(2));
DCL1(i)=str2double(recdata(3));
ACL2(i)=str2double(recdata(4));
DCL2(i)=str2double(recdata(5));

ACL1iz(i)=str2double(recdata(6));
DCL1iz(i)=str2double(recdata(7));
ACL2iz(i)=str2double(recdata(8));
DCL2iz(i)=str2double(recdata(9));


end
%% 
r_der=(ACL1.*DCL2)./(ACL2.*DCL1);
r_izq=(ACL1iz.*DCL2iz)./(ACL2iz.*DCL1iz);
t=2
x=1:t:length(ACL1)*2;

subplot(4,1,1);
plot(x,ACL1)
title('Valor amplitud AC Longitud 1 hemisferio derecho');
xlim([2 length(ACL1)*t])

subplot(4,1,2);
plot(x,DCL1)
title('Valor amplitud DC Longitud 1 hemisferio derecho');
ylim([500 700])
xlim([2 length(ACL1)*t])

subplot(4,1,3);
plot(x,ACL2)
title('Valor amplitud AC Longitud 2 hemisferio derecho');
xlim([2 length(ACL1)*t])

subplot(4,1,4);
plot(x,DCL2)
title('Valor amplitud DC Longitud 2 hemisferio derecho');
xlabel('Time (S)')
ylim([500 700])
xlim([2 length(ACL1)*t])


figure(2)
subplot(2,1,1);
plot(x,r_der)
title('Valor de R hemisferio Derecho');
xlim([2 length(ACL1)*t])

subplot(2,1,2);
plot(x,r_izq)
title('Valor de R hemisferio Izquierdo');
xlim([2 length(ACL1)*t])
xlabel('Time (S)')

figure(3)
subplot(4,1,1);
plot(x,ACL1iz)
title('Valor amplitud AC Longitud 1 hemisferio Izquierdo');
xlim([2 length(ACL1)*t])


subplot(4,1,2);
 plot(x,DCL1iz)
 title('Valor amplitud DC Longitud 1 hemisferio Izquierdo');
ylim([100 700])
xlim([2 length(ACL1)*t])

subplot(4,1,3);
plot(x,ACL1iz)
title('Valor amplitud AC Longitud 2 hemisferio Izquierdo');
xlabel([2 length(ACL1)*t])

subplot(4,1,4);
plot(x,DCL2iz)
title('Valor amplitud DC Longitud 2 hemisferio Izquierdo');
ylim([500 700])
xlim([2 length(ACL1)*t])
xlabel('Time (s)')

fclose(s);

function data = prepare_data(L1der,L2der,L1izq,L2izq)
%convertir a Str
   strL1der = int2str(L1der);
   strL2der = int2str(L2der);
   strL1izq = int2str(L1izq);
   strL2izq = int2str(L2izq);
  % agregar cero si es neceario
  strAdd = 4 - strlength(strL1der);  %%L1der
  for j=1:strAdd                       
    strL1der = strcat('0',strL1der);
  end
    strAdd = 4 - strlength(strL2der); %% L2der
  for j=1:strAdd 
    strL2der = strcat('0',strL2der);
  end
      strAdd = 4 - strlength(strL1izq); %%L1izq
  for j=1:strAdd 
    strL1izq = strcat('0',strL1izq);
  end
      strAdd = 4 - strlength(strL2izq); %% L2izq
  for j=1:strAdd 
    strL2izq = strcat('0',strL2izq);
  end
  data = strcat(strL1der,',',strL2der,',',strL1izq,',',strL2izq,',');
end

function s = Ini_Serial()
delete(instrfind)
s = serial('COM3','BaudRate',2000000, 'DataBits', 8);
fopen(s);
end