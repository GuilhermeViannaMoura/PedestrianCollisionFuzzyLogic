close all
clear all

fis = readfis('pedestrianCollision.fis');

% Tamanho da janela
yi=0; yf=1;
xi=0; xf=10;

% Plotagem da janela
title('Simulador'); % VAI DEPENDER DO MODELO ESCOLHIDO
xlabel('Tempo');
ylabel('Risco de Colisão');
xlim([0 10]); % TROCAR PRA 100?
ylim([0 1]);
Axis = ([xi xf yi yf]);
plot([xi xf xf xi xi],[yi yi yf yf yi]);
hold on; % usado sempre para manter o que já foi desenhado no gráfico

% Variaveis para plotagem do robo na parede lateral esquerda (posicao inicial)
r = 0.1;      % Raio do robo
xc = r;     % Abscissa do robo igual ao raio para que ele parta colado a parede
%yc = 0.5;    % receber do usuário
%plot_circle(xc,yc,r,'k'); % primeiro plot em preto pois ainda não foi calculado o risco de colisao
%hold on;
%plot_circle(xc+10,yc,r,'r');
%hold on;

fprintf('##########################\n');
fprintf('#### RISCO DE COLISÃO ####\n');
fprintf('##########################\n \n'); % FAZER VARIOS MODELOS ONDE CADA UM IRA ALTERAR DE FORMA DIFERENTE UMA VARIAVEL COM O TEMPO(EX: CARRO ACELERANDO OU DESACELERANDO)
fprintf('DEFINA AS VARIÁVEIS INICIAIS:\n');
VelocidadePedestre = input('Velocidade do pedestre no intervalo 0 <= x <= 6\n-> ');
VelocidadeCarro = input('Velocidade do carro no intervalo 0 <= x <= 150\n-> ');
Angulo = input('Angulo no intervalo 0 <= x <= 180\n-> ');
DistanciaRelativa = input('Distancia Relativa inicial no intervalo 0 <= x <= 70\n-> ');

inputs = [VelocidadePedestre;Angulo;VelocidadeCarro;DistanciaRelativa];
RiscoColisao = evalfis(fis,inputs);
cor = 'ro'; % DEPENDE DO OUTPUT
plot(1,RiscoColisao,cor);
%plot_circle(xc,RiscoColisao,r,'r');
hold on;
