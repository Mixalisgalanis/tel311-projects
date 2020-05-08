function index = findBin(value, binEnds)
% return the index of the bin where value belongs {1, ..., numBins}.
    index = -1;
    for i = 2 : length(binEnds)
        if value <= binEnds(i)
            index = i - 1;
            break;
        end
    end
end