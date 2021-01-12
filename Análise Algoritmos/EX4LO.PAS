{
Bibliografia
  Pereira, Silvio do Lago - "Estruturas de Dados Fundamentais",
     S∆o Paulo: êrica,1996, pag. 109-117.
  Aho, Alfred V., Hopcroft, John E., Ullman, Jeffrey D. - "Data Structures
     and Algorithms", Massachussets: Addison-Wesley, pag. 37-43.

         Programa elaborado por Carlos Abreu 126749 11o EN

         Demonstra os tempos de inserá∆o e remoá∆o de items em
         Lista Ordenadas
}

Program Ex4;

uses
    crt,dos;

{ Declara o tamanho maximo do vetor }
const
     MAXIMO = 32760;

type
    tipo = longint;

    { Cria tipo Lista Ordenada }
    LO = record
       info:array [1..MAXIMO] of tipo;
       ultimo:word;
    end;

    { Cria o Tipo Para estatistica }
    St = record
       S,MS:string[3];
    end;
var
   key:char;
   ListOrd:LO;
   MAX:Word;


{ Verifica se a lista est† completa, se sim, retorna verdadeiro }
function Cheia(var Lista:LO):boolean;
begin
     if lista.ultimo>=MAX then
        Cheia:=true
     else
         cheia:=false;
end;

{ Verifica se a lista est† vazia, se sim, retorna verdadeiro }
function Vazia(Var Lista:LO):boolean;
begin
     if lista.ultimo<=0 then
        vazia:=true
     else
         vazia:=false;
end;

{ Busca Elemento em uma Lista retornando a posiá∆o relativa do elemento }
function busca(Var Lista:LO;Elemento:Tipo):tipo;
var
   i:word;
begin
     if vazia(Lista) then
        busca:=0
     else
         for i:=1 to lista.ultimo do
             if lista.info[i]>=Elemento then
                begin
                     busca:=i;
                     exit;
                end
             else
                 busca:=0;
end;

{ Insere um elemento a Lista, ordenando os valores de forma crescente }
procedure inserir(Var Lista:LO;Elemento:tipo);
var
   pos,i:word;
begin
     if cheia(Lista) then
        writeln('Lista Cheia')
     else
         begin
              pos:=busca(Lista,Elemento);
              if pos=0 then
                 pos:=lista.ultimo+1
              else
                  for i:=Lista.ultimo+1 downto pos do
                      lista.info[i]:=lista.info[i-1];
         end;
     Lista.info[pos]:=elemento;
     lista.ultimo:=lista.ultimo+1;
end;

{ Remove um Elemento da Lista, se o elemento n∆o existir, exibe uma mensagem }
procedure remover(var Lista:LO;Elemento:tipo);
var
   pos,i:word;
