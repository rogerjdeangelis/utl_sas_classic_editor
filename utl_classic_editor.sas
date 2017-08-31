* package c:\oto\utl_perpac.sas;

* either put this in member c:/oto/utl_perpac.sas and add
  '%include c:/oto/utl_perpac.sas;' in your autoexec
  or load each member into your autocall library;



%macro cuth/cmd;
  %do i=1 %to 20;
    c '  ' ' ' all;
  %end;
%mend cuth;

%macro proch / cmd;
   store;note;notesubmit '%procha;';
   run;
%mend proch;

%macro procha;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     cmd=cats('filename _cat catalog "sasuser.profile.',compress(_infile_),
     '.source";data _null_;infile _cat;input;putlog _infile_ ;run;quit;');
     putlog cmd;
     call execute(cmd);
   run;
%mend procha;

%macro sumv / cmd;
   store;note;notesubmit '%sumva;';
   run;
%mend sumv;

%macro sumva;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     cmd=catx(' ','proc means data=_last_ n sum mean min q1 median q3 max;var',_infile_,';run;quit');
     call execute (cmd);
   run;
%mend sumva;

%macro avgh / cmd;
   store;note;notesubmit '%avgha;';
   run;
%mend avgh;

%macro avgha;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     cmd=catx(' ','proc means data=',_infile_,'n sum mean min q1 median q3 max;run;quit');
     call execute (cmd);
   run;
%mend avgha;

%macro frqv / cmd;
   store;note;notesubmit '%frqva;';
   run;
%mend frqv;

%macro frqva;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     cmd=catx(' ','proc freq  data=_last_ levels order=freq;tables',_infile_,'/missing;run;quit');
     call execute (cmd);
   run;
%mend frqva;


%macro unv / cmd;
   store;note;notesubmit '%unva;';
   run;
%mend unv;

%macro unva;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     cmd=catx(' ','proc univariate data=_last_ ;var',_infile_,';run;quit');
     call execute (cmd);
   run;
%mend unva;

%macro cntv / cmd;
   store;note;notesubmit '%cntva';
   run;
%mend cntv;

%macro cntva;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     cmd=catx(' ','proc sql;select','"',_infile_,'" as var, count(*) as obs, count(distinct',_infile_,') as lvl from _last_;quit;');
     putlog cmd;
     call execute (cmd);
   run;
%mend cntva;

%macro dmp /cmd;
   note;notesubmit '%dmpa';
   run;
%mend dmp;

%macro dmpa;
   /* all this to get middle record */
   %symdel tob;
   proc sql;select count(*) into :tob separated by ' ' from _last_;quit;
   data _null_;
      If _n_=0 then set _last_ nobs=mobs;
      rec=max(int(mobs/2),1);
      set _last_ point=rec;
      put "Middle Observation(" rec ") of Last dataset = %sysfunc(getoption(_last_)) - Total Obs &tob";
      array chr[*] _character_;
      array num[*] _numeric_;
      putlog // ' -- CHARACTER -- ';
      do i=1 to dim(chr);
         nam=vname(chr[i]);
         typ=vtype(chr[i]);
         len=vlength(chr[i]);
         lbl=vlabel(chr[i]);
         putlog @1 nam @34 typ @39 len @47 chr[i] $16. @67 lbl;
      end;
      putlog // ' -- NUMERIC -- ';
      do i=1 to dim(num);
         nam=vname(num[i]);
         typ=vtype(num[i]);
         len=vlength(num[i]);
         lbl=vlabel(num[i]);
         putlog @1 nam @34 typ @39 len @47 num[i] best.-l @67 lbl;
      end;
      stop;
   run;quit;
%mend dmpa;
%macro dmph /cmd ;
   store;note;notesubmit '%dmpha;';
   run;
%mend dmph;

