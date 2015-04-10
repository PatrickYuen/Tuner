function Note = Note( S, Sample ) %Given Array and Sampling rate
    fq = [16.35, 17.32, 18.35, 19.45, 20.60, 21.83, 23.12, 24.50, 25.96, 27.50, 29.14, 30.87]; %Fundamental Freqencies
    notes = {'C'; 'C#'; 'D'; 'D#'; 'E'; 'F'; 'F#'; 'G'; 'G#'; 'A'; 'A#'; 'B'}; %Corresponding Notes
    biggest = intmax;
    Note = 'Dont Know';
    for octave = 0:7 %7 Octave
        for freq = 1:length(fq) %find Note
             sum = 0;
             period = (Sample/(fq(freq) * (2 ^(octave))));%period from frequency
             for index = 1:(length(S) - period)
                 sum = sum + (S(index) - S(floor(index + period)))^2; %RSS
             end
             sum = sqrt(sum)/(length(S) - period); %MSE
             if(biggest > sum && biggest - sum > 0.00001) %epsilon set to 0.00001 for rounding errors
                biggest = sum;
                Note = strcat(notes(freq),num2str(octave));%Note and Octave
             end
        end
    end
end

