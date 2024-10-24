

   MEMBER('matija_cerovac_projekt_2021.clw')               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('MATIJA_CEROVAC_PROJEKT_2021004.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IzvijesceStranaka PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(STRANKA)
                       PROJECT(STR:Adresa_stranke)
                       PROJECT(STR:Naziv_stranke)
                       PROJECT(STR:OIB_stranke)
                       PROJECT(STR:Tel_fax)
                       PROJECT(STR:Postanski_broj)
                       JOIN(MJE:PK_Mjesto_postanski_broj,STR:Postanski_broj)
                         PROJECT(MJE:Naziv_mjesta)
                         PROJECT(MJE:Postanski_broj)
                       END
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
                         STRING('Popis stranaka'),AT(2260,552),USE(?STRING1),FONT('Arial Rounded MT Bold',18,,,CHARSET:ANSI)
                       END
Detail                 DETAIL,AT(0,0,6250,1198),USE(?Detail)
                         STRING(@N011),AT(865,31),USE(STR:OIB_stranke),DECIMAL(14)
                         STRING(@s30),AT(865,292),USE(STR:Naziv_stranke)
                         STRING(@s39),AT(865,552,1573),USE(STR:Adresa_stranke)
                         STRING(@s29),AT(865,812),USE(STR:Tel_fax)
                         STRING(@s39),AT(2594,552,687),USE(MJE:Postanski_broj)
                         STRING(@s40),AT(3344,552,979),USE(MJE:Naziv_mjesta)
                         LINE,AT(219,1052,5771,0),USE(?LINE1),COLOR(00701919h)
                       END
                       FOOTER,AT(1000,9688,6250,333),USE(?Footer)
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
  GlobalErrors.SetProcedureName('IzvijesceStranaka')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:STRANKA.Open                                      ! File STRANKA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IzvijesceStranaka',ProgressWindow)         ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:STRANKA, ?Progress:PctText, Progress:Thermometer, ProgressMgr, STR:OIB_stranke)
  ThisReport.AddSortOrder(STR:PK_Stranka_OIB_stranke)
  ThisReport.AddRange(STR:OIB_stranke)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:STRANKA.SetQuickScan(1,Propagate:OneMany)
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
    Relate:STRANKA.Close
  END
  IF SELF.Opened
    INIMgr.Update('IzvijesceStranaka',ProgressWindow)      ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IzvijesceNarudzbenica PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(OTPREME_NACIN)
                       PROJECT(OTP:Naziv_nacina_otpreme)
                       PROJECT(OTP:Sifra_nacina_otpreme)
                       JOIN(NAR:VK_Narudzbenica_NacinOtpreme_sifra_nacina_otpreme,OTP:Sifra_nacina_otpreme)
                         PROJECT(NAR:Broj_narudzbenice)
                         PROJECT(NAR:Datum_narudzbenice)
                         PROJECT(NAR:Napomena)
                         PROJECT(NAR:Rbr_roka_isporuke)
                         PROJECT(NAR:Rok_placanja)
                         PROJECT(NAR:Ukupno)
                         PROJECT(NAR:Sifra_nacina_placanja)
                         JOIN(POT:PK_Potpisuje_broj_narudzbenice_rbr_potpisa,NAR:Broj_narudzbenice)
                           PROJECT(POT:Rbr_potpisa)
                           PROJECT(POT:Sifra_uloge_potpisa)
                           PROJECT(POT:Mbr_djelatnika)
                           JOIN(DJE:PK_Djelatnik_mbr_djelatnika,POT:Mbr_djelatnika)
                             PROJECT(DJE:Ime_djelatnika)
                             PROJECT(DJE:Prezime_djelatnika)
                           END
                         END
                         JOIN(PLA:PK_NacinPlacanja_sifra_nacina_placanja,NAR:Sifra_nacina_placanja)
                           PROJECT(PLA:Naziv_nacina_placanja)
                         END
                       END
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Verdana',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header)
                         STRING('Popis narudzbenice'),AT(1958,500),USE(?STRING1),FONT(,18,,,CHARSET:DEFAULT)
                       END
Break_br_narudzbenice  BREAK(NAR:Broj_narudzbenice),USE(?BREAK1)
                         HEADER,AT(0,0,6250,1594),USE(?GROUPHEADER1)
                           STRING(@N010),AT(1375,229),USE(NAR:Broj_narudzbenice),DECIMAL(14)
                           STRING(@D6),AT(833,490),USE(NAR:Datum_narudzbenice)
                           STRING('Datum:'),AT(281,490),USE(?STRING2)
                           STRING(@s50),AT(1042,750,1625),USE(NAR:Napomena)
                           STRING('Napomena:'),AT(281,750),USE(?STRING3)
                           STRING(@s29),AT(1177,1010,1167),USE(NAR:Rok_placanja)
                           STRING(@n10.2),AT(823,1271),USE(NAR:Ukupno),DECIMAL(14)
                           STRING('Ukupno:'),AT(281,1271),USE(?STRING4)
                           STRING('Rok placanja:'),AT(281,1010),USE(?STRING5)
                           STRING(@s30),AT(4531,1010,740),USE(PLA:Naziv_nacina_placanja)
                           STRING('Nacin placanja'),AT(3573,1010),USE(?STRING6)
                           STRING(@N05),AT(5031,750),USE(NAR:Rbr_roka_isporuke),DECIMAL(14)
                           STRING('Redni br. roka isporuke'),AT(3573,750),USE(?STRING7)
                           STRING(@s30),AT(4667,-1593),USE(OTP:Naziv_nacina_otpreme)
                           STRING(@s30),AT(4531,375,1010),USE(OTP:Naziv_nacina_otpreme,,?OTP:Naziv_nacina_otpreme:2)
                           STRING('Nacin otpreme:'),AT(3573,375),USE(?STRING10)
                           STRING('Broj narudzbenice:'),AT(281,229),USE(?STRING9)
                           LINE,AT(167,1521,5604,0),USE(?LINE1),COLOR(0000008Bh)
                         END
Break_sifra_nacina_otpreme BREAK(OTP:Sifra_nacina_otpreme),USE(?BREAK2)
Detail                     DETAIL,AT(0,0),USE(?Detail)
                             STRING(@s20),AT(937,125,635),USE(DJE:Ime_djelatnika,,?DJE:Ime_djelatnika:2)
                             STRING(@s20),AT(1635,125,656),USE(DJE:Prezime_djelatnika)
                             STRING('Djelatnik'),AT(281,125),USE(?STRING8)
                             STRING(@N010),AT(3573,125),USE(POT:Sifra_uloge_potpisa),DECIMAL(14)
                             STRING(@N5),AT(4906,125),USE(POT:Rbr_potpisa),DECIMAL(14)
                           END
                         END
                         FOOTER,AT(0,0,6250,708),USE(?GROUPFOOTER1)
                           STRING(@s20),AT(531,4542),USE(DJE:Ime_djelatnika)
                         END
                       END
                       FOOTER,AT(1000,9688,6250,281),USE(?Footer)
                         STRING(@N3),AT(5844,31),USE(ReportPageNumber)
                         STRING('Datum izvjesca:'),AT(10,31),USE(?ReportDatePrompt),TRN
                         STRING('<<-- Date Stamp -->'),AT(1177,31),USE(?ReportDateStamp),TRN
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
  GlobalErrors.SetProcedureName('IzvijesceNarudzbenica')
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
  INIMgr.Fetch('IzvijesceNarudzbenica',ProgressWindow)     ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:OTPREME_NACIN, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
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
    INIMgr.Update('IzvijesceNarudzbenica',ProgressWindow)  ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

