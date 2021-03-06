%find out the activity episodes from accelerometer based on the threshold
function activityFeatureMerge_v2(pid,sid)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Copyright 2014 University of Memphis
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%%

% participant=15;
% day=1;
% load(['c:\dataProcessingFrameworkV2\data\memphis\feature\field_' strcat('p',num2str(participant,'%02d')) '_' strcat('s',num2str(day,'%02d')) '_act10_feature.mat'])
% load(['c:\dataProcessingFrameworkV2\data\memphis\feature\field_' pid '_' sid '_act10_feature.mat'])
load(['c:\dataProcessingFramework\data\nida\feature\field_' pid '_' sid '_act10_feature.mat'])
% load(['c:\dataProcessingFramework\data\nida\feature\field_' pid '_' sid '_drug60_feature.mat'])

featureVal=[];
featureTs=[];
for i=1:length(F.window)
    if isfield(F.window(i).feature{4},'value')
        featureVal=[featureVal F.window(i).feature{4}.value{30}];
        featureTs=[featureTs F.window(i).starttimestamp];
    end;
end

% disp('hi');
% featMag=zeros(length(F.window),1);
% featTime=-1*ones(length(F.window),1);
%
% for i=1:length(F.window)
%     featTime(i)=F.window(i).starttimestamp;
% end
%
% for i=1:length(F.window)
%     if isfield(F.window(i).feature{4},'value') && F.window(i).feature{4}.value{30}>=0.21384
%         featMag(i)=1;
%     end
% end;

% featureStdMagVal=[];
% featureStdMagTs=[];
% for i=1:length(F.window)
%     if isfield(F.window(i).feature{4},'value')
%         featureStdMagVal=[featureStdMagVal F.window(i).feature{4}.value{30}];
%         featureStdMagTs=[featureStdMagTs F.window(i).starttimestamp];
%     end;
% end
% ind=find(featureVal>=0.21384);  %activity threshold
WINDOWSIZE=10*1000;

p01=prctile(featureVal,1);
p99=prctile(featureVal,99);
range=p99-p01;  %trim the range to account for outliers
ind=find(featureVal>0.35*range);

% ind=find(featureVal>=0.21384);
% ind=find(featureVal>=prctile(featureVal,80));
activity=zeros(1,length(featureVal));
activity(ind)=1;
activityEpisodes.value=[];
activityEpisodes.starttime=[];
activityEpisodes.endtime=[];

episodes=getEpisodesFromTimestamps(featureTs,1);
%merge activity for each episodes
now=0;
for p=1:size(episodes,1)
    inde=find(featureTs>=episodes(p,1) & featureTs<=episodes(p,2));
    len=length(inde);
    for i=1:len
        if i==1 || activity(inde(i)-1)~=activity(inde(i))
            now=now+1;
            activityEpisodes.starttime(now)=featureTs(inde(i));
            activityEpisodes.value(now)=activity(inde(i));
        end
        activityEpisodes.endtime(now)=featureTs(inde(i))+WINDOWSIZE;
    end
end
%write the episodes to a file
fid=fopen('C:\DataProcessingFramework\data\nida\report\activityEpisodes\activityEpisodes_all.csv','a');
line=[];
for i=1:length(activityEpisodes.value)

    line=[pid(2:end) ',' sid(2:end) ',' num2str(activityEpisodes.starttime(i)) ',' num2str(activityEpisodes.endtime(i)) ',' num2str(activityEpisodes.value(i))];
    fprintf(fid,'%s',line);
    fprintf(fid,'\n');

end;
fclose(fid);