begin
    if Vazia(Lista) then
        exit {writeln('Lista Vazia');}
    else
        begin
             pos:=busca(Lista,Elemento);
             if pos=0 then
                exit {//writeln('Elemento n∆o encontrado')}
             else
                 begin
                      for i:=pos to lista.ultimo-1 do
                          lista.info[i]:=lista.info[i+1];
                      lista.ultimo:=lista.ultimo-1;
                 end;
        end;
end;

{ Inicia a lista com valores nulos(0) }
procedure LimpaLista(Var Lista:LO);
var
   i:word;
begin
     for i:=1 to MAX do
         lista.info[i]:=0;
     lista.ultimo:=0;
end;

{ Estatistica }
procedure stat;
var
   S:array[1..4] of ST;
   h1,h2,m1,m2,s1,s2,ms1,ms2:word;
   v:string;
   x,y:integer;
begin
     randomize;
     repeat
           clrscr;
           Write('Digite o tamanho da lista, com o minimo de 1 e no m†ximo de 32760 :');
           readln(v);
           Val(v,MAX,y);
     until (MAX<=100000) and (MAX>=1);

     writeln('Criando Estatistica, pode demorar algum tempo...');

{ Lista Ordenada }
{ Insere Aleat¢rio }
     LimpaLista(ListOrd);
     GetTime(h1,m1,s1,ms1);
     for y:=1 to Max do
         Inserir(ListOrd,Random(MAXIMO));
     GetTime(h2,m2,s2,ms2);
     if ms2<ms1 then
        ms1:=ms1-ms2
     else
         ms1:=ms2-ms1;
     if s2<s1 then
       s1:=s1-s2
     else
         s1:=s2-s1;
     if m2<m1 then
       m1:=m1-m2
     else
         m1:=m2-m1;
     h1:=h2-h1;
     s1:=s1+(m1*60)+(h1*3600);
     str(s1,s[1].s);
     str(ms1,s[1].ms);

{ Insere Ordenado }
     LimpaLista(ListOrd);
     GetTime(h1,m1,s1,ms1);
     for y:=1 to Max do
         Inserir(ListOrd,y);
     GetTime(h2,m2,s2,ms2);
     if ms2<ms1 then
        ms1:=ms1-ms2
     else
         ms1:=ms2-ms1;
     if s2<s1 then
       s1:=s1-s2
     else
         s1:=s2-s1;
     if m2<m1 then
       m1:=m1-m2
     else
         m1:=m2-m1;
     h1:=h2-h1;
     s1:=s1+(m1*60)+(h1*3600);
     str(s1,s[2].s);
     str(ms1,s[2].ms);

{ Insere Decrescente }
     LimpaLista(ListOrd);
     GetTime(h1,m1,s1,ms1);
     x:=MAX;
     for y:=1 to Max do
         begin
              Inserir(ListOrd,x);
              x:=x-1;
         end;
     GetTime(h2,m2,s2,ms2);
     if ms2<ms1 then
        ms1:=ms1-ms2
     else
         ms1:=ms2-ms1;
     if s2<s1 then
       s1:=s1-s2
     else
         s1:=s2-s1;
     if m2<m1 then
       m1:=m1-m2
     else
         m1:=m2-m1;
     h1:=h2-h1;
     s1:=s1+(m1*60)+(h1*3600);
     str(s1,s[3].s);
     str(ms1,s[3].ms);

{ Remoá∆o }
     GetTime(h1,m1,s1,ms1);
     for y:=1 to Max do
         Remover(ListOrd,Random(MAX));
     GetTime(h2,m2,s2,ms2);
     if ms2<ms1 then
        ms1:=ms1-ms2
     else
         ms1:=ms2-ms1;
     if s2<s1 then
       s1:=s1-s2
     else
         s1:=s2-s1;
     if m2<m1 then
       m1:=m1-m2
     else
         m1:=m2-m1;
     h1:=h2-h1;
     s1:=s1+(m1*60)+(h1*3600);
     str(s1,s[4].s);
     str(ms1,s[4].ms);
{ Fim Lista Ordenada }

{ Resultados }

     clrscr;
     str(Max,v);
     writeln('Estat°stica: Listas com '+v+' tamanho.');
	  writeln('Os dados est∆o no formato: Segundos : CentÇsimos de segundos');
     writeln('');
     writeln('Inserá∆o de Dados Aleat¢rios (Lista Ordenada):   '+s[1].s+' : '+s[1].ms);
     writeln('Inserá∆o de Dados Ordenados (Lista Ordenada):    '+s[2].s+' : '+s[2].ms);
     writeln('Inserá∆o de Dados Decrescente (Lista Ordenada):  '+s[3].s+' : '+s[3].ms);
     writeln('Remoá∆o de Dados (Lista Ordenada):               '+s[4].s+' : '+s[4].ms);
     writeln('');
     write('Digite uma tecla');
     readkey;
end;

begin

     repeat
           clrscr;
           writeln('1 - Inicia a estat°stica de Listas Ordenadas');
           writeln('0 - Encerrar Programa');
           key:=readkey;
           case key of
                '1':stat;

           end;
     until key='0';

end.
