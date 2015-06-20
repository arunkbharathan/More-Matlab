%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% symbol genration for bit streams %%%%%
%%%%%%         only for M-PSK           %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [S,data] = dmpsk(bits,con_size)
for ii=1:size(bits,1)
    data=bits(ii,:); %round(rand(1,bits));           % binary data generation
    ln=length(data);                    % finding length of data
    pack=log2(con_size);                % no.of bits in symbol
    group=(ln/pack);               % finding no.of packets group=floor(ln/pack);
    amp=2;
    phase=linspace(0,2*pi,con_size+1);  %
    phase=phase(1:con_size);            % 
    r=amp;                              % Genreation of symbols
    sym=r.*(cos(phase)+1j*sin(phase));  %
    
    s=zeros(1,group);
    for i=1:(group)                     %
        b=data(pack*i-(pack-1):pack*i); %
        b=fliplr(b);                    % Selection of symbol
        for j=1:length(b)               %           based on input bits
            d(j)=b(j)*j;                %
        end
        k=sum(d);                       
        s(i)=sym(k+1);
    end
    S(ii,:)=s;    
end
%     scatterplot(s)
    
return

%% End