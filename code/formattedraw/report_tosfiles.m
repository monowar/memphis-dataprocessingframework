function timestamp=report_tosfiles(G,pid,curdir)
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

filelist=findfiles(curdir,G.FILE.TOS_NAME);
filelist=finduniquefiles(filelist);
noFile=size(filelist,2);
lastendtime=0;
timelog_fid=fopen([curdir G.DIR.SEP G.FILE.REPORT_TOS],'w');
timestamp=[];
count=0;
for i=1:noFile
    fileInfo = dir(filelist{i});
    if fileInfo.bytes==0
        continue;
    end
    %packet=csvread(filelist{i});
    packet=csvread_tos_skip_last(filelist{i});
    packet=packet(packet(:,1)~=-1,:);
	packet=packet(packet(:,7)~=0,:);

    row=size(packet,1);
    if row==0
        continue;
    end
    count=count+1;
    starttimestamp=min(packet(:,7));
    endtimestamp=max(packet(:,7));
    timestamp(count,1)=starttimestamp;
    timestamp(count,2)=endtimestamp;
    startTimeStr=convert_timestamp_time(G,starttimestamp);
    endTimeStr=convert_timestamp_time(G,endtimestamp);

    if lastendtime==0
        lastendtime=starttimestamp;
    end
    [t1, curname, curext] = fileparts(filelist{i});
    report=sprintf('pid,%s,filename,%s%s',char(pid),curname,curext);

    x=sprintf(',starttime,%s,endtime,%s',startTimeStr,endTimeStr);    report=[report,x];
    x=sprintf(',starttimestamp,%d,endtimestamp,%d',starttimestamp,endtimestamp);    report=[report,x];
    x=sprintf(',duration(min),%6.1f,difference(min),%6.1f,',(endtimestamp-starttimestamp)/(1000*60),(starttimestamp-lastendtime)/(1000*60));    report=[report,x];

    for s=G.RUN.FRMTRAW.SENSORLIST_TOS
        sample=packet(packet(:,1) == G.SENSOR.ID(s).TOS_CHANNEL);
        [row]=size(sample,1);lensample=row*5;
        missing=getMissingRate(lensample,starttimestamp,endtimestamp,G.SENSOR.ID(s).FREQ);
        x=sprintf(',miss_%s(%%),%.2f',G.SENSOR.ID(s).NAME,missing);    report=[report,x];
    end
%    s=sprintf('%s%s,start,%s,end,%s,duration(min)=%6.1f,difference(min)=%6.1f, RIP_MISS(%%)=%5.2f, ECG_MISS(%%)=%5.2f ALC_MISS(%%)=%5.2f',curname,curext,startTimeStr,endTimeStr,(endtimestamp-starttimestamp)/(1000*60),(starttimestamp-lastendtime)/(1000*60),ripmissing,ecgmissing,alcmissing);
    fprintf(timelog_fid,'%s\r\n',report);
    lastendtime=endtimestamp;
end
fclose(timelog_fid);
end
