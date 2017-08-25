function [GOTerms custerGOTermsNo chipGOTermsNo]=getClusterGOTerms(GO,yeastGenes,yeastGO,genes,chipgenes,clusterNo,clusters)

m = GO.Terms(end).id;           %pobierz identyfikator ostatniego termina
geneschipcount = zeros(m,1);    % wektor zawierajacy liczbe terminow  GO dla calej mikromacierzy
genesclustercount = zeros(m,1); % wektor zawierajacy liczbe terminow  GO dla analizowanego klastra



%zmienna logiczna zawierajaca indeksy konkretnego klastra
clusterIdx = (clusters==clusterNo);
clusterGenes=genes(clusterIdx);

%liczba terminow GO dla calego chip-a
for i = 1:numel(chipgenes)                
    idx = strcmpi(yeastGenes,chipgenes{i});        
    goID=yeastGO(idx);
    geneschipcount(goID) = geneschipcount(goID) + 1;
end

%liczba  terminow GO dla calego klastra
for i = 1:numel(clusterGenes)                
    idx = strcmpi(yeastGenes,clusterGenes{i});        
    goID=yeastGO(idx);
    genesclustercount(goID) = genesclustercount(goID) + 1;
end

GOTerms=find(genesclustercount);
custerGOTermsNo=genesclustercount(GOTerms);
chipGOTermsNo=geneschipcount(GOTerms);

