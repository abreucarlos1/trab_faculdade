{
Bibliografia
  Pereira, Silvio do Lago - "Estruturas de Dados Fundamentais",
     S∆o Paulo: êrica,1996, pag. 109-117.
  Aho, Alfred V., Hopcroft, John E., Ullman, Jeffrey D. - "Data Structures
     and Algorithms", Massachussets: Addison-Wesley, pag. 37-43.

         Programa elaborado por Carlos Abreu 126749 11o EN

         Demonstra os tempos de inserá∆o e remoá∆o de items em
         Listas Encadeadas
}

Program Ex42;

uses
    CRT,Dos;

{ Declara o tamanho maximo do vetor }
const
     MAXIMO = 100000;

type
    tipo = Word;

    { Cria o tipo Lista Encadeada }

     LEnc=^le;
     LE = record
       info: tipo;
       prox:LEnc;
    end;

    { Cria o Tipo Para estatistica }
    St = record
       S,MS:string[3];
    end;
var
   key:char;
   ListEnc:Lenc;
   MAX:Word;

{ Cria uma Lista Encadeada Vazia }
procedure Create(var L:Lenc);
begin
     L:=nil;
end;

{ Verifica se a Lista Encadeada est† vazia }
function Null(L:LEnc):boolean;
begin
     Null:=(L=nil);
end;

{ Insere Elemento  na Lista Encadeada }
procedure insert(var L:LEnc;Elemento:tipo);
var
   N,P:Lenc;
begin
     new(N);
     N^.info:=Elemento;
     if Null(L) or (elemento<L^.info) then
        begin
             N^.prox:=L;
             L:=N;
        end
     else
         begin
              P:=L;
              while (p^.prox<>nil) and (Elemento>p^.prox^.info) do
                    p:=p^.prox;
              N^.prox:=P^.prox;
              P^.prox:=N;
         end;
end;

{ Remove o Elemento da Lista Encadeada }
function Del(var L:Lenc;Elemento:tipo):boolean;
var
   P,Q:Lenc;
begin
     if Null(L) or (Elemento<L^.info) then
        Del:=false
     else
         if Elemento=L^.info then
            begin
                 P:=l;
                 L:=L^.prox;
                 dispose(p);
                 del:=true;
            end
         else
             begin
                  P:=l;
                  while (p^.prox<>nil) and (Elemento>p^.prox^.info) do
                        P:=p^.prox;
                  if (p^.prox<>nil) and (elemento=p^.prox^.info) then
                     begin
                          q:=p^.prox;
                          p^.prox:=q^.prox;
                          dispose(q);
                          del:=true;
                     end
                  else
                      del:=false;
             end;
end;

{ Procura Elemento em Lista Encadeada }
function procura(var L:Lenc;Elemento:tipo):Lenc;
var
   p:lenc;
begin
     p:=l;
     while (p<>nil) and (elemento>p^.info) do
           P:=p^.prox;
     if (p<>nil) and (elemento=p^.info) then
        procura:=p
     else
         procura:=nil;
end;

{ Destroi a lista encadeada }
procedure kill(var L:Lenc);
var
   p:Lenc;
begin
     while L<>nil do
           begin
                P:=l;
                L:=L^.prox;
                dispose(p);
           end;
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
           Write('Digite o tamanho da lista, com o minimo de 1 e no m†ximo de 100000 :');
           readln(v);
           Val(v,MAX,y);
     until (MAX<=100000) and (MAX>=1);

     writeln('Criando Estatistica, pode demorar algum tempo...');


{ Lista Encadeada }
{ Cria Lista Encadeada}
     create(ListEnc);

{ Inserir Aleat¢rio }
     GetTime(h1,m1,s1,ms1);
     for y:=1 to Max do
         Insert(ListEnc,Random(MAXIMO));
     GetTime(h2,m2,s2,ms2);
     kill(ListEnc);
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

{ Cria Lista Encadeada }
     Create(ListEnc);

{Insere Ordenado }
     GetTime(h1,m1,s1,ms1);
     for y:=1 to Max do
         Insert(ListEnc,y);
     GetTime(h2,m2,s2,ms2);
     kill(ListEnc);
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

{ Cria Lista Encadeada }
     Create(ListEnc);

{Insere Decrescente }
     x:=Max;
     GetTime(h1,m1,s1,ms1);
     for y:=1 to Max do
         begin
              Insert(ListEnc,x);
              x:=x-1;
         end;
     GetTime(h2,m2,s2,ms2);
     Kill(ListEnc);
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
         Del(ListEnc,Random(MAX));
     GetTime(h2,m2,s2,ms2);
     Kill(ListEnc);
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
{ Fim Lista Encadeada }

{ Resultados }

     clrscr;
     str(Max,v);
     writeln('Estat°stica: Listas com '+v+' tamanho.');
	  writeln('Os dados est∆o no formato: Segundos : CentÇsimos de segundos');
     writeln('');
     writeln('Inserá∆o de Dados Aleat¢rios (Lista Encadeada):  '+s[1].s+' : '+s[1].ms);
     writeln('Inserá∆o de Dados Ordenados (Lista Encadeada):   '+s[2].s+' : '+s[2].ms);
     writeln('Inserá∆o de Dados Decrescente (Lista Encadeada): '+s[3].s+' : '+s[3].ms);
     writeln('Remoá∆o de Dados (Lista Encadeada):              '+s[4].s+' : '+s[4].ms);
     writeln('');
     write('Digite uma tecla');
     readkey;
end;

begin

     repeat
           clrscr;
           writeln('1 - Inicia a estat°stica de Listas Encadeadas');
           writeln('0 - Encerrar Programa');
           key:=readkey;
           case key of
                '1':stat;

           end;
     until key='0';

end.