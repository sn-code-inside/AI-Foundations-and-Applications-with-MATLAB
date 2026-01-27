
% Name: AC_Func.m
% Func: Build a FIS for an AC system with MATLAB Functions
% Date: August 24, 2023

acfis = mamfis("Name", "acfis");
acfis = addInput(acfis,[30 90],"Name","Temp");
acfis = addInput(acfis,[0 5],"Name","Temp_Rate");
acfis = addOutput(acfis,[100 1000],"Name","Motor_Speed");
% add 3 MFs to input variable Temp
acfis = addMF(acfis,"Temp","gbellmf",[12.5 2.5 30],"Name","LOW");
acfis = addMF(acfis,"Temp","gaussmf",[10.62 60],"Name","MID");
acfis = addMF(acfis,"Temp","gbellmf",[12.5 2.5 90],"Name","HIGH");
subplot(3,1,1);
plotmf(acfis,"input",1);
% add 3 MFs to input variable Temp_Rate
acfis = addMF(acfis,"Temp_Rate","gbellmf",[1.042 2.5 2.776e-17],"Name","LOW");
acfis = addMF(acfis,"Temp_Rate","gaussmf",[0.8847 2.5],"Name","MID");
acfis = addMF(acfis,"Temp_Rate","gbellmf",[1.042 2.5 5],"Name","HIGH");
subplot(3,1,2);
plotmf(acfis,"input",2);
% add 3 MFs to output variable Motor_Speed
acfis = addMF(acfis,"Motor_Speed","gbellmf",[187.5 2.5 100],"Name","SLOW");
acfis = addMF(acfis,"Motor_Speed","gaussmf",[159.2 550],"Name","MID");
acfis = addMF(acfis,"Motor_Speed","gbellmf",[187.5 2.5 1000],"Name","FAST");
subplot(3,1,3);
plotmf(acfis,"output",1);
% add control rules to our FIS
rulelist = [  1	     1      3      1      1;
                    1       2      3      1      1;
                    1       3      2      1      1;
                    2       1      2      1      1;
                    2       2      1      1      1;
                    2       3      1      1      1;
                    3       1      2      1      1;
                    3       2      1      1      1;
                    3       3      1      1      1  ];

acfis = addRule(acfis, rulelist);
acfis = writeFIS(acfis);
ac_fis = readfis('acfis');
subplot(1,1,1);
gensurf(ac_fis);