%macro dmpha;
     filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     put _infile_;
     call symputx('argx',_infile_);
   run;
   /* all this to get middle record */
   %symdel tob;

   proc sql;select count(*) into :tob separated by ' ' from &argx;quit;
   run;

   data _null_;

      If _n_=0 then set &argx nobs=mobs;
      rec=max(int(mobs/2),1);
      set &argx point=rec;
      totobs=put(&tob,comma16. -l);
      put "Middle Observation(" rec ") of &argx - Total Obs " totobs;
      array chr[*] _character_;
      array num[*] _numeric_;
      putlog // ' -- CHARACTER -- ';
      do i=1 to dim(chr);
         nam=vname(chr[i]);
         typ=vtype(chr[i]);
         len=vlength(chr[i]);
         lbl=vlabel(chr[i]);
         putlog @1 nam @34 typ @39 len @47 chr[i] $16. @67 lbl;
      end;
      putlog // ' -- NUMERIC -- ';
      do i=1 to dim(num);
         nam=vname(num[i]);
         typ=vtype(num[i]);
         len=vlength(num[i]);
         lbl=vlabel(num[i]);
         putlog @1 nam @34 typ @39 len @47 num[i] best.-l @67 lbl;
      end;
      stop;
   run;quit;
%mend dmpha;

%macro ls40 / cmd;
   note;notesubmit '%ls40a;';
   run;
%mend ls40;

%macro ls40a /cmd des="Print 40 obs from table";
  dm "out;clear;";
  footnote;
  options nocenter;
  proc sql noprint;select put(count(*),comma18.) into :tob  separated by ' '
  from _last_;quit;
  title "Up to 40 obs %sysfunc(getoption(_last_)) total obs=&tob";
  proc print data=_last_ ( Obs= 40 ) /*width=full*/ width=min uniform  heading=horizontal;
  format _all_;
  run;
  title;
  dm "out;";
%mend ls40a;

%macro lsal / cmd;
   note;notesubmit '%lsala;';
   run;
%mend lsal;

%macro lsala /cmd;
   dm "out;clear;";
  proc sql noprint;select put(count(*),comma18.) into :tob  separated by ' '
  from _last_;quit;
  title "Up to 40 obs %sysfunc(getoption(_last_)) total obs=&tob";
  proc print data=_last_  uniform  heading=horizontal width=full;
   footnote;
   format _all_;
   run;
   title;
   dm "out;;top";
%mend lsala;

%macro sumh / cmd des="proc means on a column of numbers";
   store;note;notesubmit '%sumha;';
   run;
%mend sumh;

%macro sumha;
   filename clp clipbrd ;
   data __stath;
     infile clp;
     input x;
   run;
   proc means data=__stath n mean sum min q1 median q3 max;
   run;quit;
%mend sumha;


%macro frqh /cmd parmbuff;
   %let argx=%scan(&syspbuff,1,%str( ));
   store;note;notesubmit '%frqha;';
   run;
%mend frqh;

%macro frqha;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     put _infile_;
     call symputx('argd',_infile_);
   run;
   dm "out;clear;";
   options nocenter;
   footnote;
   title1 "frequency of &argx datasets &argd";
   proc freq data=&argd levels;
   tables &argx./list missing;
   run;
   title;
   dm "out;top;";
%mend frqha;

/* data class;set sashelp.class;run;quit; */

%macro cnt /cmd parmbuff;
   %let argx=%scan(&syspbuff,1,%str( ));
   %let argx=%sysfunc(translate(&argx,%str(,),%str(*)));
   %put &=argx;
   note;notesubmit '%cnta;';
%mend cnt;

%macro cnta;
  proc sql noprint;select put(count(*),comma18.) into :__tob  separated by ' '
  from _last_;quit;
  proc sql;select "%sysfunc(getoption(_last_))(obs=&__tob) and levels of (&argx)"
       ,count(*) from (select distinct &argx  from _last_);quit;
%mend cnta;



%macro cnth /cmd parmbuff;
   %let argx=%scan(&syspbuff,1,%str( ));
   %let argx=%sysfunc(translate(&argx,%str(,),%str(*)));
   %put &=argx;
   store;note;notesubmit '%cntha;';
%mend cnth;

%macro cntha;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     put _infile_;
     call symputx('__argd',_infile_);
   run;
  proc sql noprint;select put(count(*),comma18.) into :__tob  separated by ' '
  from _last_;quit;
  proc sql;select "%sysfunc(getoption(_last_))(obs=&__tob) and levels of (&argx)"
       ,count(*) from (select distinct &argx  from &__argd );quit;
%mend cntha;


