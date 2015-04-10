clear all
clf

%[y,Fs] = audioread('twinkle twinkle little star short.wav');
%[y,Fs] = audioread('eqt-major-sc.wav');
[y,Fs] = audioread('repeat.wav');
%[y,Fs] = audioread('440Hz_44100Hz_16bit_05sec.wav'); %Import wav file
plot(y(:,1)); %Plot the wav file

%Discretize by 0.05 db 
[pks,locs] = findpeaks(y(:,1)); %characterize amplitude
startnote = -1;
endnote = -1;
for i = 1:length(locs) - 100
        if(abs(y(locs(i),1)) > 0.05 && startnote == -1) %start recording when amp > 0.05 db
            startnote = locs(i);
        elseif((all(abs(y(locs(i):locs(i) + 100,1)) <= 0.023) == 1) && startnote ~= -1) %stop recording when amp for 100 peaks < 0.023 characterizing silence
            endnote = locs(i);
            disp(Note(y(startnote: endnote), Fs)); %disp Note
            startnote = -1; %reset recording
        end
end
if(startnote ~= -1) %if ended and noise was started but not ended, end wth end of audio
    disp(Note(y(startnote: locs(i)), Fs));
end 
        