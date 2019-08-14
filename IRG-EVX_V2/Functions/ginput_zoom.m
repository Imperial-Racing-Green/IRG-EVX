function [point] = ginput_zoom(n)

while 0<1
    [x,y,b] = ginput(n); 
    if isempty(b)
        point=[];
        break;
    elseif b==45
        ax = axis; width=ax(2)-ax(1); height=ax(4)-ax(3);
        axis([x-width/2 x+width/2 y-height/2 y+height/2]);
        zoom(1/2);
    elseif b==61
        ax = axis; width=ax(2)-ax(1); height=ax(4)-ax(3);
        axis([x-width/2 x+width/2 y-height/2 y+height/2]);
        zoom(2);    
    elseif b==1
        point = [x,y];
        break;
    else
    end
end
end