function G=config_run(G)
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
%G.STUDYNAME='memphis';%'nida';
G.STUDYNAME='nida';
G.TIME.TIMEZONE=-5;
G.TIME.DAYLIGHTSAVING=1;
G.TIME.FORMAT='mm/dd/yyyy HH:MM:SS';

G.DIR.DATA=[G.DIR.ROOT G.DIR.SEP 'data' G.DIR.SEP G.STUDYNAME];

G.PS_LIST= {
    %{
    {'p01'},(cellstr(strcat('s',num2str((1:30)','%02d'))))';
    {'p02'},(cellstr(strcat('s',num2str((1:40)','%02d'))))';
    {'p03'},(cellstr(strcat('s',num2str((1:27)','%02d'))))';
    {'p04'},(cellstr(strcat('s',num2str((1:35)','%02d'))))';
    {'p05'},(cellstr(strcat('s',num2str((1:27)','%02d'))))';
    {'p06'},(cellstr(strcat('s',num2str((1:34)','%02d'))))';
    {'p07'},(cellstr(strcat('s',num2str((1:22)','%02d'))))';
    {'p08'},(cellstr(strcat('s',num2str((1:26)','%02d'))))';
    {'p09'},(cellstr(strcat('s',num2str((1:29)','%02d'))))';
    {'p10'},(cellstr(strcat('s',num2str((1:31)','%02d'))))';
    {'p11'},(cellstr(strcat('s',num2str((1:25)','%02d'))))';
    {'p12'},(cellstr(strcat('s',num2str((1:31)','%02d'))))';
    {'p13'},(cellstr(strcat('s',num2str((1:3)','%02d'))))';
    {'p14'},(cellstr(strcat('s',num2str((1:29)','%02d'))))';
    {'p15'},(cellstr(strcat('s',num2str((1:11)','%02d'))))';
    {'p16'},(cellstr(strcat('s',num2str((1:15)','%02d'))))';
    {'p17'},(cellstr(strcat('s',num2str((1:7)','%02d'))))';
    {'p18'},(cellstr(strcat('s',num2str((1:8)','%02d'))))';
    %}
    {'p19'},(cellstr(strcat('s',num2str((1:6)','%02d'))))';
};
%% Formatted Raw
G.RUN.FRMTRAW.SENSORLIST_TOS=[G.SENSOR.R_RIPID,G.SENSOR.R_ECGID,G.SENSOR.R_GSRID,G.SENSOR.R_ACLXID, G.SENSOR.R_ACLYID, G.SENSOR.R_ACLZID,...
    G.SENSOR.A_ALCID,G.SENSOR.R_BAT_SKN_AMB_ID,G.SENSOR.A_GSRID,G.SENSOR.A_TEMPID];
G.RUN.FRMTRAW.SENSORLIST_DB=[G.SENSOR.P_ACLXID, G.SENSOR.P_ACLYID, G.SENSOR.P_ACLZID];
G.RUN.FRMTRAW.SELFREPORTLIST=[G.SELFREPORT.DRNKID,G.SELFREPORT.SMKID,G.SELFREPORT.CRVID];
G.RUN.FRMTRAW.SENSORLIST_GPS=[G.SENSOR.P_GPS_LATID, G.SENSOR.P_GPS_LONGID, G.SENSOR.P_GPS_ALTID, G.SENSOR.P_GPS_SPDID, G.SENSOR.P_GPS_BEAR, G.SENSOR.P_GPS_ACCURACYID];

G.RUN.FRMTRAW.LOADDATA=0;
G.RUN.FRMTRAW.TOS=1;
G.RUN.FRMTRAW.PHONESENSOR=1;
G.RUN.FRMTRAW.GPS=1;
G.RUN.FRMTRAW.SELFREPORT=1;
G.RUN.FRMTRAW.LABSTUDYMARK=1;
G.RUN.FRMTRAW.LABSTUDYLOG=1;
G.RUN.FRMTRAW.EMA=1;

%% Formatted Data
G.RUN.FRMTDATA.SENSORLIST_CORRECTTIMESTAMP=[G.SENSOR.R_RIPID,G.SENSOR.R_ECGID,G.SENSOR.R_GSRID,G.SENSOR.R_ACLXID, G.SENSOR.R_ACLYID, G.SENSOR.R_ACLZID,...
    G.SENSOR.A_ALCID,G.SENSOR.R_BAT_SKN_AMB_ID,G.SENSOR.A_GSRID,G.SENSOR.A_TEMPID];
G.RUN.FRMTDATA.SENSORLIST_INTERPOLATE=[G.SENSOR.R_RIPID,G.SENSOR.R_ECGID,G.SENSOR.R_GSRID,G.SENSOR.R_ACLXID, G.SENSOR.R_ACLYID, G.SENSOR.R_ACLZID,...
    G.SENSOR.A_ALCID,G.SENSOR.R_BAT_SKN_AMB_ID,G.SENSOR.A_GSRID,G.SENSOR.A_TEMPID];
G.RUN.FRMTDATA.SENSORLIST_QUALITY=[G.SENSOR.R_RIPID,G.SENSOR.R_ECGID];

G.RUN.FRMTDATA.LOADDATA=0;
G.RUN.FRMTDATA.EMA=1;
G.RUN.FRMTDATA.CORRECTTIMESTAMP=1;
G.RUN.FRMTDATA.INTERPOLATE=1;
G.RUN.FRMTDATA.QUALITY=1;

G.RUN.BASICFEATURE.LOADDATA=0;
G.RUN.BASICFEATURE.PEAKVALLEY=1;
G.RUN.BASICFEATURE.RR=1;

G.RUN.WINDOW.LOADDATA=0;
G.RUN.FEATURE.LOADDATA=0;
G.RUN.MODEL=G.MODEL.STRESS60;
end
%{

RUN.FRMTDATA.LOADFRMTDATA=0;
RUN.FRMTDATA.EMA=1;
RUN.FRMTDATA.FORMATSENSOR=[SENSOR.R_RIPID,SENSOR.R_ECGID,SENSOR.R_GSRID,SENSOR.R_ACLXID, SENSOR.R_ACLYID, SENSOR.R_ACLZID, SENSOR.A_ALCID];
RUN.FRMTDATA.RIP=1;RUN.FRMTDATA.ECG=1;RUN.FRMTDATA.ACL=1;
RUN.FRMTDATA.NIDA_PDA_SELFREPORT=1;
RUN.FRMTDATA.JHU_PDA_LABREPORT=0;

RUN.BASICFEATURE.RAW_NORMALIZE=[SENSOR.R_ACLXID, SENSOR.R_ACLYID, SENSOR.R_ACLZID];
RUN.BASICFEATURE.LOADDATA=1;
RUN.BASICFEATURE.RIP=0;
RUN.BASICFEATURE.ECG=0;
RUN.BASICFEATURE.RIPECG=0;
RUN.BASICFEATURE.ACCEL=0;
%}
