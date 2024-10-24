

   MEMBER('matija_cerovac_projekt_2021.clw')               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021003.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021001.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021002.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeMjesta PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::MJE:Record  LIKE(MJE:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka...'),AT(,,217,157),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Postanski Broj:'),AT(12,6),USE(?MJE:Postanski_broj:Prompt)
                       ENTRY(@s39),AT(62,6,60,10),USE(MJE:Postanski_broj)
                       PROMPT('Naziv Mjesta:'),AT(12,26),USE(?MJE:Naziv_mjesta:Prompt)
                       ENTRY(@s40),AT(62,25,60,10),USE(MJE:Naziv_mjesta)
                       BUTTON('OK'),AT(2,144,40,12),USE(?OK),REQ
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
    ActionMessage = 'Dodavanje Zapisa'
  OF ChangeRecord
    ActionMessage = 'Izmjena Zapisa'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?MJE:Postanski_broj:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(MJE:Record,History::MJE:Record)
  SELF.AddHistoryField(?MJE:Postanski_broj,1)
  SELF.AddHistoryField(?MJE:Naziv_mjesta,2)
  SELF.AddUpdateFile(Access:MJESTO)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:MJESTO
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
  INIMgr.Fetch('AzuriranjeMjesta',FormWindow)              ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeMjesta',FormWindow)           ! Save window data to non-volatile store
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
AzuriranjeRoba PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ROB:Record  LIKE(ROB:RECORD),THREAD
FormWindow           WINDOW('Update Records...'),AT(,,240,112),CENTER,GRAY,MDI,SYSTEM
                       PROMPT('Sifra robe:'),AT(14,6),USE(?ROB:Sifra_robe:Prompt:3)
                       ENTRY(@N010),AT(64,5,60,10),USE(ROB:Sifra_robe,,?ROB:Sifra_robe:3),DECIMAL(14)
                       PROMPT('Naziv robe:'),AT(14,24),USE(?ROB:Naziv_robe:Prompt:3)
                       ENTRY(@s30),AT(64,24,60,10),USE(ROB:Naziv_robe,,?ROB:Naziv_robe:2)
                       PROMPT('Cijena:'),AT(14,42),USE(?ROB:Cijena:Prompt)
                       ENTRY(@n10.2),AT(64,42,60,10),USE(ROB:Cijena),DECIMAL(14)
                       PROMPT('Sifra jedinice mjere:'),AT(14,68),USE(?ROB:Sifra_jedinice_mjere:Prompt:3)
                       ENTRY(@N10),AT(82,67,60,10),USE(ROB:Sifra_jedinice_mjere,,?ROB:Sifra_jedinice_mjere:3),DECIMAL(14)
                       STRING(@s20),AT(154,68),USE(JED:Naziv_jedinice_mjere)
                       BUTTON('OK'),AT(2,91,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(46,91,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,91),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('AzuriranjeRoba')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ROB:Sifra_robe:Prompt:3
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ROB:Record,History::ROB:Record)
  SELF.AddHistoryField(?ROB:Sifra_robe:3,2)
  SELF.AddHistoryField(?ROB:Naziv_robe:2,3)
  SELF.AddHistoryField(?ROB:Cijena,4)
  SELF.AddHistoryField(?ROB:Sifra_jedinice_mjere:3,1)
  SELF.AddUpdateFile(Access:ROBA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:ROBA.Open                                         ! File ROBA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ROBA
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
  INIMgr.Fetch('AzuriranjeRoba',FormWindow)                ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeRoba',FormWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  JED:Sifra_jedinice_mjere = ROB:Sifra_jedinice_mjere      ! Assign linking field value
  Access:JEDINICA_MJERE.Fetch(JED:PK_JedinicaMjere_sifra_jedinice_mjere)
  JED:Sifra_jedinice_mjere = ROB:Sifra_jedinice_mjere      ! Assign linking field value
  Access:JEDINICA_MJERE.Fetch(JED:PK_JedinicaMjere_sifra_jedinice_mjere)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisJedinicaMjere
    ReturnValue = GlobalResponse
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?ROB:Sifra_jedinice_mjere:3
      JED:Sifra_jedinice_mjere = ROB:Sifra_jedinice_mjere
      IF Access:JEDINICA_MJERE.TryFetch(JED:PK_JedinicaMjere_sifra_jedinice_mjere)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          ROB:Sifra_jedinice_mjere = JED:Sifra_jedinice_mjere
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeStranaka PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::STR:Record  LIKE(STR:RECORD),THREAD
FormWindow           WINDOW('Update Records...'),AT(,,260,124),CENTER,GRAY,MDI,SYSTEM
                       PROMPT('OIB stranke:'),AT(8,7),USE(?STR:OIB_stranke:Prompt)
                       ENTRY(@N011),AT(60,6,60,10),USE(STR:OIB_stranke),DECIMAL(14)
                       PROMPT('Naziv stranke:'),AT(8,25),USE(?STR:Naziv_stranke:Prompt)
                       ENTRY(@s30),AT(60,24,60,10),USE(STR:Naziv_stranke)
                       PROMPT('Adresa stranke:'),AT(8,45),USE(?STR:Adresa_stranke:Prompt)
                       ENTRY(@s39),AT(60,44,60,10),USE(STR:Adresa_stranke)
                       PROMPT('Tel fax:'),AT(8,64),USE(?STR:Tel_fax:Prompt)
                       ENTRY(@s29),AT(60,64,60,10),USE(STR:Tel_fax)
                       PROMPT('Postanski broj:'),AT(8,86),USE(?MJE:Postanski_broj:Prompt)
                       ENTRY(@s39),AT(60,86,70,10),USE(MJE:Postanski_broj)
                       STRING(@s40),AT(133,86),USE(MJE:Naziv_mjesta)
                       BUTTON('OK'),AT(2,104,40,12),USE(?OK),REQ
                       BUTTON('Cancel'),AT(46,104,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,104),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('AzuriranjeStranaka')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?STR:OIB_stranke:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(STR:Record,History::STR:Record)
  SELF.AddHistoryField(?STR:OIB_stranke,2)
  SELF.AddHistoryField(?STR:Naziv_stranke,3)
  SELF.AddHistoryField(?STR:Adresa_stranke,4)
  SELF.AddHistoryField(?STR:Tel_fax,5)
  SELF.AddUpdateFile(Access:STRANKA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:STRANKA.Open                                      ! File STRANKA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:STRANKA
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
  INIMgr.Fetch('AzuriranjeStranaka',FormWindow)            ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeStranaka',FormWindow)         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  MJE:Postanski_broj = STR:Postanski_broj                  ! Assign linking field value
  Access:MJESTO.Fetch(MJE:PK_Mjesto_postanski_broj)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisMjesta
    ReturnValue = GlobalResponse
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?MJE:Postanski_broj
      MJE:Postanski_broj = MJE:Postanski_broj
      IF Access:MJESTO.TryFetch(MJE:PK_Mjesto_postanski_broj)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          MJE:Postanski_broj = MJE:Postanski_broj
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeNarudzbenica PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
BRW6::View:Browse    VIEW(POTPISUJE)
                       PROJECT(POT:Rbr_potpisa)
                       PROJECT(POT:Broj_narudzbenice)
                       PROJECT(POT:Mbr_djelatnika)
                       PROJECT(POT:Sifra_uloge_potpisa)
                       JOIN(DJE:PK_Djelatnik_mbr_djelatnika,POT:Mbr_djelatnika)
                         PROJECT(DJE:Mbr_djelatnika)
                         PROJECT(DJE:Ime_djelatnika)
                         PROJECT(DJE:Prezime_djelatnika)
                       END
                       JOIN(ULP:PK_UlogaPotpisa_sifra_uloge_potpisa,POT:Sifra_uloge_potpisa)
                         PROJECT(ULP:Sifra_uloge_potpisa)
                         PROJECT(ULP:Naziv_uloge_potpisa)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
POT:Rbr_potpisa        LIKE(POT:Rbr_potpisa)          !List box control field - type derived from field
DJE:Mbr_djelatnika     LIKE(DJE:Mbr_djelatnika)       !List box control field - type derived from field
DJE:Ime_djelatnika     LIKE(DJE:Ime_djelatnika)       !List box control field - type derived from field
DJE:Prezime_djelatnika LIKE(DJE:Prezime_djelatnika)   !List box control field - type derived from field
ULP:Sifra_uloge_potpisa LIKE(ULP:Sifra_uloge_potpisa) !List box control field - type derived from field
ULP:Naziv_uloge_potpisa LIKE(ULP:Naziv_uloge_potpisa) !List box control field - type derived from field
POT:Broj_narudzbenice  LIKE(POT:Broj_narudzbenice)    !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(STAVKA)
                       PROJECT(STA:Rbr_stavke)
                       PROJECT(STA:Kolicina)
                       PROJECT(STA:Iznos_stavke)
                       PROJECT(STA:Broj_narudzbenice)
                       PROJECT(STA:Sifra_robe)
                       JOIN(ROB:PK_Roba_sifra_robe,STA:Sifra_robe)
                         PROJECT(ROB:Sifra_robe)
                         PROJECT(ROB:Naziv_robe)
                         PROJECT(ROB:Cijena)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
STA:Rbr_stavke         LIKE(STA:Rbr_stavke)           !List box control field - type derived from field
STA:Kolicina           LIKE(STA:Kolicina)             !List box control field - type derived from field
STA:Iznos_stavke       LIKE(STA:Iznos_stavke)         !List box control field - type derived from field
ROB:Sifra_robe         LIKE(ROB:Sifra_robe)           !List box control field - type derived from field
ROB:Naziv_robe         LIKE(ROB:Naziv_robe)           !List box control field - type derived from field
ROB:Cijena             LIKE(ROB:Cijena)               !List box control field - type derived from field
STA:Broj_narudzbenice  LIKE(STA:Broj_narudzbenice)    !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::NAR:Record  LIKE(NAR:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka...'),AT(,,396,350),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Broj Narudzbenice:'),AT(12,8),USE(?NAR:Broj_narudzbenice:Prompt)
                       ENTRY(@N010),AT(87,7,60,10),USE(NAR:Broj_narudzbenice),DECIMAL(14)
                       PROMPT('Datum Narudzbenice:'),AT(12,26),USE(?NAR:Datum_narudzbenice:Prompt)
                       ENTRY(@D6),AT(87,26,60,10),USE(NAR:Datum_narudzbenice)
                       PROMPT('Rok Placanja:'),AT(12,44),USE(?NAR:Rok_placanja:Prompt)
                       ENTRY(@s29),AT(87,44,60,10),USE(NAR:Rok_placanja)
                       PROMPT('Napomena:'),AT(11,64),USE(?NAR:Napomena:Prompt)
                       ENTRY(@s50),AT(87,63,60,10),USE(NAR:Napomena)
                       PROMPT('Sifra Nacina Otpreme:'),AT(156,8),USE(?NAR:Sifra_nacina_otpreme:Prompt)
                       ENTRY(@N010),AT(223,8,60,10),USE(NAR:Sifra_nacina_otpreme),DECIMAL(14)
                       PROMPT('Rbr. Roka Isporuke:'),AT(156,26),USE(?NAR:Rbr_roka_isporuke:Prompt)
                       ENTRY(@N05),AT(223,26,60,10),USE(NAR:Rbr_roka_isporuke),DECIMAL(14)
                       PROMPT('Sifra Nacina Placanja:'),AT(154,48),USE(?NAR:Sifra_nacina_placanja:Prompt)
                       ENTRY(@N010),AT(223,48,60,10),USE(NAR:Sifra_nacina_placanja),DECIMAL(14)
                       STRING(@s30),AT(286,8,108),USE(OTP:Naziv_nacina_otpreme)
                       STRING(@s30),AT(286,26,108),USE(ROK:Naziv_roka_isporuke)
                       STRING(@s30),AT(286,48,108),USE(PLA:Naziv_nacina_placanja)
                       LIST,AT(8,122,386,40),USE(?List:2),DECIMAL(14),HVSCROLL,COLOR(COLOR:White),FORMAT('42L(2)|M~R' & |
  'br Potpisa~C(0)@N5@45L(2)|M~Mbr Djelatnika~C(0)@N010@75L(2)|M~Ime Djelatnika~C(0)@s2' & |
  '0@76L(2)|M~Prezime Djelatnika~C(0)@s20@61L(2)|M~Sifra Uloge Potpisa~C(0)@N010@120L(2' & |
  ')|M~Naziv Uloge Potpisa~C(0)@s30@'),FROM(Queue:Browse:1),IMM
                       BUTTON('&Unos'),AT(11,166,42,12),USE(?Insert)
                       BUTTON('&Promjena'),AT(53,166,42,12),USE(?Change)
                       BUTTON('&Brisanje'),AT(95,166,42,12),USE(?Delete)
                       LIST,AT(8,214,378,100),USE(?List:3),DECIMAL(14),HVSCROLL,COLOR(COLOR:White),FORMAT('37L(2)|M~R' & |
  'br stavke~C(0)@N05@72L(2)|M~Kolicina~C(0)@s19@42L(2)|M~Iznos stavke~C(0)@n-10.2@40L(' & |
  '2)|M~Sifra robe~C(0)@N010@112L(2)|M~Naziv robe~C(0)@s30@40L(2)|M~Cijena~C(0)@n10.2@'),FROM(Queue:Browse:2), |
  IMM
                       BUTTON('&Unos'),AT(11,317,42,12),USE(?Insert:2)
                       BUTTON('&Promjena'),AT(53,317,42,12),USE(?Change:2)
                       BUTTON('&Brisanje'),AT(95,317,42,12),USE(?Delete:2)
                       PROMPT('Ukupno:'),AT(42,84),USE(?NAR:Ukupno:Prompt)
                       ENTRY(@n10.2),AT(74,84,60,10),USE(NAR:Ukupno),DECIMAL(14)
                       STRING('Potpisuje:'),AT(11,108),USE(?STRING1)
                       STRING('Stavka:'),AT(8,200),USE(?STRING2)
                       BUTTON('OK'),AT(2,336,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Prekid'),AT(46,336,40,12),USE(?Cancel)
                       STRING(@S40),AT(92,336),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
BRW6                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW6::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW8                 CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('AzuriranjeNarudzbenica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?NAR:Broj_narudzbenice:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(NAR:Record,History::NAR:Record)
  SELF.AddHistoryField(?NAR:Broj_narudzbenice,5)
  SELF.AddHistoryField(?NAR:Datum_narudzbenice,6)
  SELF.AddHistoryField(?NAR:Rok_placanja,7)
  SELF.AddHistoryField(?NAR:Napomena,8)
  SELF.AddHistoryField(?NAR:Sifra_nacina_otpreme,2)
  SELF.AddHistoryField(?NAR:Rbr_roka_isporuke,3)
  SELF.AddHistoryField(?NAR:Sifra_nacina_placanja,4)
  SELF.AddHistoryField(?NAR:Ukupno,1)
  SELF.AddUpdateFile(Access:NARUDZBENICA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:NARUDZBENICA.SetOpenRelated()
  Relate:NARUDZBENICA.Open                                 ! File NARUDZBENICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:NARUDZBENICA
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
  BRW6.Init(?List:2,Queue:Browse:1.ViewPosition,BRW6::View:Browse,Queue:Browse:1,Relate:POTPISUJE,SELF) ! Initialize the browse manager
  BRW8.Init(?List:3,Queue:Browse:2.ViewPosition,BRW8::View:Browse,Queue:Browse:2,Relate:STAVKA,SELF) ! Initialize the browse manager
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  BRW6.Q &= Queue:Browse:1
  BRW6.AddSortOrder(,POT:PK_Potpisuje_broj_narudzbenice_rbr_potpisa) ! Add the sort order for POT:PK_Potpisuje_broj_narudzbenice_rbr_potpisa for sort order 1
  BRW6.AddLocator(BRW6::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW6::Sort0:Locator.Init(,POT:Broj_narudzbenice,1,BRW6)  ! Initialize the browse locator using  using key: POT:PK_Potpisuje_broj_narudzbenice_rbr_potpisa , POT:Broj_narudzbenice
  BRW6.AddField(POT:Rbr_potpisa,BRW6.Q.POT:Rbr_potpisa)    ! Field POT:Rbr_potpisa is a hot field or requires assignment from browse
  BRW6.AddField(DJE:Mbr_djelatnika,BRW6.Q.DJE:Mbr_djelatnika) ! Field DJE:Mbr_djelatnika is a hot field or requires assignment from browse
  BRW6.AddField(DJE:Ime_djelatnika,BRW6.Q.DJE:Ime_djelatnika) ! Field DJE:Ime_djelatnika is a hot field or requires assignment from browse
  BRW6.AddField(DJE:Prezime_djelatnika,BRW6.Q.DJE:Prezime_djelatnika) ! Field DJE:Prezime_djelatnika is a hot field or requires assignment from browse
  BRW6.AddField(ULP:Sifra_uloge_potpisa,BRW6.Q.ULP:Sifra_uloge_potpisa) ! Field ULP:Sifra_uloge_potpisa is a hot field or requires assignment from browse
  BRW6.AddField(ULP:Naziv_uloge_potpisa,BRW6.Q.ULP:Naziv_uloge_potpisa) ! Field ULP:Naziv_uloge_potpisa is a hot field or requires assignment from browse
  BRW6.AddField(POT:Broj_narudzbenice,BRW6.Q.POT:Broj_narudzbenice) ! Field POT:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW8.Q &= Queue:Browse:2
  BRW8.AddSortOrder(,STA:PK_Stavka_broj_narudzbenice_rbr_stavke) ! Add the sort order for STA:PK_Stavka_broj_narudzbenice_rbr_stavke for sort order 1
  BRW8.AddRange(STA:Broj_narudzbenice,Relate:STAVKA,Relate:NARUDZBENICA) ! Add file relationship range limit for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,STA:Rbr_stavke,1,BRW8)         ! Initialize the browse locator using  using key: STA:PK_Stavka_broj_narudzbenice_rbr_stavke , STA:Rbr_stavke
  BRW8.AddField(STA:Rbr_stavke,BRW8.Q.STA:Rbr_stavke)      ! Field STA:Rbr_stavke is a hot field or requires assignment from browse
  BRW8.AddField(STA:Kolicina,BRW8.Q.STA:Kolicina)          ! Field STA:Kolicina is a hot field or requires assignment from browse
  BRW8.AddField(STA:Iznos_stavke,BRW8.Q.STA:Iznos_stavke)  ! Field STA:Iznos_stavke is a hot field or requires assignment from browse
  BRW8.AddField(ROB:Sifra_robe,BRW8.Q.ROB:Sifra_robe)      ! Field ROB:Sifra_robe is a hot field or requires assignment from browse
  BRW8.AddField(ROB:Naziv_robe,BRW8.Q.ROB:Naziv_robe)      ! Field ROB:Naziv_robe is a hot field or requires assignment from browse
  BRW8.AddField(ROB:Cijena,BRW8.Q.ROB:Cijena)              ! Field ROB:Cijena is a hot field or requires assignment from browse
  BRW8.AddField(STA:Broj_narudzbenice,BRW8.Q.STA:Broj_narudzbenice) ! Field STA:Broj_narudzbenice is a hot field or requires assignment from browse
  INIMgr.Fetch('AzuriranjeNarudzbenica',FormWindow)        ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  BRW6.AskProcedure = 4                                    ! Will call: AzuriranjePotpisivanja
  BRW8.AskProcedure = 5                                    ! Will call: AzuriranjeStavki
  BRW6.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('AzuriranjeNarudzbenica',FormWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  OTP:Sifra_nacina_otpreme = NAR:Sifra_nacina_otpreme      ! Assign linking field value
  Access:OTPREME_NACIN.Fetch(OTP:PK_NacinOtpreme_sifra_nacina_otpreme)
  ROK:Rbr_roka_isporuke = NAR:Rbr_roka_isporuke            ! Assign linking field value
  Access:ROK_ISPORUKE.Fetch(ROK:PK_RokIsporuke_rbr_roka_isporuke)
  PLA:Sifra_nacina_placanja = NAR:Sifra_nacina_placanja    ! Assign linking field value
  Access:PLACANJA_NACIN.Fetch(PLA:PK_NacinPlacanja_sifra_nacina_placanja)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
      PopisNacinaotpreme
      PopisRokaIsporuke
      PopisNacinaPlacanja
      AzuriranjePotpisivanja
      AzuriranjeStavki
    END
    ReturnValue = GlobalResponse
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?NAR:Sifra_nacina_otpreme
      OTP:Sifra_nacina_otpreme = NAR:Sifra_nacina_otpreme
      IF Access:OTPREME_NACIN.TryFetch(OTP:PK_NacinOtpreme_sifra_nacina_otpreme)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          NAR:Sifra_nacina_otpreme = OTP:Sifra_nacina_otpreme
        END
      END
      ThisWindow.Reset()
    OF ?NAR:Rbr_roka_isporuke
      ROK:Rbr_roka_isporuke = NAR:Rbr_roka_isporuke
      IF Access:ROK_ISPORUKE.TryFetch(ROK:PK_RokIsporuke_rbr_roka_isporuke)
        IF SELF.Run(2,SelectRecord) = RequestCompleted
          NAR:Rbr_roka_isporuke = ROK:Rbr_roka_isporuke
        END
      END
      ThisWindow.Reset()
    OF ?NAR:Sifra_nacina_placanja
      PLA:Sifra_nacina_placanja = NAR:Sifra_nacina_placanja
      IF Access:PLACANJA_NACIN.TryFetch(PLA:PK_NacinPlacanja_sifra_nacina_placanja)
        IF SELF.Run(3,SelectRecord) = RequestCompleted
          NAR:Sifra_nacina_placanja = PLA:Sifra_nacina_placanja
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW6.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW8.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW8.ResetFromView PROCEDURE

NAR:Ukupno:Sum       REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:STAVKA.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    NAR:Ukupno:Sum += STA:Iznos_stavke
  END
  SELF.View{PROP:IPRequestCount} = 0
  NAR:Ukupno = NAR:Ukupno:Sum
  PARENT.ResetFromView
  Relate:STAVKA.SetQuickScan(0)
  SETCURSOR()

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeUloga PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ULO:Record  LIKE(ULO:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka...'),AT(,,257,159),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Narucitelj dobavljac:'),AT(8,8),USE(?ULO:Narucitelj_dobavljac:Prompt)
                       ENTRY(@s30),AT(74,8,60,10),USE(ULO:Narucitelj_dobavljac)
                       PROMPT('Broj narudzbenice:'),AT(8,21),USE(?ULO:Broj_narudzbenice:Prompt)
                       ENTRY(@N010),AT(74,20,60,10),USE(ULO:Broj_narudzbenice),DECIMAL(14)
                       PROMPT('OIB stranke:'),AT(8,34),USE(?ULO:OIB_stranke:Prompt)
                       ENTRY(@N011),AT(74,34,60,10),USE(ULO:OIB_stranke),DECIMAL(14)
                       STRING(@s30),AT(145,34),USE(STR:Naziv_stranke)
                       BUTTON('OK'),AT(5,140,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Prekid'),AT(50,140,40,12),USE(?Cancel)
                       STRING(@S40),AT(95,140),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('AzuriranjeUloga')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ULO:Narucitelj_dobavljac:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ULO:Record,History::ULO:Record)
  SELF.AddHistoryField(?ULO:Narucitelj_dobavljac,2)
  SELF.AddHistoryField(?ULO:Broj_narudzbenice,3)
  SELF.AddHistoryField(?ULO:OIB_stranke,1)
  SELF.AddUpdateFile(Access:ULOGA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:ULOGA.Open                                        ! File ULOGA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ULOGA
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
  INIMgr.Fetch('AzuriranjeUloga',FormWindow)               ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ULOGA.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeUloga',FormWindow)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  STR:OIB_stranke = ULO:OIB_stranke                        ! Assign linking field value
  Access:STRANKA.Fetch(STR:PK_Stranka_OIB_stranke)
  NAR:Broj_narudzbenice = ULO:Broj_narudzbenice            ! Assign linking field value
  Access:NARUDZBENICA.Fetch(NAR:PK_Narudzbenica_broj_narudzbenice)
  NAR:Broj_narudzbenice = ULO:Broj_narudzbenice            ! Assign linking field value
  Access:NARUDZBENICA.Fetch(NAR:PK_Narudzbenica_broj_narudzbenice)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisNarudzbenica
    ReturnValue = GlobalResponse
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?ULO:Broj_narudzbenice
      NAR:Broj_narudzbenice = ULO:Broj_narudzbenice
      IF Access:NARUDZBENICA.TryFetch(NAR:PK_Narudzbenica_broj_narudzbenice)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          ULO:Broj_narudzbenice = NAR:Broj_narudzbenice
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjePotpisivanja PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::POT:Record  LIKE(POT:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka...'),AT(,,231,159),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       PROMPT('Rbr. Potpisa:'),AT(8,6),USE(?POT:Rbr_potpisa:Prompt)
                       ENTRY(@N5),AT(68,6,60,10),USE(POT:Rbr_potpisa),DECIMAL(14)
                       PROMPT('Broj Narudzbenice:'),AT(8,24),USE(?POT:Broj_narudzbenice:Prompt)
                       ENTRY(@N010),AT(68,24,60,10),USE(POT:Broj_narudzbenice),DECIMAL(14)
                       PROMPT('Mbr. Djelatnika:'),AT(8,56),USE(?DJE:Mbr_djelatnika:Prompt)
                       ENTRY(@N010),AT(68,56,60,10),USE(DJE:Mbr_djelatnika),DECIMAL(14)
                       BUTTON('OK'),AT(5,140,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Prekid'),AT(50,140,40,12),USE(?Cancel)
                       STRING(@S40),AT(95,140),USE(ActionMessage)
                       STRING(@s20),AT(144,50),USE(DJE:Ime_djelatnika,,?DJE:Ime_djelatnika:2)
                       STRING(@s20),AT(144,62),USE(DJE:Prezime_djelatnika,,?DJE:Prezime_djelatnika:2)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('AzuriranjePotpisivanja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?POT:Rbr_potpisa:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(POT:Record,History::POT:Record)
  SELF.AddHistoryField(?POT:Rbr_potpisa,4)
  SELF.AddHistoryField(?POT:Broj_narudzbenice,3)
  SELF.AddUpdateFile(Access:POTPISUJE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:POTPISUJE.SetOpenRelated()
  Relate:POTPISUJE.Open                                    ! File POTPISUJE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:POTPISUJE
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
  INIMgr.Fetch('AzuriranjePotpisivanja',FormWindow)        ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:POTPISUJE.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjePotpisivanja',FormWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  DJE:Mbr_djelatnika = POT:Mbr_djelatnika                  ! Assign linking field value
  Access:DJELATNIK.Fetch(DJE:PK_Djelatnik_mbr_djelatnika)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisDjelatnika
    ReturnValue = GlobalResponse
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?DJE:Mbr_djelatnika
      DJE:Mbr_djelatnika = DJE:Mbr_djelatnika
      IF Access:DJELATNIK.TryFetch(DJE:PK_Djelatnik_mbr_djelatnika)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          DJE:Mbr_djelatnika = DJE:Mbr_djelatnika
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeStavki PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::STA:Record  LIKE(STA:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Podataka...'),AT(,,289,159),CENTER,COLOR(00DEC4B0h),GRAY,MDI,SYSTEM
                       BUTTON('OK'),AT(5,140,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Prekid'),AT(50,140,40,12),USE(?Cancel)
                       STRING(@S40),AT(95,140),USE(ActionMessage)
                       PROMPT('Rbr. Stavke:'),AT(10,11),USE(?STA:Rbr_stavke:Prompt)
                       ENTRY(@N05),AT(66,10,60,10),USE(STA:Rbr_stavke),DECIMAL(14)
                       PROMPT('Sifra Robe:'),AT(10,25),USE(?STA:Sifra_robe:Prompt)
                       ENTRY(@N010),AT(66,24,60,10),USE(STA:Sifra_robe),DECIMAL(14)
                       PROMPT('Kolicina:'),AT(10,40),USE(?STA:Kolicina:Prompt)
                       ENTRY(@s19),AT(66,40,60,10),USE(STA:Kolicina)
                       PROMPT('Iznos Stavke:'),AT(10,53),USE(?STA:Iznos_stavke:Prompt)
                       ENTRY(@n-10.2),AT(66,52,60,10),USE(STA:Iznos_stavke),DECIMAL(12)
                       STRING(@s30),AT(138,25),USE(ROB:Naziv_robe)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('AzuriranjeStavki')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(STA:Record,History::STA:Record)
  SELF.AddHistoryField(?STA:Rbr_stavke,3)
  SELF.AddHistoryField(?STA:Sifra_robe,1)
  SELF.AddHistoryField(?STA:Kolicina,4)
  SELF.AddHistoryField(?STA:Iznos_stavke,5)
  SELF.AddUpdateFile(Access:STAVKA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:STAVKA.Open                                       ! File STAVKA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:STAVKA
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
  INIMgr.Fetch('AzuriranjeStavki',FormWindow)              ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:STAVKA.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeStavki',FormWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  ROB:Sifra_robe = STA:Sifra_robe                          ! Assign linking field value
  Access:ROBA.Fetch(ROB:PK_Roba_sifra_robe)
  ROB:Sifra_robe = STA:Sifra_robe                          ! Assign linking field value
  Access:ROBA.Fetch(ROB:PK_Roba_sifra_robe)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisRoba
    ReturnValue = GlobalResponse
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?STA:Sifra_robe
      ROB:Sifra_robe = STA:Sifra_robe
      IF Access:ROBA.TryFetch(ROB:PK_Roba_sifra_robe)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          STA:Sifra_robe = ROB:Sifra_robe
        END
      END
      ThisWindow.Reset()
    OF ?STA:Iznos_stavke
      STA:Iznos_stavke=STA:Kolicina*ROB:Cijena
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Splash
!!! </summary>
SplashProzor PROCEDURE 

window               WINDOW,AT(,,204,112),FONT('Microsoft Sans Serif',8,,FONT:regular),NOFRAME,CENTER,GRAY,MDI
                       PANEL,AT(0,-42,204,154),USE(?PANEL1),BEVEL(6)
                       PANEL,AT(7,6,191,98),USE(?PANEL2),BEVEL(-2,1),FILL(00B48246h)
                       STRING('Dobrodosli u aplikaciju!!!'),AT(13,12,182,10),USE(?String2),CENTER,COLOR(00FACE87h)
                       IMAGE('sv_small.jpg'),AT(68,61),USE(?Image1)
                       PANEL,AT(12,33,182,12),USE(?PANEL3),BEVEL(-1,1,9),FILL(00FACE87h)
                       STRING('Napravljeno sa Clarionom!'),AT(13,48,182,10),USE(?String1),CENTER,COLOR(00FACE87h)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SplashProzor')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PANEL1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(window)                                        ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('SplashProzor',window)                      ! Restore window settings from non-volatile store
  TARGET{Prop:Timer} = 500                                 ! Close window on timer event, so configure timer
  TARGET{Prop:Alrt,255} = MouseLeft                        ! Alert mouse clicks that will close window
  TARGET{Prop:Alrt,254} = MouseLeft2
  TARGET{Prop:Alrt,253} = MouseRight
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('SplashProzor',window)                   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
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
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)                            ! Splash window will close on mouse click
      END
    OF EVENT:LoseFocus
        POST(Event:CloseWindow)                            ! Splash window will close when focus is lost
    OF Event:Timer
      POST(Event:CloseWindow)                              ! Splash window will close on event timer
    OF Event:AlertKey
      CASE KEYCODE()                                       ! Splash window will close on mouse click
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)
      END
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IzvijesceNacinaOtpreme PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(OTPREME_NACIN)
                       PROJECT(OTP:Naziv_nacina_otpreme)
                       PROJECT(OTP:Sifra_nacina_otpreme)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header)
                         STRING('Datum izvjesca:'),AT(31,31),USE(?ReportDatePrompt),TRN
                         STRING('<<-- Date Stamp -->'),AT(1062,31),USE(?ReportDateStamp),TRN
                         STRING('Vrijeme izvjesca:'),AT(3948,31),USE(?ReportTimePrompt),TRN
                         STRING('<<-- Time Stamp -->'),AT(5042,31),USE(?ReportTimeStamp),TRN
                         STRING('Popis nacina otpreme'),AT(1844,479),USE(?STRING1),FONT('Arial Rounded MT Bold',18, |
  ,,CHARSET:ANSI)
                       END
Detail                 DETAIL,AT(0,0,6250,458),USE(?Detail)
                         STRING(@N010),AT(2073,167),USE(OTP:Sifra_nacina_otpreme),DECIMAL(14)
                         STRING(@s30),AT(3240,167,740),USE(OTP:Naziv_nacina_otpreme)
                       END
                       FOOTER,AT(1000,9688,6250,302),USE(?Footer)
                         STRING(@N3),AT(5844,31),USE(ReportPageNumber)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepRealClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

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
  GlobalErrors.SetProcedureName('IzvijesceNacinaOtpreme')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:OTPREME_NACIN.Open                                ! File OTPREME_NACIN used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IzvijesceNacinaOtpreme',ProgressWindow)    ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:OTPREME_NACIN, ?Progress:PctText, Progress:Thermometer, ProgressMgr, OTP:Sifra_nacina_otpreme)
  ThisReport.AddSortOrder(OTP:PK_NacinOtpreme_sifra_nacina_otpreme)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:OTPREME_NACIN.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
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
    INIMgr.Update('IzvijesceNacinaOtpreme',ProgressWindow) ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportTimeStamp{PROP:Text} = FORMAT(CLOCK(),@T7)
  END
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

