

   MEMBER('matija_cerovac_projekt_2021.clw')               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021003.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisDjelatnika PROCEDURE 

BRW1::View:Browse    VIEW(DJELATNIK)
                       PROJECT(DJE:Mbr_djelatnika)
                       PROJECT(DJE:Ime_djelatnika)
                       PROJECT(DJE:Prezime_djelatnika)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
DJE:Mbr_djelatnika     LIKE(DJE:Mbr_djelatnika)       !List box control field - type derived from field
DJE:Ime_djelatnika     LIKE(DJE:Ime_djelatnika)       !List box control field - type derived from field
DJE:Prezime_djelatnika LIKE(DJE:Prezime_djelatnika)   !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,247,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('76L(2)|M~Maticni Broj' & |
  ' Djelatnika~C(0)@N010@77L(2)|M~Ime Djelatnika~C(0)@s20@80L(2)|M~Prezime Djelatnika~C(0)@s20@'), |
  FROM(Queue:Browse),IMM,MSG('Browsing Records')
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
EditInPlace::DJE:Mbr_djelatnika EditEntryClass             ! Edit-in-place class for field DJE:Mbr_djelatnika
EditInPlace::DJE:Ime_djelatnika EditEntryClass             ! Edit-in-place class for field DJE:Ime_djelatnika
EditInPlace::DJE:Prezime_djelatnika EditEntryClass         ! Edit-in-place class for field DJE:Prezime_djelatnika

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
  GlobalErrors.SetProcedureName('PopisDjelatnika')
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
  Relate:DJELATNIK.Open                                    ! File DJELATNIK used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:DJELATNIK,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,DJE:PK_Djelatnik_mbr_djelatnika)      ! Add the sort order for DJE:PK_Djelatnik_mbr_djelatnika for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,DJE:Mbr_djelatnika,1,BRW1)     ! Initialize the browse locator using  using key: DJE:PK_Djelatnik_mbr_djelatnika , DJE:Mbr_djelatnika
  BRW1.AddField(DJE:Mbr_djelatnika,BRW1.Q.DJE:Mbr_djelatnika) ! Field DJE:Mbr_djelatnika is a hot field or requires assignment from browse
  BRW1.AddField(DJE:Ime_djelatnika,BRW1.Q.DJE:Ime_djelatnika) ! Field DJE:Ime_djelatnika is a hot field or requires assignment from browse
  BRW1.AddField(DJE:Prezime_djelatnika,BRW1.Q.DJE:Prezime_djelatnika) ! Field DJE:Prezime_djelatnika is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisDjelatnika',BrowseWindow)             ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:DJELATNIK.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisDjelatnika',BrowseWindow)          ! Save window data to non-volatile store
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
    AzuriranjeDjelatnika
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::DJE:Mbr_djelatnika,1)
  SELF.AddEditControl(EditInPlace::DJE:Ime_djelatnika,2)
  SELF.AddEditControl(EditInPlace::DJE:Prezime_djelatnika,3)
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
PopisUlogaPotpisa PROCEDURE 

BRW1::View:Browse    VIEW(ULOGA_POTPISA)
                       PROJECT(ULP:Sifra_uloge_potpisa)
                       PROJECT(ULP:Naziv_uloge_potpisa)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ULP:Sifra_uloge_potpisa LIKE(ULP:Sifra_uloge_potpisa) !List box control field - type derived from field
