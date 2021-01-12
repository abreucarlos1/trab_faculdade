{$APPTYPE CONSOLE}

program exe4lo;

uses
  Windows,comctrls,SysUtils;



{
Bibliografia
  Pereira, Silvio do Lago - "Estruturas de Dados Fundamentais",
     SÆo Paulo: rica,1996, pag. 109-117.
  Aho, Alfred V., Hopcroft, John E., Ullman, Jeffrey D. - "Data Structures
     and Algorithms", Massachussets: Addison-Wesley, pag. 37-43.

         Programa elaborado por Carlos Abreu 126749 11o EN

         Demonstra os tempos de inser‡Æo e remo‡Æo de items em
         Lista Ordenadas
}


{ Declara o tamanho maximo do vetor }
const
     MAXIMO = 100000000; //100 milhões (10^8)

type
    tipo = longint;

    { Cria tipo Lista Ordenada }
    LO = record
       info:array [1..MAXIMO] of tipo;
       ultimo:word;
    end;

    { Cria o Tipo Para estatistica }
    St = record
       S:string[3];
    end;
var
   key:char;
   ListOrd:LO;
   MAX:longint;


{ Verifica se a lista está  completa, se sim, retorna verdadeiro }
function Cheia(var Lista:LO):boolean;
begin
     if lista.ultimo>=MAX then
        Cheia:=true
     else
         cheia:=false;
end;

{ Verifica se a lista está  vazia, se sim, retorna verdadeiro }
function Vazia(Var Lista:LO):boolean;
begin
     if lista.ultimo<=0 then
        vazia:=true
     else
         vazia:=false;
end;

{ Busca Elemento em uma Lista retornando a posição relativa do elemento }
function busca(Var Lista:LO;Elemento:Tipo):tipo;
var
   i:longint;
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
   pos,i:longint;
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

{ Remove um Elemento da Lista, se o elemento não existir, exibe uma mensagem }
procedure remover(var Lista:LO;Elemento:tipo);
var
   pos,i:longint;
begin
    if Vazia(Lista) then
        exit {writeln('Lista Vazia');}
    else
        begin
             pos:=busca(Lista,Elemento);
             if pos=0 then
                exit {writeln('Elemento nÆo encontrado')}
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
   i:longint;
begin
     for i:=1 to MAX do
         lista.info[i]:=0;
     lista.ultimo:=0;
end;

{ Estatistica }
procedure stat;
var
   S:array[1..4] of ST;
   v,m1,m2,s1,s2:string;
   min,sec:word;
   x,y:longint;
begin
     randomize;
     repeat
           Write('Digite o tamanho da lista, com o minimo de 1 e no m ximo de 100000000 :');
           readln(v);
           Val(v,MAX,y);
     until (MAX<=100000000) and (MAX>=1);

     writeln('Criando Estatistica, pode demorar algum tempo...');

{ Lista Ordenada }
{ Insere Aleatório }
     LimpaLista(ListOrd);
     writeln('Inserindo dados aleatóriamente');
     s1:=timetostr(time);
     for y:=1 to Max do
         Inserir(ListOrd,Random(MAXIMO));
     s2:=timetostr(time);
     m1:=copy(s1,4,2);
     m2:=copy(s2,4,2);
     s1:=copy(s1,7,2);
     s2:=copy(s2,7,2);
     min:=strtoint(m2)-strtoint(m1);
     sec:=strtoint(s2)-strtoint(s1);
     sec:=sec+(min*60);
     S[1].s:=inttostr(sec);

{ Insere Ordenado }
     LimpaLista(ListOrd);
     writeln('Inserindo dados Ordenadamente');
     s1:=timetostr(time);
     for y:=1 to Max do
         Inserir(ListOrd,y);
     s2:=timetostr(time);
     m1:=copy(s1,4,2);
     m2:=copy(s2,4,2);
     s1:=copy(s1,7,2);
     s2:=copy(s2,7,2);
     min:=strtoint(m2)-strtoint(m1);
     sec:=strtoint(s2)-strtoint(s1);
     sec:=sec+(min*60);
     S[2].s:=inttostr(sec);

{ Insere Decrescente }
     LimpaLista(ListOrd);
     x:=MAX;
     writeln('Inserindo dados em ordem decrescente');
     s1:=timetostr(time);
     for y:=1 to Max do
         begin
              Inserir(ListOrd,x);
              x:=x-1;
         end;
     s2:=timetostr(time);
     m1:=copy(s1,4,2);
     m2:=copy(s2,4,2);
     s1:=copy(s1,7,2);
     s2:=copy(s2,7,2);
     min:=strtoint(m2)-strtoint(m1);
     sec:=strtoint(s2)-strtoint(s1);
     sec:=sec+(min*60);
     S[3].s:=inttostr(sec);

{ Remoção }
     s1:=timetostr(time);
     writeln('Removendo dados aleatóriamente');
     //for y:=1 to Max do
     while not Vazia(ListOrd) do
         Remover(ListOrd,Random(MAX));
     s2:=timetostr(time);
     m1:=copy(s1,4,2);
     m2:=copy(s2,4,2);
     s1:=copy(s1,7,2);
     s2:=copy(s2,7,2);
     min:=strtoint(m2)-strtoint(m1);
     sec:=strtoint(s2)-strtoint(s1);
     sec:=sec+(min*60);
     S[4].s:=inttostr(sec);
{ Fim Lista Ordenada }

{ Resultados }
     str(Max,v);
     writeln('Estat¡stica: Listas com '+v+' tamanho.');
	  writeln('Os dados estÆo no formato: Segundos');
     writeln('');
     writeln('Inser‡Æo de Dados Aleat¢rios (Lista Ordenada):   '+s[1].s+' segundos');
     writeln('Inser‡Æo de Dados Ordenados (Lista Ordenada):    '+s[2].s+' segundos');
     writeln('Inser‡Æo de Dados Decrescente (Lista Ordenada):  '+s[3].s+' segundos');
     writeln('Remo‡Æo de Dados (Lista Ordenada):               '+s[4].s+' segundos');
     writeln('');
     write('Tecle [enter]');
     readln;
end;

begin

     repeat
           writeln('1 - Inicia a estat¡stica de Listas Ordenadas');
           writeln('0 - Encerrar Programa');
           readln(key);
           case key of
                '1':stat;

           end;
     until key='0';

end.
