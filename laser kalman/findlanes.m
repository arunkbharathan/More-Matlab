function lanes=findlanes(B,h,stats)
% Find the regions that look like lanes

l=0;
for k = 1:length(B)
    metric = stats(k).MajorAxisLength/stats(k).MinorAxisLength;
    testlane(k);
end
    function testlane(k)
        if metric > 5  && all(B{k}(:,2)>200) && all(B{k}(:,1)>200)
            l=l+1;
            lanes(l,:)=B(k);
        else
            delete(h(k))
        end
    end
end