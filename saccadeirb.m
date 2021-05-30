%% Initialisation
clear all
close all
clc

%% Declaration des variables
nb_section = 25;

%% Importation de l'image
file = uigetfile('*.*');
[path, name, ext] = fileparts(file);
img_og = uint8(imread(file));
[ h,w,z ] = size(img_og); % Taille de l'image

%% Traitement
size_section = round(w / nb_section);
if mod(size_section,2) == 1
    size_section = size_section + 1;
end
demi_section = size_section / 2;
mleft  = 1;
mright = size_section;
mleft_final  = 1;
mright_final = size_section;

for i = 0:nb_section*2-3
    img_section = img_og(:, mleft:mright, :);
    final_img(:,mleft_final:mright_final,:) = img_section;
    mleft  = mleft+demi_section;
    mright = mright+demi_section;
    if i == 0
        mleft_final = 0;
    end
    mleft_final  = mleft_final + size_section;
    mright_final = mleft_final + size_section-1;
end

%% Exportation de l'image
final_img = imresize(final_img, [h w]);
name_final = sprintf('%s.png', name);

suf = 1;
while isfile(name_final) == 1
    name_final = sprintf('%s_%d.png', name, suf);
    suf = suf + 1;
end

imwrite(final_img, name_final)

fprintf('%s exported\n', name_final)