figure()
xlim([0,15]);
ylim([-300,500]);
t=0:0.1:15; 
x= 15-t; 
y=(400*(power(1.4,t)/100)-100); 
plot(x, y);
xlabel('Time(sec)') 
ylabel('Cost') 