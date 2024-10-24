

   MEMBER('matija_cerovac_projekt_2021.clw')               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021004.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Frame
!!! </summary>
Main PROCEDURE 

SplashProcedureThread LONG
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
AppFrame             APPLICATION('Application'),AT(,,602,190),RESIZE,MAX,STATUS(-1,80,120,45),SYSTEM,WALLPAPER('Slike za p' & |
  'rojekt\blue-truck-43298-1920x1080.jpg'),IMM
                       MENUBAR,USE(?MENUBAR1)
                         MENU('&Datoteka'),USE(?FileMenu),ICON(ICON:Application)
                           ITEM('P&rint Setup...'),USE(?PrintSetup),MSG('Setup Printer'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('E&xit'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('Uredi'),USE(?EditMenu),ICON(ICON:Cut)
                           ITEM('Cu&t'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
                           ITEM('&Copy'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
                           ITEM('&Paste'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)
                         END
                         MENU('Prozor'),USE(?MENU1),ICON(ICON:Child),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('Pomoc'),USE(?MENU2),ICON(ICON:Help),MSG('Windows Help')
                           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                         END
                         MENU('Popis'),USE(?MENU3),ICON(ICON:Frame)
                           ITEM('Narudzbenica'),USE(?ITEM1)
                           ITEM('Nacin Otpreme'),USE(?ITEM2)
                           ITEM('Rok Isporuke'),USE(?ITEM3)
                           ITEM('Nacin Placanja'),USE(?ITEM4)
                           ITEM('Stranka'),USE(?ITEM5)
                           ITEM('Mjesto'),USE(?ITEM6)
                           ITEM('Djelatnik'),USE(?ITEM7)
                           ITEM('Uloga Potpisa'),USE(?ITEM8)
                           ITEM('Roba'),USE(?ITEM9)
                           ITEM('Jedinica mjere'),USE(?ITEM10)
                         END
                         MENU('Izvijesca'),USE(?MENU4),ICON(ICON:Tick)
                           ITEM('Nacin otpreme'),USE(?ITEM11)
                           ITEM('Stranka'),USE(?ITEM12)
                           ITEM('Narudzbenica'),USE(?ITEM13)
                         END
                       END
                       TOOLBAR,AT(0,0,602,22),USE(?TOOLBAR1),COLOR(00E6D8ADh)
                         BUTTON('NARUDZBENICA'),AT(2,2),USE(?BUTTON1),COLOR(00FACE87h)
                         BUTTON('NACIN OTPREME'),AT(72,2),USE(?BUTTON2),COLOR(00FACE87h)
                         BUTTON('ROK ISPORUKE'),AT(144,2),USE(?BUTTON3),COLOR(00FACE87h)
                         BUTTON('NACIN PLACANJA'),AT(212,2),USE(?BUTTON4),COLOR(00FACE87h)
                         BUTTON('STRANKA'),AT(285,2),USE(?BUTTON5),COLOR(00FACE87h)
                         BUTTON('MJESTO'),AT(332,2),USE(?BUTTON6),COLOR(00FACE87h)
                         BUTTON('DJELATNIK'),AT(375,2),USE(?BUTTON7),COLOR(00FACE87h)
                         BUTTON('ULOGA POTPISA'),AT(426,2),USE(?BUTTON8),COLOR(00FACE87h)
                         BUTTON('ROBA'),AT(497,2),USE(?BUTTON9),COLOR(00FACE87h)
                         BUTTON('JEDINICA MJERE'),AT(532,2),USE(?BUTTON10),COLOR(00FACE87h)
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
Menu::MENUBAR1 ROUTINE                                     ! Code for menu items on ?MENUBAR1
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::MENU1 ROUTINE                                        ! Code for menu items on ?MENU1
Menu::MENU2 ROUTINE                                        ! Code for menu items on ?MENU2
Menu::MENU3 ROUTINE                                        ! Code for menu items on ?MENU3
  CASE ACCEPTED()
  OF ?ITEM1
    START(PopisNarudzbenica, 25000)
  OF ?ITEM2
    START(PopisNacinaotpreme, 25000)
  OF ?ITEM3
    START(PopisRokaIsporuke, 25000)
  OF ?ITEM4
    START(PopisNacinaPlacanja, 25000)
  OF ?ITEM5
    START(PopisStranaka, 25000)
  OF ?ITEM6
    START(PopisMjesta, 25000)
  OF ?ITEM7
    START(PopisDjelatnika, 25000)
  OF ?ITEM8
    START(PopisUlogaPotpisa, 25000)
  OF ?ITEM9
    START(PopisRoba, 25000)
  OF ?ITEM10
    START(PopisJedinicaMjere, 25000)
  END
Menu::MENU4 ROUTINE                                        ! Code for menu items on ?MENU4
  CASE ACCEPTED()
  OF ?ITEM11
    START(IzvijesceNacinaOtpreme, 25000)
  OF ?ITEM12
    START(IzvijesceStranaka, 25000)
  OF ?ITEM13
    START(IzvijesceNarudzbenica, 25000)
  END

ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(AppFrame{PROP:Timer},1,100)
    AppFrame{PROP:Timer} = 100
  END
    AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
    AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
      AppFrame{PROP:TabBarVisible}  = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    ELSE
      DO Menu::MENUBAR1                                    ! Process menu items on ?MENUBAR1 menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::MENU1                                       ! Process menu items on ?MENU1 menu
      DO Menu::MENU2                                       ! Process menu items on ?MENU2 menu
      DO Menu::MENU3                                       ! Process menu items on ?MENU3 menu
      DO Menu::MENU4                                       ! Process menu items on ?MENU4 menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON1
      START(PopisNarudzbenica, 25000)
    OF ?BUTTON2
      START(PopisNacinaotpreme, 25000)
    OF ?BUTTON3
      START(PopisRokaIsporuke, 25000)
    OF ?BUTTON4
      START(PopisNacinaPlacanja, 25000)
    OF ?BUTTON5
      START(PopisStranaka, 25000)
    OF ?BUTTON6
      START(PopisMjesta, 25000)
    OF ?BUTTON7
      START(PopisDjelatnika, 25000)
    OF ?BUTTON8
      START(PopisUlogaPotpisa, 25000)
    OF ?BUTTON9
      START(PopisRoba, 25000)
    OF ?BUTTON10
      START(PopisJedinicaMjere, 25000)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      SplashProcedureThread = START(SplashProzor)          ! Run the splash window procedure
    OF EVENT:Timer
      AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
      AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
    ELSE
      IF SplashProcedureThread
        IF EVENT() = Event:Accepted
          POST(Event:CloseWindow,,SplashProcedureThread)   ! Close the splash window
          SplashPRocedureThread = 0
        END
     END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisNarudzbenica PROCEDURE 

BRW1::View:Browse    VIEW(NARUDZBENICA)
                       PROJECT(NAR:Broj_narudzbenice)
                       PROJECT(NAR:Ukupno)
                       PROJECT(NAR:Datum_narudzbenice)
                       PROJECT(NAR:Rok_placanja)
                       PROJECT(NAR:Napomena)
                       PROJECT(NAR:Sifra_nacina_otpreme)
                       PROJECT(NAR:Rbr_roka_isporuke)
                       PROJECT(NAR:Sifra_nacina_placanja)
                       JOIN(OTP:PK_NacinOtpreme_sifra_nacina_otpreme,NAR:Sifra_nacina_otpreme)
                         PROJECT(OTP:Sifra_nacina_otpreme)
                       END
                       JOIN(ROK:PK_RokIsporuke_rbr_roka_isporuke,NAR:Rbr_roka_isporuke)
                         PROJECT(ROK:Rbr_roka_isporuke)
                       END
                       JOIN(PLA:PK_NacinPlacanja_sifra_nacina_placanja,NAR:Sifra_nacina_placanja)
                         PROJECT(PLA:Sifra_nacina_placanja)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
NAR:Broj_narudzbenice  LIKE(NAR:Broj_narudzbenice)    !List box control field - type derived from field
NAR:Ukupno             LIKE(NAR:Ukupno)               !List box control field - type derived from field
NAR:Datum_narudzbenice LIKE(NAR:Datum_narudzbenice)   !List box control field - type derived from field
NAR:Rok_placanja       LIKE(NAR:Rok_placanja)         !List box control field - type derived from field
OTP:Sifra_nacina_otpreme LIKE(OTP:Sifra_nacina_otpreme) !List box control field - type derived from field
ROK:Rbr_roka_isporuke  LIKE(ROK:Rbr_roka_isporuke)    !List box control field - type derived from field
PLA:Sifra_nacina_placanja LIKE(PLA:Sifra_nacina_placanja) !List box control field - type derived from field
NAR:Napomena           LIKE(NAR:Napomena)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW5::View:Browse    VIEW(ULOGA)
                       PROJECT(ULO:OIB_stranke)
                       PROJECT(ULO:Broj_narudzbenice)
                       PROJECT(ULO:Narucitelj_dobavljac)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
ULO:OIB_stranke        LIKE(ULO:OIB_stranke)          !List box control field - type derived from field
ULO:Broj_narudzbenice  LIKE(ULO:Broj_narudzbenice)    !List box control field - type derived from field
ULO:Narucitelj_dobavljac LIKE(ULO:Narucitelj_dobavljac) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,502,244),COLOR(00FACE87h),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,495,100),USE(?List),HVSCROLL,COLOR(COLOR:White),FORMAT('65L(2)|M~Broj Narud' & |
  'zbenice~C(0)@N010@39L(2)|M~Ukupno~C(0)@n10.2@72L(2)|M~Datum Narudzbenice~C(0)@D6@110' & |
  'L(2)|M~Rok Placanja~C(0)@s29@70L(2)|M~Sifra Nacina Otpreme~C(0)@N010@73L(2)|M~Rbr Ro' & |
  'ka Isporuke~C(0)@N05@67L(2)|M~Sifra Nacina Placanja~C(0)@N010@184L(2)|M~Napomena~L(0)@s50@'), |
  FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(454,108,40,12),USE(?Close)
                       LIST,AT(10,134,221,100),USE(?List:2),DECIMAL(14),HVSCROLL,COLOR(COLOR:White),FORMAT('44L(2)|M~O' & |
  'IB Stranke~C(0)@N011@72L(2)|M~Broj Narudzbenice~C(0)@N010@120L(2)|M~Narucitelj/Dobav' & |
  'ljac~C(0)@s30@'),FROM(Queue:Browse:1),IMM
                       BUTTON('&Unos'),AT(244,160,42,12),USE(?Insert:2)
                       BUTTON('&Promjena'),AT(244,175,42,12),USE(?Change:2)
                       BUTTON('&Brisanje'),AT(244,190,42,12),USE(?Delete:2)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW5                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW5::Sort0:Locator  StepLocatorClass                      ! Default Locator

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisNarudzbenica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:NARUDZBENICA.SetOpenRelated()
  Relate:NARUDZBENICA.Open                                 ! File NARUDZBENICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:NARUDZBENICA,SELF) ! Initialize the browse manager
  BRW5.Init(?List:2,Queue:Browse:1.ViewPosition,BRW5::View:Browse,Queue:Browse:1,Relate:ULOGA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,NAR:PK_Narudzbenica_broj_narudzbenice) ! Add the sort order for NAR:PK_Narudzbenica_broj_narudzbenice for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,NAR:Broj_narudzbenice,1,BRW1)  ! Initialize the browse locator using  using key: NAR:PK_Narudzbenica_broj_narudzbenice , NAR:Broj_narudzbenice
  BRW1.AddField(NAR:Broj_narudzbenice,BRW1.Q.NAR:Broj_narudzbenice) ! Field NAR:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Ukupno,BRW1.Q.NAR:Ukupno)              ! Field NAR:Ukupno is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Datum_narudzbenice,BRW1.Q.NAR:Datum_narudzbenice) ! Field NAR:Datum_narudzbenice is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Rok_placanja,BRW1.Q.NAR:Rok_placanja)  ! Field NAR:Rok_placanja is a hot field or requires assignment from browse
  BRW1.AddField(OTP:Sifra_nacina_otpreme,BRW1.Q.OTP:Sifra_nacina_otpreme) ! Field OTP:Sifra_nacina_otpreme is a hot field or requires assignment from browse
  BRW1.AddField(ROK:Rbr_roka_isporuke,BRW1.Q.ROK:Rbr_roka_isporuke) ! Field ROK:Rbr_roka_isporuke is a hot field or requires assignment from browse
  BRW1.AddField(PLA:Sifra_nacina_placanja,BRW1.Q.PLA:Sifra_nacina_placanja) ! Field PLA:Sifra_nacina_placanja is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Napomena,BRW1.Q.NAR:Napomena)          ! Field NAR:Napomena is a hot field or requires assignment from browse
  BRW5.Q &= Queue:Browse:1
  BRW5.AddSortOrder(,ULO:PK_Uloga_broj_narudzbenice_OIB_stranke) ! Add the sort order for ULO:PK_Uloga_broj_narudzbenice_OIB_stranke for sort order 1
  BRW5.AddLocator(BRW5::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW5::Sort0:Locator.Init(,ULO:Broj_narudzbenice,1,BRW5)  ! Initialize the browse locator using  using key: ULO:PK_Uloga_broj_narudzbenice_OIB_stranke , ULO:Broj_narudzbenice
  BRW5.AddField(ULO:OIB_stranke,BRW5.Q.ULO:OIB_stranke)    ! Field ULO:OIB_stranke is a hot field or requires assignment from browse
  BRW5.AddField(ULO:Broj_narudzbenice,BRW5.Q.ULO:Broj_narudzbenice) ! Field ULO:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW5.AddField(ULO:Narucitelj_dobavljac,BRW5.Q.ULO:Narucitelj_dobavljac) ! Field ULO:Narucitelj_dobavljac is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisNarudzbenica',BrowseWindow)           ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeNarudzbenica
  BRW5.AskProcedure = 2                                    ! Will call: AzuriranjeUloga
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW5.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:NARUDZBENICA.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisNarudzbenica',BrowseWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      AzuriranjeNarudzbenica
      AzuriranjeUloga
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW5.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisNacinaotpreme PROCEDURE 

BRW1::View:Browse    VIEW(OTPREME_NACIN)
                       PROJECT(OTP:Sifra_nacina_otpreme)
                       PROJECT(OTP:Naziv_nacina_otpreme)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
OTP:Sifra_nacina_otpreme LIKE(OTP:Sifra_nacina_otpreme) !List box control field - type derived from field
OTP:Naziv_nacina_otpreme LIKE(OTP:Naziv_nacina_otpreme) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,247,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('81L(2)|M~Sifra Nacina' & |
  ' Otpreme~C(0)@N010@120L(2)|M~Naziv Nacina Otpreme~C(0)@s30@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odaberi'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::OTP:Sifra_nacina_otpreme EditEntryClass       ! Edit-in-place class for field OTP:Sifra_nacina_otpreme
EditInPlace::OTP:Naziv_nacina_otpreme EditEntryClass       ! Edit-in-place class for field OTP:Naziv_nacina_otpreme

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisNacinaotpreme')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:OTPREME_NACIN.Open                                ! File OTPREME_NACIN used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:OTPREME_NACIN,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,OTP:PK_NacinOtpreme_sifra_nacina_otpreme) ! Add the sort order for OTP:PK_NacinOtpreme_sifra_nacina_otpreme for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,OTP:Sifra_nacina_otpreme,1,BRW1) ! Initialize the browse locator using  using key: OTP:PK_NacinOtpreme_sifra_nacina_otpreme , OTP:Sifra_nacina_otpreme
  BRW1.AddField(OTP:Sifra_nacina_otpreme,BRW1.Q.OTP:Sifra_nacina_otpreme) ! Field OTP:Sifra_nacina_otpreme is a hot field or requires assignment from browse
  BRW1.AddField(OTP:Naziv_nacina_otpreme,BRW1.Q.OTP:Naziv_nacina_otpreme) ! Field OTP:Naziv_nacina_otpreme is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisNacinaotpreme',BrowseWindow)          ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:OTPREME_NACIN.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisNacinaotpreme',BrowseWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeNacinaOtpreme
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::OTP:Sifra_nacina_otpreme,1)
  SELF.AddEditControl(EditInPlace::OTP:Naziv_nacina_otpreme,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisRokaIsporuke PROCEDURE 

BRW1::View:Browse    VIEW(ROK_ISPORUKE)
                       PROJECT(ROK:Rbr_roka_isporuke)
                       PROJECT(ROK:Naziv_roka_isporuke)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ROK:Rbr_roka_isporuke  LIKE(ROK:Rbr_roka_isporuke)    !List box control field - type derived from field
ROK:Naziv_roka_isporuke LIKE(ROK:Naziv_roka_isporuke) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,247,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('73L(2)|M~Rbr Roka Isp' & |
  'oruke~C(0)@N05@120L(2)|M~Naziv Roka Isporuke~C(0)@s30@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odaberi'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::ROK:Rbr_roka_isporuke EditEntryClass          ! Edit-in-place class for field ROK:Rbr_roka_isporuke
EditInPlace::ROK:Naziv_roka_isporuke EditEntryClass        ! Edit-in-place class for field ROK:Naziv_roka_isporuke

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisRokaIsporuke')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:ROK_ISPORUKE.Open                                 ! File ROK_ISPORUKE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:ROK_ISPORUKE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,ROK:PK_RokIsporuke_rbr_roka_isporuke) ! Add the sort order for ROK:PK_RokIsporuke_rbr_roka_isporuke for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,ROK:Rbr_roka_isporuke,1,BRW1)  ! Initialize the browse locator using  using key: ROK:PK_RokIsporuke_rbr_roka_isporuke , ROK:Rbr_roka_isporuke
  BRW1.AddField(ROK:Rbr_roka_isporuke,BRW1.Q.ROK:Rbr_roka_isporuke) ! Field ROK:Rbr_roka_isporuke is a hot field or requires assignment from browse
  BRW1.AddField(ROK:Naziv_roka_isporuke,BRW1.Q.ROK:Naziv_roka_isporuke) ! Field ROK:Naziv_roka_isporuke is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisRokaIsporuke',BrowseWindow)           ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ROK_ISPORUKE.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisRokaIsporuke',BrowseWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeRokaIsporuke
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::ROK:Rbr_roka_isporuke,1)
  SELF.AddEditControl(EditInPlace::ROK:Naziv_roka_isporuke,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisNacinaPlacanja PROCEDURE 

BRW1::View:Browse    VIEW(PLACANJA_NACIN)
                       PROJECT(PLA:Sifra_nacina_placanja)
                       PROJECT(PLA:Naziv_nacina_placanja)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PLA:Sifra_nacina_placanja LIKE(PLA:Sifra_nacina_placanja) !List box control field - type derived from field
PLA:Naziv_nacina_placanja LIKE(PLA:Naziv_nacina_placanja) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,247,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('74L(2)|M~Sifra Nacina' & |
  ' Placanja~C(0)@N010@120L(2)|M~Naziv Nacina Placanja~C(0)@s30@'),FROM(Queue:Browse),IMM, |
  MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odaberi'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::PLA:Sifra_nacina_placanja EditEntryClass      ! Edit-in-place class for field PLA:Sifra_nacina_placanja
EditInPlace::PLA:Naziv_nacina_placanja EditEntryClass      ! Edit-in-place class for field PLA:Naziv_nacina_placanja

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisNacinaPlacanja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:PLACANJA_NACIN.Open                               ! File PLACANJA_NACIN used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:PLACANJA_NACIN,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,PLA:PK_NacinPlacanja_sifra_nacina_placanja) ! Add the sort order for PLA:PK_NacinPlacanja_sifra_nacina_placanja for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,PLA:Sifra_nacina_placanja,1,BRW1) ! Initialize the browse locator using  using key: PLA:PK_NacinPlacanja_sifra_nacina_placanja , PLA:Sifra_nacina_placanja
  BRW1.AddField(PLA:Sifra_nacina_placanja,BRW1.Q.PLA:Sifra_nacina_placanja) ! Field PLA:Sifra_nacina_placanja is a hot field or requires assignment from browse
  BRW1.AddField(PLA:Naziv_nacina_placanja,BRW1.Q.PLA:Naziv_nacina_placanja) ! Field PLA:Naziv_nacina_placanja is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisNacinaPlacanja',BrowseWindow)         ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PLACANJA_NACIN.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisNacinaPlacanja',BrowseWindow)      ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeNacinaPlacanja
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::PLA:Sifra_nacina_placanja,1)
  SELF.AddEditControl(EditInPlace::PLA:Naziv_nacina_placanja,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisStranaka PROCEDURE 

BRW1::View:Browse    VIEW(STRANKA)
                       PROJECT(STR:OIB_stranke)
                       PROJECT(STR:Naziv_stranke)
                       PROJECT(STR:Adresa_stranke)
                       PROJECT(STR:Tel_fax)
                       PROJECT(STR:Postanski_broj)
                       JOIN(MJE:PK_Mjesto_postanski_broj,STR:Postanski_broj)
                         PROJECT(MJE:Postanski_broj)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
STR:OIB_stranke        LIKE(STR:OIB_stranke)          !List box control field - type derived from field
STR:Naziv_stranke      LIKE(STR:Naziv_stranke)        !List box control field - type derived from field
STR:Adresa_stranke     LIKE(STR:Adresa_stranke)       !List box control field - type derived from field
STR:Tel_fax            LIKE(STR:Tel_fax)              !List box control field - type derived from field
MJE:Postanski_broj     LIKE(MJE:Postanski_broj)       !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,469,154),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,457,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('44L(2)|M~OIB Stranke~' & |
  'C(0)@N011@113L(2)|M~Naziv Stranke~C(0)@s30@146L(2)|M~Adresa Stranke~C(0)@s39@116L(2)' & |
  '|M~Tel/Fax~C(0)@s29@156L(2)|M~Postanski Broj~L(0)@s39@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(422,110,40,12),USE(?Close)
                       BUTTON('&Ispis'),AT(213,108,46),USE(?Print),ICON(ICON:Print)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisStranaka')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:STRANKA.Open                                      ! File STRANKA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:STRANKA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,STR:PK_Stranka_OIB_stranke)           ! Add the sort order for STR:PK_Stranka_OIB_stranke for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,STR:OIB_stranke,1,BRW1)        ! Initialize the browse locator using  using key: STR:PK_Stranka_OIB_stranke , STR:OIB_stranke
  BRW1.AddField(STR:OIB_stranke,BRW1.Q.STR:OIB_stranke)    ! Field STR:OIB_stranke is a hot field or requires assignment from browse
  BRW1.AddField(STR:Naziv_stranke,BRW1.Q.STR:Naziv_stranke) ! Field STR:Naziv_stranke is a hot field or requires assignment from browse
  BRW1.AddField(STR:Adresa_stranke,BRW1.Q.STR:Adresa_stranke) ! Field STR:Adresa_stranke is a hot field or requires assignment from browse
  BRW1.AddField(STR:Tel_fax,BRW1.Q.STR:Tel_fax)            ! Field STR:Tel_fax is a hot field or requires assignment from browse
  BRW1.AddField(MJE:Postanski_broj,BRW1.Q.MJE:Postanski_broj) ! Field MJE:Postanski_broj is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisStranaka',BrowseWindow)               ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeStranaka
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.PrintProcedure = 2
  BRW1.PrintControl = ?Print
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:STRANKA.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisStranaka',BrowseWindow)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      AzuriranjeStranaka
      IzvijesceStranaka
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisMjesta PROCEDURE 

BRW1::View:Browse    VIEW(MJESTO)
                       PROJECT(MJE:Postanski_broj)
                       PROJECT(MJE:Naziv_mjesta)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
MJE:Postanski_broj     LIKE(MJE:Postanski_broj)       !List box control field - type derived from field
MJE:Naziv_mjesta       LIKE(MJE:Naziv_mjesta)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,280,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,273,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('145L(2)|M~Postanski B' & |
  'roj~C(0)@s39@160L(2)|M~Naziv Mjesta~C(0)@s40@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odaberi'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::MJE:Postanski_broj EditEntryClass             ! Edit-in-place class for field MJE:Postanski_broj
EditInPlace::MJE:Naziv_mjesta EditEntryClass               ! Edit-in-place class for field MJE:Naziv_mjesta

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:MJESTO,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,MJE:PK_Mjesto_postanski_broj)         ! Add the sort order for MJE:PK_Mjesto_postanski_broj for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,MJE:Postanski_broj,1,BRW1)     ! Initialize the browse locator using  using key: MJE:PK_Mjesto_postanski_broj , MJE:Postanski_broj
  BRW1.AddField(MJE:Postanski_broj,BRW1.Q.MJE:Postanski_broj) ! Field MJE:Postanski_broj is a hot field or requires assignment from browse
  BRW1.AddField(MJE:Naziv_mjesta,BRW1.Q.MJE:Naziv_mjesta)  ! Field MJE:Naziv_mjesta is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisMjesta',BrowseWindow)                 ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:MJESTO.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisMjesta',BrowseWindow)              ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeMjesta
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::MJE:Postanski_broj,1)
  SELF.AddEditControl(EditInPlace::MJE:Naziv_mjesta,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

