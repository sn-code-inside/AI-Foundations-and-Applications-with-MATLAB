
% convert an ITS FIS to a type-1 FIS
% Name: ConvT1FIS.m
% September 10, 2023

fisT2 = readfis('itype2_fis');
subplot(2, 1, 1);
plotmf(fisT2,"input",1);
grid;
fisT1 = convertToType1(fisT2);
t1_fis = writeFIS(fisT1, 'type1_fis');
subplot(2, 1, 2);
plotmf(fisT1,"input",1);
grid;
