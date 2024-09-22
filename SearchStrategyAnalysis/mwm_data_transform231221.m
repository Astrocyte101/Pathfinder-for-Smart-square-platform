%% Log
% This script converts the original .xls file exported from Smart into separated files
% sorted by Subject Name and Trial Session
% It also adds a column of Time for later analysis
% !! Users have to modify the input parameters according to their needs !!

% (Newer versions add log here, please give brief descriptions of your modifications)
% 231221 by Yi-Ting Lin
% add variable slash_type for different OS
% to fix bug when the slashes in a directory are not compatible
% 231209 by Yi-Ting Lin
%   First version
%% Input parameter
slash_type = '/';
% For Windows users, use '\'
% For Mac users, use '/'

in_name = 'd11.xls';
% .xls exported from smart
sbj_col = 2;
trial_col = 3;
% the column where variable Subject Name & Trial Session are on
% this script uses these two variables to sort data
out_prefix = 'd11 seg';
% The output folder will be named as (out_prefix) dataset
% e.g. if out_prefix = 'd11', the file name will be 'd11 dataset'
% The output files will be named as (out_prefix)_(subject name)_(trial session).xls
% e.g. if out_prefix = 'd11'; subject name is WMD_01; trial session is 20231106-1
%      the file name will be 'd11_WMD_01_20231106-1.xlsx'
time_pt = 0.0625;
% elapse time between sample points, unit: second

sort_segment = 1;
% 0: Do not divide trials into segments; only one file would be produced for each trial
% 1: Divide trials into segments according to time;
%    if you have N segments you will get (N + 1) output files

% Variables below are set for sort_segment == 1, they do not matter if you set sort_segment = 0.
seg_length = 10;
% time length of each segment, unit: second
add_zero = 1;
% 0: time point start from time_pt
% 1: add a t = 0 point at the beginning of a trial
truncate = 0;
% 0: keep a segment even if its length is less than seg_length
% 1: if a segment's length is less than seg_length, delete it

%% Main codes
cur_path = pwd;
file_path = strcat(cur_path, slash_type, out_prefix, ' dataset');
mkdir(file_path)

tbl = readtable(in_name);
sbj_arr = table2array(unique(tbl(:,sbj_col)));
trial_arr = table2array(unique(tbl(:,trial_col)));

for i = 1:1:size(sbj_arr,1)
    sbj_index = ismember(tbl{:,sbj_col}, sbj_arr(i,1));
    for j = 1:1:size(trial_arr,1)
        trial_index = ismember(tbl{:,trial_col}, trial_arr(j,1));
        sub_index = logical(sbj_index .* trial_index);
        if max(sub_index) == 0
           continue
        end
        sub_tbl = tbl(sub_index, :);
        
        time_arr = (1:1:size(sub_tbl,1))' * time_pt;
        sub_time_tbl = addvars(sub_tbl, time_arr);
        sub_time_tbl.Properties.VariableNames{end} = 'Time';
        
        out_name = strcat(out_prefix, '_', sbj_arr{i,1}, '_', trial_arr{j,1}, '.xlsx');
        out_name2 = strcat(file_path, slash_type, out_name);
        writetable(sub_time_tbl, out_name2);
        
        if sort_segment == 1
            if add_zero == 1
                add_row = sub_time_tbl(1, :);
                add_row.Time = 0;
                trial_tbl = [add_row; sub_time_tbl];
                first_time_pt = 0;
            else
                trial_tbl = sub_time_tbl;
                first_time_pt = time_pt;
            end
            
            if truncate == 1
                last_time_pt = sub_time_tbl.Time(end) - seg_length;
                num_seg_file = floor((sub_time_tbl.Time(end) - first_time_pt) / seg_length);
            else
                last_time_pt = sub_time_tbl.Time(end);
                num_seg_file = floor((sub_time_tbl.Time(end) - first_time_pt) / seg_length) + 1;
                last_length = mod((sub_time_tbl.Time(end) - first_time_pt), seg_length);
                message = strcat(sbj_arr{i,1}, ' ', trial_arr{j,1}, ': the last segment is of ', num2str(last_length), ' seconds.');
                warning(message)
            end
            
            seg_idx = 1;
            for zeit = first_time_pt:seg_length:last_time_pt
                seg_tbl = trial_tbl(trial_tbl.Time >= zeit & trial_tbl.Time < (zeit + seg_length), :);
                trial_suffix = strcat(num2str(seg_idx), 'of', num2str(num_seg_file));
                
                trial_name = strcat(trial_arr{j,1}, '_', trial_suffix);
                seg_tbl(:, trial_col) = {trial_name};
                
                seg_out_name = strcat(out_prefix, '_', sbj_arr{i,1}, '_', trial_name, '.xlsx');
                seg_out_name2 = strcat(file_path, slash_type, seg_out_name);
                writetable(seg_tbl, seg_out_name2);
                
                seg_idx = seg_idx + 1;
            end
        end
        
        
    end

end