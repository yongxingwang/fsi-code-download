clear all;

FileName='obj.bb';

fid = fopen(FileName,'r');
datacell = textscan(fid, '%f%f%f', 'HeaderLines', 1);
fclose(fid);

o1=datacell{1,1};

y=o1./2;

n=size(y);

x=0:1:n(1)-1;
x=x';


plot(x,y/y(1),'o-b','LineWidth', 1.5,'MarkerSize', 5);

hold on;

%==========================
clear all;

FileName='obj.constant';

fid = fopen(FileName,'r');
datacell = textscan(fid, '%f%f%f', 'HeaderLines', 1);
fclose(fid);

o1=datacell{1,1};

y=o1./2;

n=size(y);

x=0:1:n(1)-1;
x=x';


plot(x,y/y(1),'*-r','LineWidth', 1.5,'MarkerSize', 5);

hold on;
%==========================

xlabel('Number of iterations','FontSize',16);
ylabel('J/J_0','FontSize',16);

legend('BB method',...
'constant \alpha=1');


set(gca, 'FontSize', 16)

grid on;

axh = gca;
set(axh,'LineWidth',2);

set(gcf, 'PaperType','a2');