%macro frq /cmd parmbuff;
/*-----------------------------------------*\
|  frq sex*age                              |
\*-----------------------------------------*/
   %let argx=%scan(&syspbuff,1,%str( ));
   %*syslput argx=&argx;
   note;notesubmit '%frqa;';
   run;
%mend frq;

%macro frqa;
   dm "out;clear;";
   *rsubmit;
   options nocenter;
   footnote;
   title1 "Frequency of &argx datasets %sysfunc(getoption(_last_))";
   proc freq data=_last_ levels;
   tables &argx./list missing;
   run;
   title;
   *endrsubmit;
   dm "out;top;";
%mend frqa;

%macro prtwh /cmd parmbuff;
/*-----------------------------------------*\
|  highlight dataset in editor              |
|  prt "sex='F'"                    |
\*-----------------------------------------*/
   %let argx=&syspbuff;
   store;note;notesubmit '%prtwha;';
   run;
%mend prtwh;

%macro prtwha;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     put _infile_;
     call symputx('argd',_infile_);
   run;
   dm "out;clear;";
   options nocenter;
   title1 "print of datasets &argd";
   title2 &argx;
   proc print data=&argd(obs=60 where=(%sysfunc(dequote(&argx))))  width=min;
   run;
   title;
   dm "out;top;";
%mend prtwha;

%macro prtw /cmd parmbuff;
/*-----------------------------------------*\
|  highlight dataset in editor              |
|  prt "sex='F'"                    |
\*-----------------------------------------*/
   %let argx=&syspbuff;
   note;notesubmit '%prtwa;';
   run;
%mend prtw;

%macro prtwa;
   dm "out;clear;";
   options nocenter;
   title1 "print of datasets %sysfunc(getoption(_last_))";
   title2 &argx;
   proc print data=_last_(obs=60 where=(%sysfunc(dequote(&argx))))  width=min;
   run;
   title;
   dm "out;top;";
%mend prtwa;


%macro debugh/cmd;
   store;note;notesubmit '%debugha;';
   run;
%mend debugh;

%macro debugha;
   %let rc=%sysfunc(filename(myRef,%sysfunc(pathname(work))/mactxt.sas));
   %let sysrc=%sysfunc(fdelete(&myRef));
   %let rc=%sysfunc(filename(&myref));
   filename clp clipbrd ;
   data _null_;
     infile clp;
     file "%sysfunc(pathname(work))/macraw.sas";
     input;
     put _infile_;
   run;
   filename mprint  "%sysfunc(pathname(work))/mactxt.sas";
   options mfile mprint source2;
   %inc "%sysfunc(pathname(work))/macraw.sas";
   run;quit;
   options nomfile nomprint;
   filename mprint clear;
   %inc "%sysfunc(pathname(work))/mactxt.sas";
   run;quit;
%mend debugha;

%macro parh / cmd;
   store;note;notesubmit '%parha;';
   run;
%mend parh;

%macro parha;
   filename clp clipbrd ;
   data _null_;
     retain add 0;
     infile clp;
     input ;
     lft=countc(_infile_,'(');
     rgt=countc(_infile_,')');
     lftrgt=lft - rgt;
     abslftrgt=abs(lftrgt);
     select;
        when (lftrgt=0) putlog "**********************" // "Parentheses match  ()"  // "**********************";
        when (lftrgt>0) putlog "**********************" // "Missing " lftrgt ") parentheses  "  // "**********************";
        when (lftrgt<0) putlog "**********************" // "Missing " abslftrgt  "( parentheses  "  // "**********************";
        otherwise;
     end;
   run;
%mend parha;


%macro con / cmd des="Contents last";
  note;notesubmit '%cona;';
%mend con;

%macro cona   / cmd des="create contents output";
dm "out;clear;";
  options nocenter;
  footnote;
  proc contents data=_last_ position;
  run;
  title;
run;
dm "out;top;";
%mend cona;

%macro conh / cmd des="Contents last";
  store;note;notesubmit '%conha;';
%mend conh;


%macro conha;
FILENAME clp clipbrd ;
DATA _NULL_;
  INFILE clp;
  INPUT;
  put _infile_;
  call symputx('argx',_infile_);
RUN;
dm "out;clear;";
title "Contents of &argx.";
options nocenter;
proc contents data=&argx. position;
run;
title;
dm "out;top";
%mend conha;


