clc
clear all

C=[1,2,3,0,0];
A=[1,2,0,1,0;3,0,4,0,1];
B=[20;30];

n=size(A,2);
m=size(A,1);

BV_index=n-m+1:n;

Y=[A B];

for s=1:100
    Cb=C(BV_index);
    ZjCj=Cb*Y(:,1:n)-C;
    Xb=Y(:,end);
    ratio=[];
    
    if(ZjCj>=0)
        disp("Soln");
        disp(Xb)
        break
    else
        [value,Ev]=min(ZjCj);
        if all(Y(:,Ev)<0)
            disp("Unbounded Solution");
        else
            for i=1:m
                if Y(i,Ev)>0
                    ratio(i)=Xb(i)/Y(i,Ev);
                else
                    ratio(i)=100000;
                end
            end

        end
        [val,Lv]=min(ratio);
        BV_index(Lv)=Ev;
    end
    pivot=Y(Lv,Ev);
    Y(Lv,:)=Y(Lv,:)/pivot;


    for j=1:m
        if(j~=Lv)
            Y(j,:)=Y(j,:)-Y(j,Ev)*Y(Lv,:);
        end
    end
end