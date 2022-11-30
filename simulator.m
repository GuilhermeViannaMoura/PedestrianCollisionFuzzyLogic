close all
clear all

fis = readfis('pedestrianCollision.fis');

% Tamanho da janela
yi=0; yf=1;
xi=0; xf=10;

% Plotagem da janela
xlim([0 10]); % TROCAR PRA 100?
ylim([0 1]);
Axis = ([xi xf yi yf]);
plot([xi xf xf xi xi],[yi yi yf yf yi]);
hold on; % usado sempre para manter o que já foi desenhado no gráfico

t = 0; %tempo

fprintf('##########################\n');
fprintf('#### RISCO DE COLISÃO ####\n');
fprintf('##########################\n \n');

fprintf('DEFINA AS VARIÁVEIS INICIAIS:\n');
VelocidadePedestre = input('Velocidade do pedestre  0 <= x <= 6\n-> ');
VelocidadeCarro = input('Velocidade do carro  0 <= x <= 150\n-> ');
Angulo = input('Angulo  0 <= x <= 180\n-> ');
%DistanciaRelativa = input('Distancia Relativa inicial  0 <= x <= 70\n-> ');
DistanciaRelativa = 100;
inputs = [VelocidadePedestre;Angulo;VelocidadeCarro;DistanciaRelativa];

opcao = 1;
switch opcao
    case 1 % GRAFICO
        title('Gráfico Tempo x RiscoDeColisão');
        xlabel('Tempo');
        ylabel('Risco de Colisão');
        hold on;
        for i=0:100
            plot_risco(t,fis,inputs);
            t = t + 0.1;
            DistanciaRelativa = DistanciaRelativa - 1;
            inputs = [VelocidadePedestre;Angulo;VelocidadeCarro;DistanciaRelativa];
        end
    case 2 % SIMULADOR
        title('Simulador');
        %FAZER SIMULADOR DO CARRO TOMANDO DECISAO A PARTIR DO MODELO FUZZY
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