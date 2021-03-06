function saveEMA2file_NIDA_format_v2(pid,sid)
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
global DIR FILE
infile = [ DIR.SESSIONTYPE_NAME(1) '_' pid '_' sid '_' FILE.FRMTDATA_MATNAME];
load ([DIR.FORMATTEDDATA DIR.SEP infile]);

load('C:\NIDA\NIDA_EMA_QuestionnaireWithPossibleAnsweres.mat');
[row col]=size(D.ema.data);
a=[1,2,4,8,16,32,64,128,256,512,1024,2048];
%fid=fopen(['C:\Users\mmrahman\Desktop\NIDA_Results\EMA\' pid '_' sid '_ema.csv'],'w');
fid=fopen('C:\EMA\NIDA_ema_data_all_subject_20130108.csv','a');
%create header of the file
%header='subject number,Date,Time,Weekday';
%nQ=length(EMAQuestionnaire.question);
%for i=1:nQ
%    header=[header ',' EMAQuestionnaire.question(i).text];
%end

%fprintf(fid,'%s\n',header);
for r=1:length(D.ema.data)     % # of data point
    questions=1;
    %line=[num2str(r) ','];
    line=[pid ',' sid];; %subject number
    %time=convert_timestamp_time(str2num(char(D.ema.data(r,13)))); %timestamp of the first column of the EMA
    %time=convert_timestamp_time(str2num(char(D.ema.data(r,13))));
    time=convert_timestamp_time(D.ema.data(r).prompttimestamp);
    [n s]=weekday(time);
    line=[line ',' time(1:10) ',' time(12:19) ',' s ',' num2str(D.ema.data(r).context) ',' num2str(D.ema.data(r).delayduration) ','];
    %for c=14:2:col
    for c=1:length(D.ema.data(r).question)    %questions and corresponding answers
        %questions
        %if questions==21 | questions==23 | questions==25
        if c==21 | c==23 | c==25
           line=[line  D.ema.data(r).question(c).response];
        elseif ~isempty(D.ema.data(r).question(c).response)
            text='';
            %{
            val=str2num(char(D.ema.data(r,c)));
            choices=[];
            for i=1:length(a)
                if val>=a(i)
                    if bitand(a(i),val)
                        if i<=length(EMAQuestionnaire.question(questions).answerChoice)
                            choices=[choices i];
                        else
                            disp(['participant = ' pid ' session = ' sid ' EMA number = ' num2str(r) ' question number = ' num2str(questions) ' answered option number = ' num2str(i) ' ,answer number exceeds available options']);
                        end
                        %line=[line text ':'];
                    end
                end
            end
            %}
            text=[text getAnswerChoices(c,D.ema.data(r).question(c).response)];
            line=[line text];
        else
            %line=[line ',' char(D.ema.data(r,c))];
            %line=[line ',' char(D.ema.data(r,c))];
        end
        questions=questions+1;
        line=[line ','];
    end
    fprintf(fid,'%s\n',line);
end
fclose(fid);
end
function answerText=getAnswerChoices(questions,choices)
    answerText='';
    if length(choices)==0
        return;
    end
    load('C:\NIDA\NIDA_EMA_QuestionnaireWithPossibleAnsweres.mat');
    if length(choices)>1
        for i=1:length(choices)-1
            if choices(i)>length(EMAQuestionnaire.question(questions).answerChoice)
                return
            end
            answerText=[EMAQuestionnaire.question(questions).answerChoice(choices(i)).text ' & ' answerText];

        end
    end
    if choices(1)>length(EMAQuestionnaire.question(questions).answerChoice)
        return
    end
    answerText=[answerText EMAQuestionnaire.question(questions).answerChoice(choices(1)).text];
end
