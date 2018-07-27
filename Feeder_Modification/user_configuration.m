function [LUSolv,tax_files,tax_dir,out_dir,my_reg] = user_configuration(user_name)

if (strcmp(user_name,'default') ~= 0)
  
elseif (strcmp(user_name,'Steph') ~= 0)
    LUSolv = 0;
    tax_files =   {'R1-12.47-1.glm'};
    tax_dir = 'C:\Users\sjcrock\Box Sync\Code\research\feederConstraintsSurvey\supportingScripts\feederHousePopulatingScripts\';
    out_dir = 'C:\Users\sjcrock\Box Sync\Code\research\feederConstraintsSurvey\supportingScripts\feederHousePopulatingScripts\';
    my_reg = 0;



end