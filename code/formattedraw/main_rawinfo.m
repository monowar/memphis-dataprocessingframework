function main_rawinfo(G,pid,indir)
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
INDIR=[G.DIR.DATA G.DIR.SEP indir G.DIR.SEP pid];
fprintf('%-6s %-20s Task (',pid,'main_rawinfo');
fprintf('tos');
timestamp=report_tosfiles(G,pid,INDIR);
report_labstudy(G,pid,INDIR);
list=[];
row=size(timestamp,1);
for r=1:row
    start_matlabtimestamp=floor(convert_timestamp_matlabtimestamp(G,timestamp(r,1)));
    end_matlabtimestamp=ceil(convert_timestamp_matlabtimestamp(G,timestamp(r,2)));
    for i=start_matlabtimestamp:1:end_matlabtimestamp-1
        if find(list==i)
            continue;
        end
            list(end+1)=i;
    end
end
list=sort(list);

if ~isempty(dir([INDIR G.DIR.SEP G.FILE.SESSION_DEF]))
    movefile([INDIR G.DIR.SEP G.FILE.SESSION_DEF], [INDIR G.DIR.SEP datestr(clock,'mm-dd-yyyy_HH-MM-SS') '_' G.FILE.SESSION_DEF ]);
end
session_fid=fopen([INDIR G.DIR.SEP G.FILE.SESSION_DEF],'w');
for sid=1:length(list)
    starttimestr=datestr(list(sid),G.TIME.FORMAT);
    endtimestr=datestr(list(sid)+1,G.TIME.FORMAT);
    fprintf(session_fid,'pid,%s,sid,s%02d,start,%s,end,%s\r\n',pid,sid,starttimestr,endtimestr);
end
fclose(session_fid);

fprintf(') =>  done\n');
end
