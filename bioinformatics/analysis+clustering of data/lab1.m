%% 10 grup; BP

clear all;close all;clc;
load yeastdata

% filtracja

emptyspots = strcmp('EMPTY', genes);
genes(emptyspots) = [];
yeastvalues(emptyspots, :) = [];
chipgenes = genes;
yeastvalues = knnimpute(yeastvalues);
figure
plot(times, yeastvalues(6:10, :))
[mask, yeastvalues, genes] = genelowvalfilter(yeastvalues, genes, 'AbsValue', log2(3));
[mask2, yeastvalues, genes] = geneentropyfilter(yeastvalues, genes, 'Percentile', 15);

% analiza nienadzorowana - klastrowanie hierarchiczne

clusterTree = linkage(yeastvalues, 'average');
clusters = cluster(clusterTree, 10);
figure
dendrogram(clusterTree, 'labels', genes);
cg = clustergram(yeastvalues(:,2:end), 'RowLabels', genes, 'ColumnLabels', times(2:end), 'Linkage', 'average');

% histogram dla hierarchicznych
figure
hist(clusters, 10)

% analiza nienadzorowana - analiza k-srednich

[cidx, ctrs] = kmeans(yeastvalues, 10, 'Distance', 'correlation', 'Replicates', 5);
figure
hist(cidx, 10)

