% specRA is an adaptive reconstruction algorithm that applies 
% the lassoglm  reference library of spectral distributions 
%
% inputs: A reference high-dimensional library L
%         A "measured" library M = g(L) where g is a model of the sensor (can be relearned)
%         A the raw output from the sensor denoted input = [R, G, B]'
%
% outputs: The reconstructed spectrum W in 5nm intervals 
% 
% written by Forrest Webler fwebler@gmail.com
% based in part on https://doi.org/10.3390/s22062377

function W = SpecRA_8(L,M,input)

    wls = 380:5:780'; % fixed wavelengths from L

    % power normalize the input 
    p=input/sum(input); 

    % power normalize the reference libraries
    for i=1:size(M,2)
        M0(:,i) = M(:,i)/sum(M(:,i));
        L0(:,i) = L(:,i)/sum(L(:,i));
    end
    
    % apply lassoglm on measured data to find sparse coefficients
    % can also replace with other regularization methods c.f., l1-magic
    x_b = normalize(sum(lassoglm(M0,p),2),'range');

    % reconstruct spectrum from high-dimensional library
    W = sum(x_b'.*L0,2);

    % set all negative values to 0 (this performed better than constraing the solution to positive values)
    W(W<0,1)=0; 

    % power normalize to get absolute units
    W = W/sum(W);
end
