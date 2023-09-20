% Duomenu inicializacija
x1 = [0.21835, 0.14115, 0.37022, 0.31565, 0.36484, 0.46111, 0.55223, 0.16975, 0.49187, 0.14913, 0.18474, 0.08838, 0.098166];
x2 = [0.81884, 0.83535, 0.8111, 0.83101, 0.8518, 0.82518, 0.83449, 0.84049, 0.80889, 0.77104, 0.6279, 0.62068, 0.79092];
T = [1, 1, 1, 1, 1, 1, 1, 1, 1, -1, -1, -1, -1];

% Vidurkiu ir standartinio nuokrypio skaiciavimas
x1TeigiamuRezultatuVidurkis = mean(x1(T == 1));
x1TeigiamuRezulatuNuokrypis = std(x1(T == 1));

x2TeigiamuRezultatuVidurkis = mean(x2(T == 1));
x2TeigiamuRezulatuNuokrypis = std(x2(T == 1));

x1NeigiamuRezultatuVidurkis = mean(x1(T == -1));
x1NeigiamuRezulatuNuokrypis = std(x1(T == -1));

x2NeigiamuRezultatuVidurkis = mean(x2(T == -1));
x2NeigiamuRezulatuNuokrypis = std(x2(T == -1));

% Rezultatu tikrinimas
for indx = 1:13
    dabartinisX1 = x1(indx);
    dabartinisX2 = x2(indx);

    % Tikimybiu skaiciavimas pagal Gausian Naive Bias formules
    teigiamoRezultatoTikimybeX1 = (1 / (sqrt(2 * pi) * x1TeigiamuRezulatuNuokrypis)) * exp(-((dabartinisX1 - x1TeigiamuRezultatuVidurkis)^2) / (2 * x1TeigiamuRezulatuNuokrypis^2));
    teigiamoRezultatoTikimybeX2 = (1 / (sqrt(2 * pi) * x2TeigiamuRezulatuNuokrypis)) * exp(-((dabartinisX2 - x2TeigiamuRezultatuVidurkis)^2) / (2 * x2TeigiamuRezulatuNuokrypis^2));

    neigiamoRezultatoTikimybeX1 = (1 / (sqrt(2 * pi) * x1NeigiamuRezulatuNuokrypis)) * exp(-((dabartinisX1 - x1NeigiamuRezultatuVidurkis)^2) / (2 * x1NeigiamuRezulatuNuokrypis^2));
    neigiamoRezultatoTikimybeX2 = (1 / (sqrt(2 * pi) * x2NeigiamuRezulatuNuokrypis)) * exp(-((dabartinisX2 - x2NeigiamuRezultatuVidurkis)^2) / (2 * x2NeigiamuRezulatuNuokrypis^2));

    teigiamoRezultatoTikimybe = sum(T == 1) / length(T);
    neigiamoRezultatoTikimuybe = sum(T == -1) / length(T);

    parametraisPagrystaTeigiamoRezultatoTikimybe = teigiamoRezultatoTikimybeX1 * teigiamoRezultatoTikimybeX2;
    parametraisPagrystaNeigiamoRezultatoTikimybe = neigiamoRezultatoTikimybeX1 * neigiamoRezultatoTikimybeX2;

    % Darom prognoze pagal gautus rezultatus
    prognuozojamaTeigiamoRezultatoTikimybe = parametraisPagrystaTeigiamoRezultatoTikimybe * teigiamoRezultatoTikimybe;
    prognuozojamaNeigiamoRezultatoTikimybe = parametraisPagrystaNeigiamoRezultatoTikimybe * neigiamoRezultatoTikimuybe;

    if prognuozojamaTeigiamoRezultatoTikimybe > prognuozojamaNeigiamoRezultatoTikimybe
        rezultatas = 1;
    else
        rezultatas = -1;
    end
    fprintf('x1: %d, x2: %d, T: %d, Prediction: %d\n', dabartinisX1, dabartinisX2, T(indx), rezultatas);
end
