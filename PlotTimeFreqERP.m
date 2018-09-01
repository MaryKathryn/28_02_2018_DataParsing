% Plot the time freq plot for your ERPs
%Kathryn McIntosh 
%August 16th, 2018 


%adapted from Cohen chapter 13 figure 16


function PlotTimeFreqERP(ERPData)
% variables 
min_freq =  2; %wavelet min frequency
max_freq = 100;%wavelet max frequency
num_frex = 100; 
srate = 10000;
pnts = 15001; %length (# cols) of ERP data in # samples 
trials = 30; % # of lines in my variable ERP data
sample = linspace(0,15001,15001);


% define wavelet parameters
time = -1:1/srate:1;
frex = logspace(log10(min_freq),log10(max_freq),num_frex);
s    = logspace(log10(3),log10(10),num_frex)./(2*pi*frex);
% s    =  3./(2*pi*frex); % this line is for figure 13.14
% s    = 10./(2*pi*frex); % this line is for figure 13.14

% definte convolution parameters
n_wavelet            = length(time);
n_data               = pnts*trials;
n_convolution        = n_wavelet+n_data-1;
n_conv_pow2          = pow2(nextpow2(n_convolution));
half_of_wavelet_size = (n_wavelet-1)/2;

% get FFT of data
eegfft = fft(reshape(ERPData,1,pnts*trials),n_conv_pow2);

% initialize
eegpower = zeros(num_frex,pnts); % frequencies X time X trials

baseidx = dsearchn(sample',[-500 -200]');

% loop through frequencies and compute synchronization
for fi=1:num_frex
    
    wavelet = fft( sqrt(1/(s(fi)*sqrt(pi))) * exp(2*1i*pi*frex(fi).*time) .* exp(-time.^2./(2*(s(fi)^2))) , n_conv_pow2 );
    
    % convolution
    eegconv = ifft(wavelet.*eegfft);
    eegconv = eegconv(1:n_convolution);
    eegconv = eegconv(half_of_wavelet_size+1:end-half_of_wavelet_size);
    
    % Average power over trials (this code performs baseline transform,
    % which you will learn about in chapter 18)
    temppower = mean(abs(reshape(eegconv,pnts,trials)).^2,2);
    eegpower(fi,:) = 10*log10(temppower./mean(temppower(baseidx(1):baseidx(2))));
end

figure
subplot(121)
contourf(sample,frex,eegpower,40,'linecolor','none')
%set(gca,'clim',[-3 3],'xlim',[-200 1000],'yscale','log','ytick',logspace(log10(min_freq),log10(max_freq),6),'yticklabel',round(logspace(log10(min_freq),log10(max_freq),6)*10)/10)
title('Logarithmic frequency scaling')

subplot(122)
contourf(sample,frex,eegpower,40,'linecolor','none')
%set(gca,'clim',[-3 3],'xlim',[-200 1000])
title('Linear frequency scaling')

end %function 