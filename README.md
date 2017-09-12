# utl_sas_classic_editor
Part one of series the SAS Classic editor circa 1980s

    ```  /* T007830 PART I Point and shoot programming with SAS Classic editor.  ```
    ```    ```
    ```    ```
    ```  There are three ways to fast programming  ```
    ```    ```
    ```   1. Point and shoot with mouse actions(fastest)  ie push middle mouse button proc means hi-lited dataset  ```
    ```   2. Point and shoot with the keyboard      ie hit F2 after dataset hi-lite for proc means  ```
    ```   3. Point and shoot with the command line. ie type avgh on command line after hi-liting dataset  ```
    ```    ```
    ```  This type of 'fast' programming is only supported by the classic editor with the simple  ```
    ```  clean command line on all windows.  ```
    ```  How to map macros to the mouse and keyboard and remember actions to follow,  ```
    ```    ```
    ```  You need to download  the command macros and include the package.  ```
    ```    ```
    ```      utl_perpac  ```
    ```    ```
    ```  Here is what is in the package  (* most used or most critical)  ```
    ```    ```
    ```    avgh     proc means hilited dataset  ```
    ```    avg      proc means last dataset  ```
    ```    cnt      cnt name*sex - last dataset number unique combinations  ```
    ```    cnth     cnt name*sex - hi-lited dataset  ```
    ```    cntv     cnt hilited ariavle last dataset  ```
    ```    con      contents last dataset  ```
    ```    conh     contents hi-lited dataset  ```
    ```   *debugh   macro debug hi-lited  ```
    ```   *dmp      contents with sample data  ```
    ```   *dmph     contents with sample data hi-lited dataset  ```
    ```   *frq      freq sex*age last dataset  ```
    ```   *frqh     freq sex*age hi-lited dataset  ```
    ```    frqv     freq hilited variable last dataset  ```
    ```    iota     column of consecutive integers  ```
    ```   *ls40     40 obs last dataset  ```
    ```   *ls40h    40 obs hi-lited dataset  ```
    ```    lsal     all obs last dataset  ```
    ```    parh     does hi-lited code have matched paraentheses  ```
    ```    proch    syntax for the proc - hi-lite 'proc reg' and get syntax with example  ```
    ```   *prtw     prtw 'sex="M"' - last dataset subset printed  ```
    ```   *prtwh    prtw 'sex="M"' - hi-lited dataset subset printed  ```
    ```    sumh     statistics on hi-lited column of numbers  ```
    ```    sumv     statistics on hi-lited variable last dataset  ```
    ```    unv      proc univariate on variable in last dataset  ```
    ```    vu       viewtable last dataset  ```
    ```    vuh      viewtable hi-lited dataset  ```
    ```   *xlsh     view and edit hi-lited dataset in excel (may need a sleep w slow systems)  ```
    ```   *xplo     xplo SUBaSUM put exploded chars in past buffer  ```
    ```   *cuth     compbl (delete mutiple blanks in highlighted area)  ```
    ```   *xpy log  calls python and creates a banner in the copy buffer of the highlighted text (just paste after)  ```
    ```             see previous postings  ```
    ```   *unvh age univariate on age from highlighted dataset  ```
    ```   *getpwd   pathe of current program (present working directory)  ```
    ```    ```
    ```    ```
    ```    ```
    ```  Note '?' on the command line retrieves previous commands.  ```
    ```    ```
    ```  ***************************************************************************;  ```
    ```    ```
    ```  Example 1.  Which line in the macro is causing the error.  ```
    ```    ```
    ```   In the macro below variable 'name' is a character but a numeric variaqble is needed.  ```
    ```   However SAS reports the error on the invocation line '%errmke'. We want SAS  ```
    ```   to tell us which line inside the macro is causing the problem.  ```
    ```    ```
    ```    ```
    ```   %macro errmke(dummy);  ```
    ```       data class;  ```
    ```          set sashelp.class(obs=1);  ```
    ```          if name=2 then sex='M';  ```
    ```       run;quit;  ```
    ```    %mend errmke;  ```
    ```    ```
    ```    %errmke;  ```
    ```    ```
    ```   If you highlight the macro with invocation and type debugh you will see the following  ```
    ```   in the log. Note SAS has identifies line 1403 columg 4 (position of name varable)  ```
    ```   as the issue.  ```
    ```    ```
    ```    ```
    ```   1401 +data class;  ```
    ```   1402 +set sashelp.class(obs=1);  ```
    ```   1403 +if name=2 then sex='M';  ```
    ```   ERROR: Character value found where numeric value needed at line 1403 column 4.  ```
    ```   1404 +run;  ```
    ```    ```
    ```  *****************************************************************************;  ```
    ```    ```
    ```  Example 2. I would like to view and edit the dataset in excel  ```
    ```    ```
    ```    data class;  ```
    ```       set sashelp.class;  ```
    ```    run;quit;  ```
    ```    ```
    ```    Highlight class and type xlsh on the command line  ```
    ```    ```
    ```    ```
    ```  ******************************************************************************;  ```
    ```    ```
    ```  Example 3 I would like the first 20 integers in my editor.  ```
    ```    ```
    ```  Just type 'ioata 10' on the command line  ```
    ```    ```
    ```  01  ```
    ```  02  ```
    ```  03  ```
    ```  04  ```
    ```  05  ```
    ```  06  ```
    ```  07  ```
    ```  08  ```
    ```  09  ```
    ```  10  ```
    ```    ```
    ```  ******************************************************************************;  ```
    ```    ```
    ```  * I would like the statistics on the two numbers above.  ```
    ```    ```
    ```    Just highlite the coulumn of numbers and type sumh on command line  ```
    ```    ```
    ```                                                Analysis Variable : X  ```
    ```    ```
    ```                                                 Lower                       Upper  ```
    ```   N          Mean          Sum      Minimum     Quartile       Median        Quartile         Maximum  ```
    ```  ----------------------------------------------------------------------------------------------------  ```
    ```  10     5.5000000   55.0000000    1.0000000    3.0000000    5.5000000       8.0000000      10.0000000  ```
    ```  ----------------------------------------------------------------------------------------------------  ```
    ```    ```
    ```  **********************************************************************************  ```
    ```    ```
    ```  Example 4.  ```
    ```    ```
    ```    I would like a vertical dump on the middle observation with type, length and labels  ```
    ```    ```
    ```    Highlight  ```
    ```    ```
    ```         sashelp.zipcode  ```
    ```    and  ```
    ```         type dmph on the command line  ```
    ```    ```
    ```         type dmp for last dataset  ```
    ```    ```
    ```    ```
    ```  Middle Observation(20633 ) of sashelp.zipcode - Total Obs 41,267  ```
    ```    ```
    ```    ```
    ```   -- CHARACTER --  ```
    ```  ZIP_CLASS             C    1       ZIP Code Classifi  ```
    ```  CITY                  C    35      Ionia               Name of city/org  ```
    ```  STATECODE             C    2       MI                  Two-letter abbrev. for state name.  ```
    ```  STATENAME             C    25      Michigan            Full name of state/territory  ```
    ```  COUNTYNM              C    25      Ionia               Name of county/parish.  ```
    ```  AREACODES             C    12      616                 Multiple Area Codes for ZIP Code.  ```
    ```  TIMEZONE              C    9       Eastern             Time Zone for ZIP Code.  ```
    ```  DST                   C    1       Y                   ZIP Code obeys Daylight Savings: Y-Yes N-No  ```
    ```  PONAME                C    35      Ionia               USPS Post Office Name: same as City  ```
    ```  ALIAS_CITY            C    300                         USPS - alternate names of city separated by ||  ```
    ```  ALIAS_CITYN           C    300                         Local - alternate names of city separated by ||  ```
    ```  CITY2                 C    35      IONIA               Clean CITY name for geocoding  ```
    ```  STATENAME2            C    25      MICHIGAN            Clean STATENAME for geocoding  ```
    ```    ```
    ```   -- NUMERIC --  ```
    ```  ZIP                   N    8       48846               The 5-digit ZIP Code  ```
    ```  Y                     N    8       42.985392           Latitude (degrees) of the center (centroid) of ZIP Code.  ```
    ```  X                     N    8       -85.064142          Longitude (degrees) of the center (centroid) of ZIP Code.  ```
    ```  STATE                 N    8       26                  Two-digit number (FIPS code) for state/territory  ```
    ```  COUNTY                N    8       67                  FIPS county code.  ```
    ```  MSA                   N    8       0                   Metro Statistical Area code by common pop-pre 2003; no MSA for rural  ```
    ```  AREACODE              N    8       616                 Single Area Code for ZIP Code.  ```
    ```  GMTOFFSET             N    8       -5                  Diff (hrs) between GMT and time zone for ZIP Code  ```
    ```    ```
    ```    ```
    ```  **********************************************************************************  ```
    ```    ```
    ```  Example 5  ```
    ```    ```
    ```  Do my parenthesis match?  ```
    ```    ```
    ```      data class;  ```
    ```        set sashelp.class(where=(sex='M' and name in ('John','Jane')) ;  ```
    ```      run;quit;  ```
    ```    ```
    ```      highlight first and last parens abd type parh on the command line  ```
    ```    ```
    ```      **********************  ```
    ```    ```
    ```      Missing 1 ) parentheses  ```
    ```    ```
    ```      **********************  ```
    ```    ```
    ```    ```
    ```  **********************************************************************************  ```
    ```    ```
    ```  last dataset    hilited dataset  ```
    ```    ```
    ```  frq sex*name    frqh sex*name     PROC FREQ  ```
    ```  frq sex         frqh sex  ```
    ```    ```
    ```  cnt sex         cnth sex          UNIQUE LEVELS  ```
    ```  cnt sex*name    cnth sex*name  ```
    ```    ```
    ```  prtw 'sex="M"'  prtwh 'sex="M"'   PRINT SUBSET  ```
    ```    ```
    ```    ```
    ```  Hilite and type frqh type*origin on command line  ```
    ```    ```
    ```             sashelp.cars  ```
    ```    ```
    ```    ```
    ```  Number of Variable Levels  ```
    ```    ```
    ```  Variable      Levels  ```
    ```  --------------------  ```
    ```  TYPE               6  ```
    ```  ORIGIN             3  ```
    ```    ```
    ```    ```
    ```                                               Cumulative    Cumulative  ```
    ```  TYPE      ORIGIN    Frequency     Percent     Frequency      Percent  ```
    ```  ---------------------------------------------------------------------  ```
    ```  Hybrid    Asia             3        0.70             3         0.70  ```
    ```  SUV       Asia            25        5.84            28         6.54  ```
    ```  SUV       Europe          10        2.34            38         8.88  ```
    ```  SUV       USA             25        5.84            63        14.72  ```
    ```  Sedan     Asia            94       21.96           157        36.68  ```
    ```  Sedan     Europe          78       18.22           235        54.91  ```
    ```  Sedan     USA             90       21.03           325        75.93  ```
    ```  Sports    Asia            17        3.97           342        79.91  ```
    ```  Sports    Europe          23        5.37           365        85.28  ```
    ```  Sports    USA              9        2.10           374        87.38  ```
    ```  Truck     Asia             8        1.87           382        89.25  ```
    ```  Truck     USA             16        3.74           398        92.99  ```
    ```  Wagon     Asia            11        2.57           409        95.56  ```
    ```  Wagon     Europe          12        2.80           421        98.36  ```
    ```  Wagon     USA              7        1.64           428       100.00  ```
    ```    ```
    ```    ```
    ```  **********************************************************************************  ```
    ```    ```
    ```  Example 6  ```
    ```    ```
    ```   The commands with the h suffix work on highlited datasets(in pgm/log/output)  ```
    ```    ```
    ```   con  ```
    ```   conh  ```
    ```   ls40  ```
    ```   ls40h  ```
    ```   lsal  ```
    ```   lsalh  ```
    ```    ```
    ```      Highlite  ```
    ```    ```
    ```           sashelp.cars  ```
    ```    ```
    ```      type ls40h  list first 40 obs  ```
    ```           conh   contents  ```
    ```           lsalh  list all obs  ```
    ```    ```
    ```    ```
    ```  **********************************************************************************  ```
    ```    ```
    ```  xplo MAINaSORT  ```
    ```    ```
    ```  put the following in the paste buffer  ```
    ```    ```
    ```  *   *    *    *****  *   *          ***    ***   ****   *****  ```
    ```  ** **   * *     *    **  *         *   *  *   *  *   *    *  ```
    ```  * * *  *   *    *    * * *          *     *   *  *   *    *  ```
    ```  *   *  *****    *    *  **           *    *   *  ****     *  ```
    ```  *   *  *   *    *    *   *            *   *   *  * *      *  ```
    ```  *   *  *   *    *    *   *         *   *  *   *  *  *     *  ```
    ```  *   *  *   *  *****  *   *          ***    ***   *   *    *  ```
    ```    ```
    ```  You can then paste the text to document your code.  ```
    ```    ```
    ```    ```
    ```    ```
    ```  xpy main sort  ```
    ```  *                _                        _  ```
    ```   _ __ ___   __ _(_)_ __    ___  ___  _ __| |_  ```
    ```  | '_ ` _ \ / _` | | '_ \  / __|/ _ \| '__| __|  ```
    ```  | | | | | | (_| | | | | | \__ \ (_) | |  | |_  ```
    ```  |_| |_| |_|\__,_|_|_| |_| |___/\___/|_|   \__|  ```
    ```    ```
    ```  ;  ```
    ```    ```
