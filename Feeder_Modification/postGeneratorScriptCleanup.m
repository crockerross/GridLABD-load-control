function []= postGeneratorScriptCleanup(fid_name,file4)

%Author: Anna and Steph
%To modify the glm file output of the FeederGenerator matlab code.
%The fixes are listed below. It should be generalized for feeders.

%%open GLM file and establish folder for output
filename = fid_name;
output_file =[file4,'.glm'];
str = fileread(filename);
%%create new GLM file
write_file = fopen(output_file,'w');

% Fuse current_limit: replace all ' 50000;// ' with a space (' ')
mod1 = strrep(str, ' 50000;// ', ' ');

% Nominal Voltage, change the nominal voltage from 480V to 277V in the
%conversion from object load -> object node and in the meters
mod1 = strrep(mod1, 'nominal_voltage 480', 'nominal_voltage 277');


%%write to new file (write_file)
fwrite(write_file, mod1, '*char'); %change mod1 later one
%close new GLM file
fclose(write_file);
%

read_file = fopen(output_file,'r');
test = textscan(read_file,'%s','Delimiter','\n','whitespace','');
fclose(read_file);
test = [test{:}];
[c,d] = size(test);


% Change the primary side meter of the regulator the correct voltage
% rating

j=1;
flag =0;
name = 'vvvvvv'; %initialize these to nonsense
parentName = name; 

while j < c
   if (strfind(test{j},'configuration feeder_reg_cfg')>0)
       nameMeter = strrep(test(j-2), '      to ', '');
       nameMeter = [nameMeter{:}];   
       name = ['name ', nameMeter];
       parentName = ['parent ', nameMeter];
   end
   if (strfind(test{j}, parentName)>0)
       for s = 1:5
           if strfind(test{j+s},'voltage_A')>0
                voltageSplit1 = strsplit(test{j+s},' ');
                voltageSplit2 = strsplit(voltageSplit1{3},'+');
                voltageReal = [voltageSplit2{1}, ';'];
           end
       end
   end
   
   if (strfind(test{j}, name)>0)
       for s = 1:5
           if strfind(test{j+s},'nominal_voltage')>0
                saveMeterLocation = j+s;
           end
       end
       
   end
   j = j +1;    
end

test{saveMeterLocation} = ['      nominal_voltage ', voltageReal];

fileID = fopen(output_file,'w');
formatSpec = '%s %s %s %s %s %s %s %s\n';
[c,d] = size(test);
for j = 1:c
    fprintf(fileID,'%s\n',test{j});
end


fclose(fileID);
