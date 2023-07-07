cats = unique(idx);
percentgraph = percentdensity(idx);
for i=1:size(percentgraph,1)
        plot(percentgraph(i,:),"*", 'DisplayName',num2str(cats(i,1)));
        hold on;
end
legend;

function graph = percentdensity(idx)
    numlines = length(unique(idx));
    funcats = unique(idx);
    graph = zeros(numlines,1);
    timestep = 500;
    for i=0:length(idx)-timestep
        for j=1:numlines
            catpercent = 0;
            for k=1:timestep
                if idx((i+k),1) == funcats(j,1)
                    catpercent = catpercent + 1/timestep;
                end
            end
            graph(j,i+1) = catpercent;
        end
    end
end