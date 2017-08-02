function genLossSeries()
filename='log23d_50sub_v1_res0723';
fid=fopen([filename,'.txt'],'r');

test_loss=[];
id=0;
train=0
while 1
    line=fgetl(fid);
    if ~ischar(line),break;end
    if train==1
        if strfind(line,'Train net output')
           words=strsplit(line,'=');
           word=words{3};
           newwords=strsplit(word,' ');
           loss=newwords{2};
           id=id+1;
           %line
           %loss
           test_loss(id)=str2num(loss);
        else
            continue;
        end
    else
       if strfind(line,'Test net output')
           if strfind(line,'accuracy')
               continue;
           end
           words=strsplit(line,'=');
           word=words{3};
           newwords=strsplit(word,' ');
           loss=newwords{2};
           id=id+1;
           test_loss(id)=str2num(loss);
        else
            continue;
        end 
    end
end
test_loss=test_loss+0.05;
%plot(1:id,test_loss(1:end));
fclose(fid);
if train==1
    loss=test_loss(1:end);
    loss=loss(1:10:end);
    plot(1:length(loss),loss);
    matname=[filename,'_Train.mat'];
else
    loss=test_loss(2:end);
    plot(1:length(loss),loss(1:end));
    matname=[filename,'_Test.mat']; 
end
save(matname,'loss');
end