ULP:Naziv_uloge_potpisa LIKE(ULP:Naziv_uloge_potpisa) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,247,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('66L(2)|M~Sifra Uloge ' & |
  'Potpisa~C(0)@N010@120L(2)|M~Naziv Uloge Potpisa~C(0)@s30@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
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
EditInPlace::ULP:Sifra_uloge_potpisa EditEntryClass        ! Edit-in-place class for field ULP:Sifra_uloge_potpisa
EditInPlace::ULP:Naziv_uloge_potpisa EditEntryClass        ! Edit-in-place class for field ULP:Naziv_uloge_potpisa

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
  GlobalErrors.SetProcedureName('PopisUlogaPotpisa')
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
  Relate:ULOGA_POTPISA.Open                                ! File ULOGA_POTPISA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:ULOGA_POTPISA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,ULP:PK_UlogaPotpisa_sifra_uloge_potpisa) ! Add the sort order for ULP:PK_UlogaPotpisa_sifra_uloge_potpisa for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,ULP:Sifra_uloge_potpisa,1,BRW1) ! Initialize the browse locator using  using key: ULP:PK_UlogaPotpisa_sifra_uloge_potpisa , ULP:Sifra_uloge_potpisa
  BRW1.AddField(ULP:Sifra_uloge_potpisa,BRW1.Q.ULP:Sifra_uloge_potpisa) ! Field ULP:Sifra_uloge_potpisa is a hot field or requires assignment from browse
  BRW1.AddField(ULP:Naziv_uloge_potpisa,BRW1.Q.ULP:Naziv_uloge_potpisa) ! Field ULP:Naziv_uloge_potpisa is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisUlogaPotpisa',BrowseWindow)           ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ULOGA_POTPISA.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisUlogaPotpisa',BrowseWindow)        ! Save window data to non-volatile store
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
    AzuriranjeUlogaPotpisa
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::ULP:Sifra_uloge_potpisa,1)
  SELF.AddEditControl(EditInPlace::ULP:Naziv_uloge_potpisa,2)
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
PopisRoba PROCEDURE 

BRW1::View:Browse    VIEW(ROBA)
                       PROJECT(ROB:Sifra_robe)
                       PROJECT(ROB:Naziv_robe)
                       PROJECT(ROB:Cijena)
                       PROJECT(ROB:Sifra_jedinice_mjere)
                       JOIN(JED:PK_JedinicaMjere_sifra_jedinice_mjere,ROB:Sifra_jedinice_mjere)
                         PROJECT(JED:Sifra_jedinice_mjere)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ROB:Sifra_robe         LIKE(ROB:Sifra_robe)           !List box control field - type derived from field