%macro lsalh / cmd des="Lista ll obs highlighted dataset";
  store;note;notesubmit '%lsalha;';
%mend lsalh;

%macro lsalha;
FILENAME clp clipbrd ;
DATA _NULL_;
  INFILE clp;
  INPUT;
  put _infile_;
  call symputx('argx',_infile_);
RUN;
dm "out;clear;";
proc sql noprint;select put(count(*),comma18.) into :tob  separated by ' '
  from &argx;quit;
title "All Obs(&tob) from dataset &argx.";
options nocenter;
proc print  data=&argx. width=ful;
format _all_;
run;
title;
dm "out;top";
%mend lsalha;

%macro vu  / cmd;
   vt _last_ COLHEADING=NAMES;
   run;
%mend vu ;

%macro vuh / cmd;
   note;notesubmit '%vuha;';
   run;
%mend vuh;

%macro vuha;
filename clp clipbrd ;
data _null_;
  infile clp;
  input;
  put _infile_;
  call symputx('argx',_infile_);
run;
dm "vt &argx"  COLHEADING=NAMES;
%mend vuha;

%macro ls40h /cmd;
   store;note;notesubmit '%ls40ha;';
%mend ls40h;


%macro ls40ha /cmd;
  FILENAME clp clipbrd ;
  DATA _NULL_;
    INFILE clp;
    INPUT;
    put _infile_;
    call symputx('argx',_infile_);
  RUN;
  dm "out;clear;";
  footnote;
  options nocenter;
  proc sql noprint;select put(count(*),comma18.) into :tob  separated by ' '
  from &argx;quit;
  title "Up to 40 obs from &argx total obs=&tob";
  proc print data=&argx( Obs= 40 ) /* width=full */ width=min  heading=horizontal;
  format _all_;
  run;
  dm "out;";
%mend ls40ha;

%macro xlsh /cmd ;
   store;note;notesubmit '%xlsha;';
   run;
%mend xlsh;

%macro xlsha/cmd;

    filename clp clipbrd ;
    data _null_;
     infile clp;
     input;
     put _infile_;
     call symputx('argx',_infile_);
    run;

    %let __tmp=%sysfunc(pathname(work))\myxls.xlsx;

    data _null_;
        fname="tempfile";
        rc=filename(fname, "&__tmp");
        put rc=;
        if rc = 0 and fexist(fname) then
       rc=fdelete(fname);
    rc=filename(fname);
    run;

    libname __xls excel "&__tmp";
    data __xls.%scan(__&argx,1,%str(.));
        set &argx.;
    run;quit;
    libname __xls clear;

    data _null_;z=sleep(1);run;quit;

    options noxwait noxsync;
    /* Open Excel */
    x "'C:\Program Files\Microsoft Office\OFFICE14\excel.exe' &__tmp";
    run;quit;

%mend xlsha;


%macro iota(utliota1)/cmd;
   sub '%iotb';
%mend iota;


%macro iotb
/ des="Called by utliota n integers in editor";

%local ui;
%let urc=%sysfunc(filename(utliotb1,"work.utliotb1.utliotb1.catams"));

%put urc=&urc;

%let ufid = %sysfunc(fopen(&utliotb1,o));

%do ui = 1 %to &utliota1;

%let uzdec = %sysfunc(putn(&ui,z%length(&utliota1)..));

%let urc=%sysfunc(fput(&ufid,&uzdec));

%let urc=%sysfunc(fwrite(&ufid));

%end;

%let urc=%sysfunc(fclose(&ufid));

%let urc=%sysfunc(filename(utliotb1));

dm "inc 'work.utliotb1.utliotb1.catams'";

%mend iotb;

%macro xplo ( AFSTR1 )/cmd ;

/*-----------------------------------------*\
|  xplo %str(ONEaTWOaTHREE)                 |
|  lower case letters produce spaces        |
\*-----------------------------------------*/

note;notesubmit '%xploa';

%mend xplo;

%macro xploa
/  des = "Exploded Banner for Printouts";

options noovp;
title;
footnote;

%let uj=1;

%do %while(%scan(&afstr1.,&uj) ne );
   %let uj=%eval(&uj+1);
   %put uj= &uj;
%end;

