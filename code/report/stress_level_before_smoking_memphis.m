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
stressProbAll=[];
StressValAll=[];
smokingReport=load('c:\dataProcessingFramework\data\memphis\report\memphis_Stress\smokingReportWhileActivePeriod_memphis.csv');
stress=csvread('C:\DataProcessingFramework\data\memphis\report\Memphis_Stress\scaledStress\stress_scaledValue_with_day.csv',1,0);

[row col]=size(smokingReport);
% participant=-1;
for i=1:row
    stressProb=-1*ones(1,30);
    stressVal=-1*ones(1,30);
%     temp=participant;
    participant=smokingReport(i,1);
    day=smokingReport(i,2);
%     if participant == 17 || participant == 22 || participant == 24 || participant == 26 || participant ==31
%         continue;
%     end
    smokingTs=smokingReport(i,end);
%     if participant~=temp  %load only when a new participant comes
%     end
    indd=find(stress(:,1)==participant & stress(:,2)==day);
    data=stress(indd,:);
%     for offset=30:-1:1
    for offset=1:30
        endtime=smokingTs-(offset-1)*60*1000;
        starttime=smokingTs-offset*60*1000;
        ind=find(starttime<=data(:,end) & data(:,end)<=endtime);
        if ~isempty(ind)
            admissionControl=data(ind(end),5);
            if admissionControl==0
                stressProb(offset)=data(ind(end),3);
                stressVal(offset)=data(ind(end),4);
            end
        end
    end
    stressProbAll=[stressProbAll;[participant day stressProb]];
    StressValAll=[StressValAll;[participant day stressVal]];
end

meanStressProb=-1*ones(1,30);
stdStressProbl=-1*ones(1,30);
for i=1:30
    data=stressProbAll(:,i+2);
    ind2=find(data>=0);
    meanStressProb(i)=mean(data(ind2));
    stdStressProbl(i)=std(data(ind2));  %we should consider subject level variation
end

% stdStressProbl=[];
% meanStressProb=-1*ones(30,1);
% meanStressVal=-1*ones(30,1);
% for i=1:30
%     data=StressValAll(:,i+2);
%     ind2=find(data>=0);
%     meanStressVal(i)=mean(data(ind2));
% end
%
% meanStressVal=-1*ones(30,1);


%%%%%%%%%%%%%%%% Subjectwise Stress value up to 30 minute before smoking
subjectWiseStress=[];
for i=[12,13,14,15,16,18,19,20,21,25,27,28,29,30,32,33,34,35,36,37,38,39,40,41,42,43,44]
    ind=find(StressValAll(:,1)==i);
    temp=StressValAll(ind,3:end);
    strss=-1*ones(1,30);
    for j=1:30
        data=temp(:,j);
        ind2=find(data>=0);
        strss(j)=mean(data(ind2));
    end
    subjectWiseStress=[subjectWiseStress; i strss];
end

subjectWiseStressProb=[];
for i=[12,13,14,15,16,18,19,20,21,25,27,28,29,30,32,33,34,35,36,37,38,39,40,41,42,43,44]
    ind=find(stressProbAll(:,1)==i);
    temp=stressProbAll(ind,3:end);
    strss=-1*ones(1,30);
    for j=1:30
        data=temp(:,j);
        ind2=find(data>=0);
        strss(j)=mean(data(ind2));
    end
    subjectWiseStressProb=[subjectWiseStressProb; i strss];
end
nanSd=nanstd(subjectWiseStressProb(:,2:end));

%overall subjectwise stress
overallSubWiseStressProb=[];
for i=[12,13,14,15,16,18,19,20,21,25,27,28,29,30,32,33,34,35,36,37,39,40,41,42,43,44]
    ind=find(stress(:,1)==i & stress(:,5)==0);
    strss=mean(stress(ind,3));
    overallSubWiseStressProb=[overallSubWiseStressProb; i strss];
end
indd=find(stress(:,5)==0);
overallMean=nanmean(stress(indd,3));
overallSd=nanstd(overallSubWiseStressProb(:,2));

disp('hi');
