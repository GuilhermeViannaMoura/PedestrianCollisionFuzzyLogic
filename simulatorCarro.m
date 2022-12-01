close all
clear all

fis = readfis('desvio.fis');
fis2 = readfis('risco.fis');

% Tamanho da janela
yi=0; yf=100;
xi=0; xf=300;

% Plotagem da janela
xlim([0 xf]);
ylim([0 yf]);
Axis = ([xi xf yi yf]);
plot([xi xf xf xi xi],[yi yi yf yf yi]);
hold on; % usado sempre para manter o que já foi desenhado no gráfico

% Plotagem dos limites da rua
xl = [xi,xf];
plot(xl,[60,60],'k');
plot(xl,[50,50],'k--');
plot(xl,[40,40],'k');

%t = 0; %tempo

fprintf('##########################\n');
fprintf('#### EVITANDO COLISÃO ####\n');
fprintf('##########################\n \n');

fprintf('DEFINA AS VARIÁVEIS INICIAIS:\n');
%VelocidadeCarro = input('Velocidade do carro  0 <= x <= 150\n-> ');
xp = input('Posicao x inicial do pedestre 0 <= x <= 300\n-> ');
pistaP = input('Em qual pista o pedestre está? esquerda(1) ou direita(2)\n-> ');
pistaC = input('Em qual pista o carro está? esquerda(1) ou direita(2)\n-> ');
if pistaP == 1
    yp = 55;
elseif pistaP == 2
    yp = 45;
else
    fprintf('Escolha uma opção válida.');
end
if pistaC == 1
    yc = 55;
elseif pistaC == 2
    yc = 45;
else
    fprintf('Escolha uma opção válida.');
end
%yp = 50; % y inicial do pedestre
xc = 0;  % x inicial do carro
%yc = 55; % y inicial do carro

DistanciaRelativa = xp - xc;
DistanciaLateral = yc - yp;
inputs = [DistanciaRelativa,DistanciaLateral,yc];

opcao = 2; % FAZER INPUT
switch opcao
    case 1 % GRAFICO DO OUTPUT (NAO TA FUNCIONANDO)
        title('Gráfico Tempo x RiscoDeColisão');
        xlabel('Tempo');
        ylabel('Risco de Colisão');
        hold on;
        DistanciaRelativa = xp - xc;
        inputs = [VelocidadeCarro;DistanciaRelativa];
        for i=0:xf
            plot_risco(i,fis2,inputs);
            %t = t + 1;
            DistanciaRelativa = DistanciaRelativa - 1;
            inputs = [VelocidadeCarro;DistanciaRelativa];
        end
    case 2 % SIMULADOR
        title('Simulador');
        plot_pedestre(xp,yp);
        for i=0:xf
            xc = xc + 1;
            if xc > xf
                xc = xf; % corrige um bug que mostrava alguns pontos dps do fim do gráfico
            end
            DistanciaRelativa = xp - xc;
            DistanciaLateral = yc - yp;
            if DistanciaRelativa > 0
                inputs = [DistanciaRelativa,DistanciaLateral,yc];
                desvio = evalfis(fis,inputs);
                yc = yc + desvio;
            else % volta para posicao original dps de ultrapassar o obstaculo
                inputs = [abs(DistanciaRelativa),DistanciaLateral,yc];
                desvio = evalfis(fis,inputs);
                yc = yc - desvio;
            end

            if yc >= 55
                yc = 55;
            end
            if yc <= 45
                yc = 45;
            end
            plot_carro(xc,yc);
            hold on;
        end
end

function plot_risco(passo,f,in)
    RiscoColisao = evalfis(f,in);
    if RiscoColisao < 0.25
        cor = 'go';
    end
    if RiscoColisao >= 0.25 && RiscoColisao <= 0.75
        cor = 'yo';
    end
    if RiscoColisao > 0.75
        cor = 'ro';
    end
    plot(passo,RiscoColisao,cor);
    hold on;
end
function plot_carro(x,y)
    plot(x,y,'ko');
end
function plot_pedestre(posX,posY)
    plot(posX,posY,'ro');
end