data _null_;
   rc=filename('__xplo', "%sysfunc(pathname(work))/__xplo");
   if rc = 0 and fexist('__xplo') then rc=fdelete('__xplo');
   rc=filename('__xplo');

   rc=filename('__clp', "%sysfunc(pathname(work))/__clp");
   if rc = 0 and fexist('__clp') then rc=fdelete('__clp');
   rc=filename('__clp');
run;

filename ft15f001 "%sysfunc(pathname(work))/__xplo";

* format for proc explode;
data _null_;
file ft15f001;
   %do ui=1 %to %eval(&uj-1);
      put "D";
      put " %scan(&afstr1.,&ui)";
   %end;
run;

filename __clp "%sysfunc(pathname(work))/__clp";

proc printto print=__clp;
run;quit;

proc explode;
run;

filename ft15f001 clear;
run;quit;
proc printto;
run;quit;

filename __dm clipbrd ;

   data _null_;
     infile __clp end=dne;
     file __dm;
     input;
     putlog _infile_;
     put _infile_;
     if dne then put / "#! &afstr1 ;";
   run;

filename __dm clear;

%mend xploa;



%macro utlfix(dum);
* fix frozen sas and restore to invocation ;
 dm "odsresults;clear;";
 options ls=171 ps=65;run;quit;
 ods listing;
 ods select all;
 ods graphics off;
 proc printto;run;
 goptions reset=all;
 endsubmit;
 endrsubmit;
 run;quit;
 %utlopts;

%mend utlfix;

%macro evlh / cmd;
   store;note;notesubmit '%evla;';
   run;
%mend evlh;

%macro evla;
   %symdel __evl;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     put _infile_;
     call symputx('__evl',_infile_);
   run;quit;
   data _null_;
     result=&__evl;
     put result=;
   run;quit;
%mend evla;

%macro sumh / cmd;
   store;note;notesubmit '%sumha;';
   run;
%mend sumh;

%macro sumha;
   filename clp clipbrd ;
   data _null_;
     retain sum 0;
     infile clp end=dne;
     input x;
     sum=sum+x;
     if dne then put sum=;
   run;
%mend sumha;

%macro bueh / cmd;
   store;note;notesubmit '%bueha;';
   run;
%mend bueh;
%macro bueha;
   filename _tmp_ clear;
   %utlchkfyl(%sysfunc(pathname(work))/_vue.txt);
   filename tmp "%sysfunc(pathname(work))/_vue.txt";
   filename clp clipbrd ;
   data _null_;
     infile clp end=dne;
     file tmp;
     put 'data _vue/view=_vue;';
     do until (dne);
        input ;
        put _infile_;
     end;
     if dne then do;
        put ';run;quit;';
        put 'data view=_vue;describe;run;quit;';
     end;
     stop;
   run;quit;
   %include "%sysfunc(pathname(work))/_vue.txt";
   filename tmp clear;
%mend bueha;



%macro xpy()/cmd parmbuff;

%let afstr1=&syspbuff;

/*-----------------------------------------*\
|  xplo %str(ONE TWO THREE)                 |
|  lower case letters produce spaces        |
\*-----------------------------------------*/

note;notesubmit '%xpya';

%mend xpy;

%macro xpya
/  des = "Exploded Banner for Printouts";

%local uj revslash;

options noovp;
title;
footnote;

data _null_;
   rc=filename('__xplp', "%sysfunc(pathname(work))/__xplp");
   if rc = 0 and fexist('__xplo') then rc=fdelete('__xplp');
   rc=filename('__xplp');
run;

%let revslash=%sysfunc(translate(%sysfunc(pathname(work)),'/','\'));
%put &=revslash;
run;quit;

* note uou can altename single and double quotes;
%utl_submit_py64(resolve('
import sys;
from pyfiglet import figlet_format;
txt=figlet_format("&afstr1.", font="standard");
with open("&revslash./__xplp", "w") as f:;
.    f.write(txt);
'));

filename __dm clipbrd ;

   data _null_;
     infile "%sysfunc(pathname(work))/__xplp" end=dne;
     file __dm;
     input;
     if _n_=1 then substr(_infile_,1,1)='*';
     putlog _infile_;
     put _infile_;
     if dne then do;
        put ';';
        putlog ';';
     end;
   run;

filename __dm clear;

%mend xpya;



