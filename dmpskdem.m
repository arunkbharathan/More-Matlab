%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% symbol genration for bit streams %%%%%
%%%%%%         only for M-PSK           %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [S,data] = dmpskdem(rec_sym,con_size)
for ii=1:size(rec_sym,1)
    data=rec_sym(ii,:); 
    ln=length(data);                      % finding length of data
    pack=log2(con_size);                  % no.of bits in symbol
    for iii=1:pack:(pack*ln)
        temp1=real(data((iii+1)/pack));
        temp2=imag(data((iii+1)/pack));
        if round(temp1)>0 && round(temp2)==0
            s(iii)=0;s(iii+1)=0;
        elseif round(temp1)==0 && round(temp2)>0
            s(iii)=0;s(iii+1)=1;
        elseif round(temp1)<0 && round(temp2)==0
            s(iii)=1;s(iii+1)=0;
        elseif round(temp1)==0 && round(temp2)<0
            s(iii)=1;s(iii+1)=1;
        else
            s(iii)=0;s(iii+1)=0;
        end
    end
    S(ii,:)=s;    
end

return
