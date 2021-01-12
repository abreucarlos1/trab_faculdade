{$APPTYPE CONSOLE}

program exe4le;

uses
  Windows,comctrls,SysUtils;



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

{ Declara o tamanho maximo do vetor }
const
     MAXIMO = 100000000;  //100 milhıes (10^8);

type
    tipo = longint;

    { Cria o tipo Lista Encadeada }

     LEnc=^le;
     LE = record
       info: tipo;
       prox:LEnc;
    end;

    { Cria o Tipo Para estatistica }
    St = record
       S:string[3];
    end;
var
   key:char;
   ListEnc:Lenc;
   MAX:longint;

procedure Mostra(var L:Lenc);
var
   list:Lenc;
   st:string;
begin
     list:=L;
     while (list^.prox<>nil) do
           begin
                st:=inttostr(list^.info);
                write(st+' ');
                List:=List^.prox;
           end;
end;

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
     if Null(L) {or (elemento<L^.info)} then
        begin
             N^.prox:=L;
             L:=N;
        end
     else
         begin
              P:=L;
              while (p^.prox<>nil) {and (Elemento>p^.prox^.info)} do
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
     if Null(L) {or (Elemento<L^.info)} then
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
                  while (p^.prox<>nil) {and (Elemento>p^.prox^.info)} do
                        P:=p^.prox;
                  if (p^.prox<>nil) {and (elemento=p^.prox^.info)} then
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
   v,m1,m2,s1,s2:string;
   min,sec:word;
   x,y:longint;
begin
     randomize;
     repeat
           Write('Digite o tamanho da lista, com o minimo de 1 e no m†ximo de 100000000 :');
           readln(v);
           Val(v,MAX,y);
     until (MAX<=100000000) and (MAX>=1);

     writeln('Criando Estatistica, pode demorar algum tempo...');

{ Lista Encadeada }
{ Insere AleatÛrio }
     Create(ListEnc);
     writeln('Inserindo dados aleatÛriamente');
     s1:=timetostr(time);
     for y:=1 to Max do
         Insert(ListEnc,Random(MAXIMO));
     s2:=timetostr(time);

     Kill(ListEnc);
     m1:=copy(s1,4,2);
     m2:=copy(s2,4,2);
     s1:=copy(s1,7,2);
     s2:=copy(s2,7,2);
     min:=strtoint(m2)-strtoint(m1);
     sec:=strtoint(s2)-strtoint(s1);
     sec:=sec+(min*60);
     S[1].s:=inttostr(sec);

{ Insere Ordenado }
     Create(ListEnc);
     writeln('Inserindo dados ordenadamente');
     s1:=timetostr(time);
     for y:=1 to Max do
         Insert(ListEnc,y);
     s2:=timetostr(time);


     Kill(ListEnc);
     m1:=copy(s1,4,2);
     m2:=copy(s2,4,2);
     s1:=copy(s1,7,2);
     s2:=copy(s2,7,2);
     min:=strtoint(m2)-strtoint(m1);
     sec:=strtoint(s2)-strtoint(s1);
     sec:=sec+(min*60);
     S[2].s:=inttostr(sec);

{ Insere Decrescente }
     Create(ListEnc);
     x:=MAX;
     writeln('Inserindo dados em ordem decrescente');
     s1:=timetostr(time);
     for y:=1 to Max do
         begin
              Insert(ListEnc,x);
              x:=x-1;
         end;
     s2:=timetostr(time);
  
     //Kill(ListEnc);
     m1:=copy(s1,4,2);
     m2:=copy(s2,4,2);
     s1:=copy(s1,7,2);
     s2:=copy(s2,7,2);
     min:=strtoint(m2)-strtoint(m1);
     sec:=strtoint(s2)-strtoint(s1);
     sec:=sec+(min*60);
     S[3].s:=inttostr(sec);

{ RemoÁ„o }
     //Create(ListEnc);
     writeln('Removendo dados aleatÛriamente');
     s1:=timetostr(time);
     for y:=1 to Max do
     //while not Null(ListEnc) do
         Del(ListEnc,Random(MAX));
     s2:=timetostr(time);
     
     Kill(ListEnc);
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
     writeln('Estat°stica: Listas com '+v+' tamanho.');
	  writeln('Os dados est∆o no formato: Segundos');
     writeln('');
     writeln('Inserá∆o de Dados Aleat¢rios (Lista Encadeada):   '+s[1].s+' segundos');
     writeln('Inserá∆o de Dados Ordenados (Lista Encadeada):    '+s[2].s+' segundos');
     writeln('Inserá∆o de Dados Decrescente (Lista Encadeada):  '+s[3].s+' segundos');
     writeln('Remoá∆o de Dados (Lista Encadeada):               '+s[4].s+' segundos');
     writeln('');
     write('Tecle [enter]');
     readln;
end;

begin

     repeat
           writeln('1 - Inicia a estat°stica de Listas Encadeadas');
           writeln('0 - Encerrar Programa');
           readln(key);
           case key of
                '1':stat;

           end;
     until key='0';

end.
