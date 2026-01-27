
% Name: IT2_Func.fis
% Build an IT2 FIS with Fuzzy Inference Functions
% Y. Bai
% Sept 7, 2023

% generate a new IT2 FIS
fis = mamfistype2("Name", "IT2_Func");
fis = addInput(fis,[-0.3 0.3],"Name","ex");
fis = addInput(fis,[-0.15 0.15],"Name","dex");
fis = addOutput(fis,[-600 600],"Name","yit2");

% add 5 MFs to input variable ex
fis = addMF(fis,"ex","sigmf",[-83.624 -0.206597],"Name","LN");
fis = addMF(fis,"ex","gaussmf",[0.0332566 -0.107229],"Name","SN");
fis = addMF(fis,"ex","gaussmf",[0.0424661 -0.00361446],"Name","ZE"); 
fis = addMF(fis,"ex","gaussmf",[0.0342799 0.1084340],"Name","SP"); 
fis = addMF(fis,"ex","sigmf",[106.227 0.23428],"Name","LP",'LowerScale',1,'LowerLag',0.2);

% plot 5 MFs for the first input variable ex
subplot(3,1,1);
plotmf(fis,"input",1);
grid;

% add 5 MFs to input variable dex
fis = addMF(fis,"dex","sigmf",[-139.311 -0.0935896],"Name","LN");
fis = addMF(fis,"dex","gaussmf",[0.0181632 -0.0487952],"Name","SN");
fis = addMF(fis,"dex","gaussmf",[0.0171399 5.204e-18],"Name","ZE"); 
fis = addMF(fis,"dex","gaussmf",[0.0166283 0.0542169],"Name","SP"); 
fis = addMF(fis,"dex","sigmf",[170.957 0.103014],"Name","LP",'LowerScale',1,'LowerLag',0.2);

% add 5 MFs to output variable yit2
fis = addMF(fis,"yit2","sigmf",[-0.0409668 -360.132],"Name","LN");
fis = addMF(fis,"yit2","gaussmf",[64.0868 -199.594],"Name","SN");
fis = addMF(fis,"yit2","gaussmf",[61.5948 0.5],"Name","ZE"); 
fis = addMF(fis,"yit2","gaussmf",[66.1541 221.501],"Name","SP"); 
fis = addMF(fis,"yit2","sigmf",[0.0642328 410.019],"Name","LP",'LowerScale',1,'LowerLag',0.2);

subplot(3,1,2);
plotmf(fis,"input",2);
grid;

subplot(3,1,3);
plotmf(fis,"output",1);
grid;

Rulelist = [   1      5      3       1      1;    1      4      2       1      1;    1      3      1       1      1;     1      2      1       1      1;
                      1      1      1       1      1;    2      5      4       1      1;    2      4      3       1      1;     2      3      2       1      1;
                      2      2      2       1      1;    2      1      1       1      1;    3      5      5       1      1;     3      4      4       1      1;
  		              3      3      3       1      1 ;   3      2      2       1      1;    3      1      2       1      1;     4      5      5       1      1;
                      4      4      5       1      1;    4      3      4       1      1;    4      2      3       1      1;     4      1      2       1      1;
                      5      5      5       1      1;    5      4      5       1      1;    5      3      5       1      1;     5      2      4       1      1;
                      5      1      3       1      1];

fis = addRule(fis, Rulelist);
it2_fis = writeFIS(fis, 'itype2_fis');

% display the surface of ou FIS
it_fis = readfis('itype2_fis');
subplot(1,1,1);
gensurf(it_fis);

% END



