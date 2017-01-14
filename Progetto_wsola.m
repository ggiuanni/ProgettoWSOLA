% filename = 'speech.wav';
filename = 'furelise.wav';

[x, Fs] = audioread(filename);

% Parametri 'speech.wav'
L = round(0.03*Fs); % 30ms
S = round(0.5*L); % 50% overlap
delta = 40;

% Parametri 'furelise.wav'
% L = round(0.11*Fs);
% S = round(0.25*L);
% delta = 100;

TSR = 0.5;

y = wsola_processing(x, TSR, L, S, delta);

%sound(y,Fs);

if ~exist('output_audio', 'dir')
  mkdir('output_audio');
end
filename_out = strcat('output_audio/',filename(1:end-4),'_',num2str(TSR,'%0.2f'),'.wav');
audiowrite(filename_out,y,Fs);

function y = wsola_processing(x,TSR,L,S,delta)
    
    % Setup
    Sout = S;
    Sin = round(Sout*TSR);
    win = sqrt(hanning (L, 'periodic'));
    
    % Primo frame
    pRif=1+Sout;
    pin=1;
    pout=1;
    n=length(x);
    y=zeros(floor(n/TSR+L),1);
    yadd=x(1:L).*win;
    y(1:L)=yadd.*win;
    
    % Frame successivi
    while (pRif+L <= n && pin+L+delta+Sin <= n)
        
        % Aggiornamento indici
        pin=pin+Sin;
        pout=pout+Sout;
        
        % Frame di riferimento
        xRif=x(pRif:pRif+L-1);
        
        % Frame per l'output
        if(pin-delta > 1)
            xOut=x(pin-delta:pin+L-1+delta);
        else
            xOut=x(1:pin+L-1+delta);
        end        
        
        % Correlazione
        corr=xcorr(xOut,xRif);
        
        % Ricerca del massimo nella funz. di correlazione
        lxOut=length(xOut);
        corr_sel(1:2*delta+1)=corr(lxOut:lxOut+2*delta);
        max_index=find(corr_sel == max(corr_sel));
        if(length(max_index) > 1)
            max_index = delta;
        end
        
        % Output
        yadd=x(pin-delta+max_index-1:pin-delta+max_index+L-2).*win;
        y(pout:pout+L-1)=y(pout:pout+L-1)+yadd.*win;
        
        % Aggiornamento indice frame di riferimento
        pRif=pin-delta+max_index-1+Sout;
    end
    
end