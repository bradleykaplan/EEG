clear all;
sesh2 = readmatrix("");%insert CSV names here
sesh3 = readmatrix("");
sesh4 = readmatrix("");
sesh5 = readmatrix("");
currentvar = sesh4;

measuresandparams = nan(1,3);
maxmeasure = -realmax;
idealfirstparam = nan;
idealsecondparam = nan;
trialnumber = 0;
for i=1:0.1:5
    for j=10:50:1000
        trialnumber = trialnumber + 1;
        trialnumber%see speed of script
        idx = dbscan(currentvar, i, j);
        thismeasure = getmeasure(idx, length(currentvar));
        if thismeasure > maxmeasure
            maxmeasure = thismeasure;
            idealfirstparam = i;
            idealsecondparam = j;
        end
        measuresandparams = [measuresandparams; thismeasure i j];
    end
end
for i=(idealfirstparam - 0.1):0.1:(idealfirstparam + 0.1)
    for j=(idealsecondparam - 50):(idealsecondparam+50)
        if j < 1
            continue
        end
        trialnumber = trialnumber + 1;
        trialnumber%see speed of script
        idx = dbscan(currentvar, i, j);
        thismeasure = getmeasure(idx, length(currentvar));
        if thismeasure > maxmeasure
            maxmeasure = thismeasure;
            idealfirstparam = i;
            idealsecondparam = j;
        end
        measuresandparams = [measuresandparams; thismeasure i j];
    end
end

idx = dbscan(currentvar, idealfirstparam, idealsecondparam);
[dbscangroups, group_labels, ~] = groupcounts(idx);
dbscangroups = cat(2, dbscangroups, group_labels);
sorted_dbgroups = sortrows(dbscangroups, "descend");


function measure = getmeasure(dbscans, numscans)
    [dbscangroups, group_labels, ~] = groupcounts(dbscans);
    dbscangroups = cat(2, dbscangroups, group_labels);
    sorted_dbgroups = sortrows(dbscangroups, "descend");%sort into group sizes and retain labels of which cluster is which
    thismeasure = 0;
    numcountedrows = 0;
    for n=1:12%remove row of noise
        if (n <= size(sorted_dbgroups,1)) && (sorted_dbgroups(n,2) == -1)
            sorted_dbgroups(n,:) = [];
        end
    end
    groupcountmedian = median(sorted_dbgroups(:,1));
    for n=1:12
        if n <= size(sorted_dbgroups,1)
            if n==1
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
            elseif n==2
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 2*sorted_dbgroups(n,1);
            elseif n==3
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 2.5*sorted_dbgroups(n,1);
            elseif n==4
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 3*sorted_dbgroups(n,1);
            elseif (n==5) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 1.7*sorted_dbgroups(n,1);
            elseif (n==6) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 1.6*sorted_dbgroups(n,1);
            elseif (n==7) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 1.5*sorted_dbgroups(n,1);
            elseif (n==8) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 1.4*sorted_dbgroups(n,1);
            elseif (n==9) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 1.3*sorted_dbgroups(n,1);
            elseif (n==10) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 1.2*sorted_dbgroups(n,1);
            elseif (n==11) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + 1.1*sorted_dbgroups(n,1);
            elseif (n==12) && (sorted_dbgroups(n,1) > groupcountmedian)
                numcountedrows = numcountedrows + sorted_dbgroups(n,1);
                thismeasure = thismeasure + sorted_dbgroups(n,1);
            end
        end
    end
    thismeasure = thismeasure - 1.35*(numscans - numcountedrows);
    measure = thismeasure;
end