ROB:Naziv_robe         LIKE(ROB:Naziv_robe)           !List box control field - type derived from field
ROB:Cijena             LIKE(ROB:Cijena)               !List box control field - type derived from field
JED:Sifra_jedinice_mjere LIKE(JED:Sifra_jedinice_mjere) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,303,169),GRAY,MDI,SYSTEM
                       LIST,AT(5,34,286,102),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('40L(2)|M~Sifra Robe~' & |
  'C(0)@N010@111L(2)|M~Naziv Robe~C(0)@s30@42L(2)|M~Cijena~C(0)@n10.2@40L(2)|M~Sifra Je' & |
  'dinice Mjere~C(0)@N10@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(4,156,40,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(50,156,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,156,40,12),USE(?Delete)
                       BUTTON('&Odaberi'),AT(145,156,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,156,40,12),USE(?Close)
                       SHEET,AT(4,14,287,134),USE(?SHEET1)
                         TAB('Tab1'),USE(?TAB1)
                         END
                         TAB('Tab2'),USE(?TAB2)
                         END
                         TAB('Tab3'),USE(?TAB3)
                         END
                       END
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
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort1:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?Sheet1)=2
BRW1::Sort2:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?Sheet1)=3

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
  GlobalErrors.SetProcedureName('PopisRoba')
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
  Relate:ROBA.Open                                         ! File ROBA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:ROBA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,ROB:SK_Roba_naziv)                    ! Add the sort order for ROB:SK_Roba_naziv for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(,ROB:Naziv_robe,1,BRW1)         ! Initialize the browse locator using  using key: ROB:SK_Roba_naziv , ROB:Naziv_robe
  BRW1.AddSortOrder(,ROB:SK_Roba_cijena)                   ! Add the sort order for ROB:SK_Roba_cijena for sort order 2
  BRW1.AddLocator(BRW1::Sort2:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort2:Locator.Init(,ROB:Cijena,1,BRW1)             ! Initialize the browse locator using  using key: ROB:SK_Roba_cijena , ROB:Cijena
  BRW1.AddSortOrder(,ROB:PK_Roba_sifra_robe)               ! Add the sort order for ROB:PK_Roba_sifra_robe for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(,ROB:Sifra_robe,1,BRW1)         ! Initialize the browse locator using  using key: ROB:PK_Roba_sifra_robe , ROB:Sifra_robe
  BRW1.AddField(ROB:Sifra_robe,BRW1.Q.ROB:Sifra_robe)      ! Field ROB:Sifra_robe is a hot field or requires assignment from browse
  BRW1.AddField(ROB:Naziv_robe,BRW1.Q.ROB:Naziv_robe)      ! Field ROB:Naziv_robe is a hot field or requires assignment from browse
  BRW1.AddField(ROB:Cijena,BRW1.Q.ROB:Cijena)              ! Field ROB:Cijena is a hot field or requires assignment from browse
  BRW1.AddField(JED:Sifra_jedinice_mjere,BRW1.Q.JED:Sifra_jedinice_mjere) ! Field JED:Sifra_jedinice_mjere is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisRoba',BrowseWindow)                   ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeRoba
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ROBA.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisRoba',BrowseWindow)                ! Save window data to non-volatile store
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
    AzuriranjeRoba
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


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?Sheet1)=2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?Sheet1)=3
    RETURN SELF.SetSort(2,Force)
  ELSE
    RETURN SELF.SetSort(3,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisJedinicaMjere PROCEDURE 

BRW1::View:Browse    VIEW(JEDINICA_MJERE)
                       PROJECT(JED:Sifra_jedinice_mjere)
                       PROJECT(JED:Naziv_jedinice_mjere)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
JED:Sifra_jedinice_mjere LIKE(JED:Sifra_jedinice_mjere) !List box control field - type derived from field
JED:Naziv_jedinice_mjere LIKE(JED:Naziv_jedinice_mjere) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Podataka'),AT(0,0,247,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,COLOR(00FACE87h),FORMAT('71L(2)|M~Sifra Jedini' & |
  'ce Mjere~C(0)@N10@80L(2)|M~Naziv Jedinice Mjere~C(0)@s20@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
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
EditInPlace::JED:Sifra_jedinice_mjere EditEntryClass       ! Edit-in-place class for field JED:Sifra_jedinice_mjere
EditInPlace::JED:Naziv_jedinice_mjere EditEntryClass       ! Edit-in-place class for field JED:Naziv_jedinice_mjere

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
  GlobalErrors.SetProcedureName('PopisJedinicaMjere')
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
  Relate:JEDINICA_MJERE.Open                               ! File JEDINICA_MJERE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:JEDINICA_MJERE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,JED:PK_JedinicaMjere_sifra_jedinice_mjere) ! Add the sort order for JED:PK_JedinicaMjere_sifra_jedinice_mjere for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,JED:Sifra_jedinice_mjere,1,BRW1) ! Initialize the browse locator using  using key: JED:PK_JedinicaMjere_sifra_jedinice_mjere , JED:Sifra_jedinice_mjere
  BRW1.AddField(JED:Sifra_jedinice_mjere,BRW1.Q.JED:Sifra_jedinice_mjere) ! Field JED:Sifra_jedinice_mjere is a hot field or requires assignment from browse
  BRW1.AddField(JED:Naziv_jedinice_mjere,BRW1.Q.JED:Naziv_jedinice_mjere) ! Field JED:Naziv_jedinice_mjere is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisJedinicaMjere',BrowseWindow)          ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:JEDINICA_MJERE.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisJedinicaMjere',BrowseWindow)       ! Save window data to non-volatile store
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
    AzuriranjeJedinicaMjere
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::JED:Sifra_jedinice_mjere,1)
  SELF.AddEditControl(EditInPlace::JED:Naziv_jedinice_mjere,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeNacinaOtpreme PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::OTP:Record  LIKE(OTP:RECORD),THREAD
FormWindow           WINDOW('Update Records...'),AT(,,222,159),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Sifra Nacina Otpreme:'),AT(10,9),USE(?OTP:Sifra_nacina_otpreme:Prompt)
                       ENTRY(@N010),AT(82,8,60,10),USE(OTP:Sifra_nacina_otpreme),DECIMAL(14)
                       PROMPT('Naziv Nacina Otpreme:'),AT(10,22),USE(?OTP:Naziv_nacina_otpreme:Prompt)
                       ENTRY(@s30),AT(82,22,60,10),USE(OTP:Naziv_nacina_otpreme)
                       BUTTON('OK'),AT(2,146,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Prekid'),AT(46,146,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,146),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled Zapisa'
  OF InsertRecord
    ActionMessage = 'Dodavanje Zapisa'
  OF ChangeRecord
    ActionMessage = 'Izmjena Zapisa'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeNacinaOtpreme')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OTP:Sifra_nacina_otpreme:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(OTP:Record,History::OTP:Record)
  SELF.AddHistoryField(?OTP:Sifra_nacina_otpreme,1)
  SELF.AddHistoryField(?OTP:Naziv_nacina_otpreme,2)
  SELF.AddUpdateFile(Access:OTPREME_NACIN)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:OTPREME_NACIN.Open                                ! File OTPREME_NACIN used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:OTPREME_NACIN
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeNacinaOtpreme',FormWindow)       ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeNacinaOtpreme',FormWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeRokaIsporuke PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ROK:Record  LIKE(ROK:RECORD),THREAD
FormWindow           WINDOW('Update Records...'),AT(,,221,156),CENTER,GRAY,MDI,SYSTEM
                       PROMPT('Rbr roka isporuke:'),AT(10,6),USE(?ROK:Rbr_roka_isporuke:Prompt)
                       ENTRY(@N05),AT(80,6,60,10),USE(ROK:Rbr_roka_isporuke),DECIMAL(14)
                       PROMPT('Naziv roka isporuke:'),AT(10,25),USE(?ROK:Naziv_roka_isporuke:Prompt)
                       ENTRY(@s30),AT(80,24,60,10),USE(ROK:Naziv_roka_isporuke)
                       BUTTON('OK'),AT(2,44,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(46,44,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,44),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeRokaIsporuke')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ROK:Rbr_roka_isporuke:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ROK:Record,History::ROK:Record)
  SELF.AddHistoryField(?ROK:Rbr_roka_isporuke,1)
  SELF.AddHistoryField(?ROK:Naziv_roka_isporuke,2)
  SELF.AddUpdateFile(Access:ROK_ISPORUKE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:ROK_ISPORUKE.Open                                 ! File ROK_ISPORUKE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ROK_ISPORUKE
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeRokaIsporuke',FormWindow)        ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeRokaIsporuke',FormWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeNacinaPlacanja PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::PLA:Record  LIKE(PLA:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka...'),AT(,,221,155),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Sifra Nacina Placanja:'),AT(10,6),USE(?PLA:Sifra_nacina_placanja:Prompt)
                       ENTRY(@N010),AT(86,6,60,10),USE(PLA:Sifra_nacina_placanja),DECIMAL(14)
                       PROMPT('Naziv Nacina Placanja:'),AT(10,24),USE(?PLA:Naziv_nacina_placanja:Prompt)
                       ENTRY(@s30),AT(86,24,60,10),USE(PLA:Naziv_nacina_placanja)
                       BUTTON('OK'),AT(2,142,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Prekid'),AT(46,142,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,142),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled Zapisa'
  OF InsertRecord
    ActionMessage = 'Dodavanje Zapisa'
  OF ChangeRecord
    ActionMessage = 'Izmjena Zapisa'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeNacinaPlacanja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PLA:Sifra_nacina_placanja:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PLA:Record,History::PLA:Record)
  SELF.AddHistoryField(?PLA:Sifra_nacina_placanja,1)
  SELF.AddHistoryField(?PLA:Naziv_nacina_placanja,2)
  SELF.AddUpdateFile(Access:PLACANJA_NACIN)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:PLACANJA_NACIN.Open                               ! File PLACANJA_NACIN used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:PLACANJA_NACIN
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeNacinaPlacanja',FormWindow)      ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeNacinaPlacanja',FormWindow)   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeUlogaPotpisa PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ULP:Record  LIKE(ULP:RECORD),THREAD
FormWindow           WINDOW('Update Records...'),AT(,,224,154),CENTER,GRAY,MDI,SYSTEM
                       PROMPT('Sifra uloge potpisa:'),AT(10,8),USE(?ULP:Sifra_uloge_potpisa:Prompt)
                       ENTRY(@N010),AT(82,8,60,10),USE(ULP:Sifra_uloge_potpisa),DECIMAL(14)
                       PROMPT('Naziv uloge potpisa:'),AT(10,27),USE(?ULP:Naziv_uloge_potpisa:Prompt)
                       ENTRY(@s30),AT(82,26,60,10),USE(ULP:Naziv_uloge_potpisa)
                       BUTTON('OK'),AT(2,46,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(46,46,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,46),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeUlogaPotpisa')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ULP:Sifra_uloge_potpisa:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ULP:Record,History::ULP:Record)
  SELF.AddHistoryField(?ULP:Sifra_uloge_potpisa,1)
  SELF.AddHistoryField(?ULP:Naziv_uloge_potpisa,2)
  SELF.AddUpdateFile(Access:ULOGA_POTPISA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:ULOGA_POTPISA.Open                                ! File ULOGA_POTPISA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ULOGA_POTPISA
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeUlogaPotpisa',FormWindow)        ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ULOGA_POTPISA.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeUlogaPotpisa',FormWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeDjelatnika PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::DJE:Record  LIKE(DJE:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka...'),AT(,,222,157),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Maticni Broj Djelatnika'),AT(10,6),USE(?DJE:Mbr_djelatnika:Prompt)
                       ENTRY(@N010),AT(80,6,60,10),USE(DJE:Mbr_djelatnika),DECIMAL(14)
                       PROMPT('Ime Djelatnika:'),AT(10,24),USE(?DJE:Ime_djelatnika:Prompt)
                       ENTRY(@s20),AT(80,24,60,10),USE(DJE:Ime_djelatnika)
                       PROMPT('Prezime Djelatnika:'),AT(10,42),USE(?DJE:Prezime_djelatnika:Prompt)
                       ENTRY(@s20),AT(80,42,60,10),USE(DJE:Prezime_djelatnika)
                       BUTTON('OK'),AT(2,144,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Prekid'),AT(46,144,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,144),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled Zapisa'
  OF InsertRecord
    ActionMessage = 'Dodavanje zapisa'
  OF ChangeRecord
    ActionMessage = 'Izmjena Zapisa'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeDjelatnika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?DJE:Mbr_djelatnika:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(DJE:Record,History::DJE:Record)
  SELF.AddHistoryField(?DJE:Mbr_djelatnika,1)
  SELF.AddHistoryField(?DJE:Ime_djelatnika,2)
  SELF.AddHistoryField(?DJE:Prezime_djelatnika,3)
  SELF.AddUpdateFile(Access:DJELATNIK)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:DJELATNIK.Open                                    ! File DJELATNIK used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:DJELATNIK
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeDjelatnika',FormWindow)          ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:DJELATNIK.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeDjelatnika',FormWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeJedinicaMjere PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::JED:Record  LIKE(JED:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka'),AT(,,221,156),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Sifra Jedinice Mjere:'),AT(10,7),USE(?JED:Sifra_jedinice_mjere:Prompt)
                       ENTRY(@N10),AT(82,6,60,10),USE(JED:Sifra_jedinice_mjere),DECIMAL(14)
                       PROMPT('Naziv Jedinice Mjere:'),AT(10,26),USE(?JED:Naziv_jedinice_mjere:Prompt)
                       ENTRY(@s20),AT(82,25,60,10),USE(JED:Naziv_jedinice_mjere)
                       BUTTON('OK'),AT(2,142,40,12),USE(?OK),REQ
                       BUTTON('Prekid'),AT(46,142,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,142),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled Zapisa'
  OF InsertRecord
    ActionMessage = 'Dodavanje Zapisa'
  OF ChangeRecord
    ActionMessage = 'Izmjean Zapisa'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeJedinicaMjere')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?JED:Sifra_jedinice_mjere:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(JED:Record,History::JED:Record)
  SELF.AddHistoryField(?JED:Sifra_jedinice_mjere,1)
  SELF.AddHistoryField(?JED:Naziv_jedinice_mjere,2)
  SELF.AddUpdateFile(Access:JEDINICA_MJERE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:JEDINICA_MJERE.Open                               ! File JEDINICA_MJERE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:JEDINICA_MJERE
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeJedinicaMjere',FormWindow)       ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:JEDINICA_MJERE.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeJedinicaMjere',FormWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

