%To install, just unzip FullBNT.zip, start MATLAB, and then add BNT to your path.

%You can go to File->Set_Path, and then click on "Add Folder with Subfolders" and select the bnt folder. Or you can cd to the directory containing BNT and execute the following
%installation de la toolbox BNT et la tester:
cd /Users/benjamindallard/Desktop/TP 2 IA/Probleme 1 % modify as needed
addpath(genpathKPM(pwd))
test_BNT
%% Réseau Bayésiens
% Diagnostics médicaux contradictoires
% Un patient craint d?être atteint du cancer et estime à 10 % la probabilité d?être
% atteint. Il consulte un médecin A qui ne diagnostique pas le cancer. Pensant que le
% médecin A s?est peut-être trompé ou a été trop prudent dans son diagnostic, il
% consulte un second médecin B qui lui, diagnostique le cancer.
% On suppose que :
% - le médecin A émet un diagnostic correct dans seulement 60 % des cas 
% où il y a effectivement cancer mais ne se trompe jamais lorsqu?il n?y a pas de
% cancer ;
% - le médecin B émet un diagnostic correct dans 80 % des cas où il y a
% effectivement cancer et se trompe une fois sur dix lorsqu?il n?y a pas de
% cancer.

%donc on a :
%P(C)=0.1; P(C_)=0.0; 
%P(A/C)=0.6 ; P(A_/C)=0.4 ; P(A/C_)=0 ;P(A_/C_)=1 
%P(B/C)=0.8 ; P(B_/C)=0.2 ; P(B/C_)=0.1 ;P(B_/C_)=0.9

% À combien le patient peut-il estimer la probabilité de cancer avant et après le
% diagnostic du second médecin ? 

%On cherche donc : P(C/A_) etP(C/(B et A_))

%Graph structure
N = 3; 
dag = zeros(N,N);
C=1; A = 2; B=3; 
dag(C,B) = 1;
dag(C,A) = 1;

%Visualisation du graph : 
G = bnet.dag;
draw_graph(G);

%Creating the Bayes net shell
discrete_nodes = 1:N;
node_sizes = 2*ones(1,N); 

bnet = mk_bnet(dag, node_sizes);

bnet.CPD{C} = tabular_CPD(bnet, C, [0.9 0.1]);
bnet.CPD{A} = tabular_CPD(bnet, A, [1 0.4 0 0.6]);
bnet.CPD{B} = tabular_CPD(bnet, B, [0.9 0.2 0.1 0.6]);

engine = jtree_inf_engine(bnet);

evidence = cell(1,N);

evidence{A} = 1;

[engine, loglik] = enter_evidence(engine, evidence);

marg = marginal_nodes(engine, C);
p_c_a = marg.T(2)

evidence{B} = 2;
[engine, loglik] = enter_evidence(engine, evidence);
marg = marginal_nodes(engine, C);
p_c_ab= marg.T(2)

bar(marg.T)