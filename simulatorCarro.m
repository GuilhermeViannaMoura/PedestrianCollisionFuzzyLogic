close all
clear all

fis = readfis('risco.fis');

% Tamanho da janela
yi=0; yf=1;
xi=0; xf=100;

% Plotagem da janela
xlim([0 100]); % TROCAR PRA 100?
ylim([0 1]);
Axis = ([xi xf yi yf]);
plot([xi xf xf xi xi],[yi yi yf yf yi]);
hold on; % usado sempre para manter o que já foi desenhado no gráfico

t = 0; %tempo

fprintf('##########################\n');
fprintf('#### RISCO DE COLISÃO ####\n');
fprintf('##########################\n \n');

%fprintf('DEFINA AS VARIÁVEIS INICIAIS:\n');
VelocidadeCarro = input('Velocidade do carro  0 <= x <= 150\n-> ');
xp = input('Posicao x inicial do pedestre 0 <= x <= 100\n-> '); % ADICIONAR OPCAO PARA MAIS PEDESTRES SE DER TEMPO
yp = 0.45;
xc = 0;   % x inicial do carro
yc = 0.45; % y inicial do carro (faixa da direita)

DistanciaRelativa = xp - xc;
inputs = [VelocidadeCarro;DistanciaRelativa];

opcao = 2; % FAZER INPUT
switch opcao
    case 1 % GRAFICO
        title('Gráfico Tempo x RiscoDeColisão');
        xlabel('Tempo');
        ylabel('Risco de Colisão');
        hold on;
        for i=0:100
            plot_risco(i,fis,inputs);
            %t = t + 1;
            DistanciaRelativa = DistanciaRelativa - 1;
            inputs = [VelocidadeCarro;DistanciaRelativa];
        end
    case 2 % SIMULADOR
        title('Simulador');
        plot_pedestre(xp,yp);
        for i=0:100
            xc = xc + 1;
            DistanciaRelativa = xp - xc;
            if DistanciaRelativa > 0
                inputs = [VelocidadeCarro;DistanciaRelativa];
                RiscoColisao = evalfis(fis,inputs);
                if RiscoColisao >= 0.35 && RiscoColisao <= 0.75
                    yc = yc + 0.005; % AJUSTAR ESSE VALOR
                elseif RiscoColisao > 0.75
                    yc = yc + 0.01;
                end
                if yc >= 0.55
                    yc = 0.55;
                end
                plot_carro(xc,yc);
                hold on;
            else
                yc = yc - 0.005;
                if yc <= 0.45
                    yc = 0.45;
                end
                plot_carro(xc,yc);
                hold on;
            end
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