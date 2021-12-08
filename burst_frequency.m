function [ X ] = burst_frequency( PulseWidth, PulsePause, NPulses, f)
%calculates the Fourier transform of a train of square pulses. 
% 
% PulseWidth: Length of the on-time
% PulsePause: Length of the off-time 
% NPulses: number of pulses in the train 
% f: frequency vector
%
% Implemented by Daniel Hufschläger © 2021
%

T = PulseWidth + PulsePause;
A = sin(pi.*f*PulseWidth)./(pi*f*PulseWidth);
B = sin(pi.*f*NPulses*T)./(sin(pi.*f*T));
X = abs(A.*B);%*PulseWidth;
end

