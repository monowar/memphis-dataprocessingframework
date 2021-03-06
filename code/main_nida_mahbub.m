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
%% Data Processing Framework
% Overview: starting point of the framework.
clear all
%% Basic Configureation files
%
G=config();
G=config_run_nida(G);

PS_LIST=G.PS_LIST;

%report_selfreport_all(G,'formattedraw','report',PS_LIST,G.SELFREPORT.SMKID);
%report_formattedraw_short(G,'formattedraw','report',PS_LIST);
%report_nida(G,'formattedraw','studyinfo','report',PS_LIST);
%return;
%return;
%temp_update_frmtdata_acl(G,'formatteddata');
%return;
%load_nida_pda_selfreport(G,'formatteddata');
%return;
%temp_update_frmtdata_pdamark(G,'formattedraw','formatteddata');
%return;
%  PS_LIST= {
%     {'p01'},{'s24'};
% %     {'p06'},{'s01'};
%  };

pno=size(PS_LIST);
for p=1:pno
    pid=char(PS_LIST{p,1});
    slist=PS_LIST{p,2};
    pid='p15'
    for s=slist
        sid=char(s);
        sid='s07'
        %        figure;plot_frmtraw(G,pid,sid,'formattedraw',[G.SENSOR.R_RIPID,G.SENSOR.R_ECGID,G.SENSOR.R_GSRID,G.SENSOR.R_AMBID]);
        %        plot_selfreport(G,pid,sid,'formattedraw',[1,2]);
        %        plot_labstudymark(G,pid,sid,'formattedraw');
        %main_rawinfo(G,pid,'raw');
        %      	main_formattedraw(G,pid,sid,'raw','formattedraw');
%         main_formatteddata(G,pid,sid,'formattedraw','formatteddata');
        %        figure;plot_frmtdata(G,pid,sid,'formatteddata',[G.SENSOR.R_RIPID,G.SENSOR.R_ECGID]);

%         		main_basicfeature(G,pid,sid,'formatteddata','basicfeature');
%          [md,PR]=find_baseline(G,pid,sid,'basicfeature');
%          disp(['pid=' pid ' sid=' sid ' md=' num2str(md) ' PR=' num2str(PR)]);
%          M(str2num(pid(2:end)),str2num(sid(2:end)),:)=md;
%          P(str2num(pid(2:end)),str2num(sid(2:end)),:)=PR;
%
%         continue;
%         figure;plot_basicfeature(G,pid,sid,'basicfeature',[G.SENSOR.R_ECGID,G.SENSOR.R_ACLXID]);
%           plot_pdamark(G,pid,sid,'formattedraw');

%          continue;

%         disp([pid ' ' sid]);
%         ValidRipDuration=getGoodDataDuration(G,pid,sid);
%         saveSelfReport2CSV(G,pid,sid,2);
%         saveSelfReport2CSV(G,pid,sid,3);

        %         hold on;plot_pdamark(G,pid,sid,'formattedraw');
%         getMissingRateFromFormattedData(G,pid,sid)



%        saveEMA2file_NIDA_format_v3(G,pid,sid,'formatteddata');
%        disp([pid ' ' sid ' :done']);
%         main_window(G,pid,sid,'basicfeature','window',G.MODEL.DRUG60);

%         main_feature(G,pid,sid,'window','feature',G.MODEL.DRUG60);
        %        disp(['pid=' pid ' sid=' sid]);
        %        main_curve(G,pid,sid,'formatteddata','basicfeature','window','feature','curve',G.MODEL.DRUG10);
        %pid='p06';sid='s01';plot_activity(G,pid,sid,G.MODEL.DRUG60);
        %plot_drug(G,pid,sid,G.MODEL.DRUG60);
        % continue;
%                rr=find_activity(G,pid,sid,G.MODEL.DRUG10,rr);
%                 save_feature2text_v3(G,pid,sid,'feature','report');
%                 save_feature2text_v3_rip(G,pid,sid,'feature','report');
%                saveEMA2file_NIDA_format_v3(G,pid,sid,'formatteddata');
               report_labsessions(G,pid,sid,'formatteddata');
        %       disp('abc');
        %{
        main_feature(G,pid,sid,'window','feature');

        list_feature=[G.FEATURE.R_ECG.VRVL,G.FEATURE.R_ECG.LFHF,...
                G.FEATURE.R_ECG.HRP1,G.FEATURE.R_ECG.HRP2,...
                G.FEATURE.R_ECG.HRP3,G.FEATURE.R_ECG.RRMN,...
                G.FEATURE.R_ECG.RRMD,G.FEATURE.R_ECG.RRQD,...
                G.FEATURE.R_ECG.RR80,G.FEATURE.R_ECG.RR20,...
                G.FEATURE.R_ECG.RRCT];
        report_feature(G,pid,sid,'feature','report',G.FEATURE.R_ECGID,list_feature);
%        main_model(G,pid,sid,'feature','model');
        %}
    end;
end
% pno=size(M,1);
% sno=size(M,2);
% dno=size(M,3);
% i=0;
% figure;
% for p=1:pno
%     for d=1:dno
%         i=i+1;
%         val=M(p,:,d);
%         val(val==-1)=[];
%         val(val==0)=[];
%         val(isnan(val))=[];
%         hold on; scatter(ones(length(val),1)*(p-1)*15+d,val,'.');
%         %        mn(i)=mean(val);
%         %        sd(i)=std(val);
%     end
% end
% disp('abc');
