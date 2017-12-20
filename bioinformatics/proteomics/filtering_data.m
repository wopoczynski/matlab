load Data_preprocessed.mat;
imagesc(Data.matrix);
colorbar;
Z = zscore(Data.matrix);
[mask,data] = genelowvalfilter(Z,'Percentile',30);
[mask,data] = genevarfilter(data);
[mask,data] = geneentropyfilter(data,'Percentile',15);
[mask,data] = generangefilter(data);
dataX = data(:, find(Data.group==0)); %%zdrowi
dataY = data(:, find(Data.group==1)); %%chorzy
[PValues, TScores] = mattest(dataX, dataY, 'Showhist', 1, 'Showplot' ,1);

[PValues, TScores] = mattest(dataX, dataY, 'Showhist', 1, 'Showplot' ,1, 'Permute', 100);

dataPValues = data(find(PValues < 0.05));
[FDR, Q] = mafdr(PValues,'Showplot',1);
FDR_BHDFR = mafdr(PValues,'Showplot',1,'BHFDR',1);
resultTable = table(TScores,PValues,FDR,Q,FDR_BHDFR);
resultTable = sortrows(resultTable,'PValues','ascend');
volcanoPlot = mavolcanoplot(dataX, dataY, PValues);
resultTableVolcano = table(volcanoPlot.GeneLabels,volcanoPlot.PValues,volcanoPlot.FoldChanges, 'VariableNames',{'GeneLabels','PValues','FoldChanges'});
resultTableVolcano = sortrows(resultTableVolcano,'PValues','ascend');