figure
for c = 1:10
 subplot(3, 4, c);
 plot(times, yeastvalues((cidx == c), :)');
 axis('tight');
end
suptitle('K-Means Clustering of Profiles');

figure
for c = 1:10
 subplot(3, 4, c);
 plot(times, yeastvalues((cidx == c), :)', 'r:', times, ctrs(c, :)', 'kp-');
 axis('tight');
end
suptitle('K-Means Clustering of Profiles with Centroids');

figure
for c = 1:10
 subplot(3, 4, c);
 plot(times, ctrs(c, :)');
 axis('tight');
end
suptitle('K-Means Centroids');

%% 2 czesc

GO=geneont('File','go-basic.obo');

GO = geneont('LIVE', true)

get(GO)

yeastAnnot=goannotread('gene_association.sgd')

yeastGenes = { yeastAnnot.DB_Object_Symbol};
yeastGO = [yeastAnnot.GOid];
yeastAspect = {yeastAnnot.Aspect};

%odfiltrowanie
mask = strcmp({yeastAnnot.Aspect},'P');

yeastGenes_BP=yeastGenes(mask);
yeastGO_BP=yeastGO(mask);

for clusterNo = 1:10
    [GOTerms{clusterNo} clusterGOTermsNo{clusterNo} chipGOTermsNo{clusterNo}]=getClusterGOTerms (GO, yeastGenes_BP,yeastGO_BP,genes,chipgenes,clusterNo,clusters);
end

for clusterNo = 1:10
    [GOTerms_k{clusterNo} clusterGOTermsNo_k{clusterNo} chipGOTermsNo_k{clusterNo}]=getClusterGOTerms (GO, yeastGenes_BP,yeastGO_BP,genes,chipgenes,clusterNo,cidx);
end


% %% pVal dla hierarchiczn.
% %M-zbiór wszystkich elem do losow.
% %K-iloœæ wszystkich genów opisanych terminem GO;
% %N-iloœæ genów w klastrze;
% %x-iloœæ skucesów = ilosc genów opisanycg w analizowanym klastrze term. GO;
% for j=1:10
%     x=clusterGOTermsNo{j};
%     M=size(chipgenes);
%     M=M(1);
%     N=length(clusters(clusters==j));
%     K=chipGOTermsNo{j};
%     
%     pVal{j}=1-hygecdf(x-1,M,K,N);
%     
% end
% 

%% PVal dla k-sr
% 
% for k=1:10
%     x=clusterGOTermsNo_k{k};
%     M=size(chipgenes);
%     M=M(1);
%     N=length(cidx(cidx==k));
%     K=chipGOTermsNo_k{k};
%     
%     pVal_k{k}=1-hygecdf(x-1,M,K,N);
%     
% end

%% zad 7

%GO(16874).Term.definition;
%GO(16874).Term.name;
%GO(16874).Term.synonym;
%GO(16874).Term.is_a;
%GO(16874).Term.part_of;
%% zad 8 raport
fid=fopen('raport','w');
fprintf(fid,'Raport z Laboratorium Bioinformatyki nr 1 i 2\n\n');
name='Szymon Kocot';
name2='Wojciech Opoczyñski';
name3='£ukasz Witek';
name4='Alexandra Zaj¹c';
fprintf(fid,'Imiê i Nazwisko: %s \n',name,name2,name3,name4);
fprintf(fid,'Data %s\n\n',datestr(now));
method='klastrowanie hierarchiczne';
fprintf(fid,'Metoda klastrowania: %s\n',method);
for j=1:10      %tutaj zaczyna siê obliczanie pVal na klastrowanie
    x=clusterGOTermsNo{j};
    M=size(chipgenes);
    M=M(1);
    N=length(clusters(clusters==j));
    K=chipGOTermsNo{j};
    
    pVal{j}=1-hygecdf(x-1,M,K,N);
%koniec obliczeñ pVal na klastry 
    term = sort(pVal{j});
    name=GOTerms{j};
    wklastrze=clusterGOTermsNo{j};
    calkowicie=chipGOTermsNo{j};
    fid=fopen('raport','a');
    raport = sprintf('GO Term		p-val		clusterNo/chipNo		geneName		definition\n');
    klaster=j;
    fprintf(fid,'\nNumer klastra: %d\n',klaster);
    fprintf(fid,'%s\n',raport);

        for k=1:length(term)
            if term(k)<0.05
            ratio=sprintf('%d / %d',wklastrze(k),calkowicie(k));
            tekst = sprintf('%s\t\t%-1.4f \t\t%+10s \t\t\t\t%s \t\t\t\t\t\t%-10s\n', ...
                        char(num2goid(name(k))), term(k), ratio,...
                        GO(name(k)).Term.name,GO(name(k)).Term.definition);
            fprintf(fid,tekst);
        end
        end
end
fclose(fid);
fid=fopen('raport','a');
fprintf(fid,'\n**********************************************************************************************************\n\n');
method2='k-srednich';
fprintf(fid,'k-srednich: %s\n',method2);
%obliczenie pVal na k srednich
for m=1:10
    x=clusterGOTermsNo_k{m};
    M=size(chipgenes);
    M=M(1);
    N=length(cidx(cidx==m));
    K=chipGOTermsNo_k{m};
    
    pVal_k{m}=1-hygecdf(x-1,M,K,N);
    %koniec obliczenia pval ksrednich
    term = sort(pVal_k{m});
    name=GOTerms_k{m};
    wklastrze=clusterGOTermsNo_k{m};
    calkowicie=chipGOTermsNo_k{m};
    fid=fopen('raport','a');
    raport = sprintf('GO Term           p-val      clusterNo/chipNo        geneName                   definition\n');
    klaster=m;
    fprintf(fid,'\nNumer klastra: %d\n',klaster);
    fprintf(fid,'%s\n',raport);
        for l=1:length(term)
            if term(l)<0.05
            ratio_k=sprintf('%d / %d',wklastrze(l),calkowicie(l));
            tekst_k= sprintf('%s\t\t%-1.4f \t\t%+10s \t\t\t\t%s \t\t\t\t\t\t%-10s\n', ...
                        char(num2goid(name(l))), term(l), ratio_k,...
                        GO(name(l)).Term.name,GO(name(l)).Term.definition);
            fprintf(fid,tekst_k);
        end
        end
end
fclose(fid);

%% zadanie 9
a=[0006278 0006508 0006515 0006623 0006810];
subGO = GO(getancestors(GO, a));
[cm acc rels] = getmatrix(subGO);
BG = biograph(cm,get(subGO.Terms,'name'))
for i=1:numel(acc)
    pval = pVal(acc(i));
    color = [(1-pVal).^(10),pVal.^(1/10),0.3];
    set(BG.Nodes(i),'Color',color);
end
view(BG)