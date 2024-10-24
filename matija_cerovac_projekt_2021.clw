   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE

   MAP
     MODULE('MATIJA_CEROVAC_PROJEKT_2021_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('MATIJA_CEROVAC_PROJEKT_2021001.CLW')
Main                   PROCEDURE   !
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
NARUDZBENICA         FILE,DRIVER('TOPSPEED'),PRE(NAR),CREATE,BINDABLE,THREAD !                     
VK_Narudzbenica_NacinOtpreme_sifra_nacina_otpreme KEY(NAR:Sifra_nacina_otpreme),DUP,NOCASE !                     
VK_Narudzbenica_RokIsporuke_rbr_roka_isporuke KEY(NAR:Rbr_roka_isporuke),DUP,NOCASE !                     
VK_Narudzbenica_NacinPlacanja KEY(NAR:Sifra_nacina_placanja),DUP,NOCASE !                     
PK_Narudzbenica_broj_narudzbenice KEY(NAR:Broj_narudzbenice),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Ukupno                      REAL                           !                     
Sifra_nacina_otpreme        REAL                           !                     
Rbr_roka_isporuke           REAL                           !                     
Sifra_nacina_placanja       REAL                           !                     
Broj_narudzbenice           REAL                           !                     
Datum_narudzbenice          DATE                           !                     
Rok_placanja                CSTRING(30)                    !                     
Napomena                    STRING(50)                     !                     
                         END
                     END                       

OTPREME_NACIN        FILE,DRIVER('TOPSPEED'),PRE(OTP),CREATE,BINDABLE,THREAD !                     
PK_NacinOtpreme_sifra_nacina_otpreme KEY(OTP:Sifra_nacina_otpreme),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_nacina_otpreme        REAL                           !                     
Naziv_nacina_otpreme        STRING(30)                     !                     
                         END
                     END                       

ROK_ISPORUKE         FILE,DRIVER('TOPSPEED'),PRE(ROK),CREATE,BINDABLE,THREAD !                     
PK_RokIsporuke_rbr_roka_isporuke KEY(ROK:Rbr_roka_isporuke),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Rbr_roka_isporuke           REAL                           !                     
Naziv_roka_isporuke         STRING(30)                     !                     
                         END
                     END                       

POTPISUJE            FILE,DRIVER('TOPSPEED'),PRE(POT),CREATE,BINDABLE,THREAD !                     
VK_Potpisuje_UlogaPotpisa_sifra_uloge_potpisa KEY(POT:Sifra_uloge_potpisa),DUP,NOCASE !                     
VK_Potpisuje_Djelatnik_mbr_djelatnika KEY(POT:Mbr_djelatnika),DUP,NOCASE !                     
PK_Potpisuje_broj_narudzbenice_rbr_potpisa KEY(POT:Broj_narudzbenice,POT:Rbr_potpisa),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_uloge_potpisa         REAL                           !                     
Mbr_djelatnika              REAL                           !                     
Broj_narudzbenice           REAL                           !                     
Rbr_potpisa                 REAL                           !                     
                         END
                     END                       

ULOGA_POTPISA        FILE,DRIVER('TOPSPEED'),PRE(ULP),CREATE,BINDABLE,THREAD !                     
PK_UlogaPotpisa_sifra_uloge_potpisa KEY(ULP:Sifra_uloge_potpisa),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_uloge_potpisa         REAL                           !                     
Naziv_uloge_potpisa         STRING(30)                     !                     
                         END
                     END                       

DJELATNIK            FILE,DRIVER('TOPSPEED'),PRE(DJE),CREATE,BINDABLE,THREAD !                     
PK_Djelatnik_mbr_djelatnika KEY(DJE:Mbr_djelatnika),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Mbr_djelatnika              REAL                           !                     
Ime_djelatnika              STRING(20)                     !                     
Prezime_djelatnika          STRING(20)                     !                     
                         END
                     END                       

STAVKA               FILE,DRIVER('TOPSPEED'),PRE(STA),CREATE,BINDABLE,THREAD !                     
VK_Stavka_Roba_sifra_robe KEY(STA:Sifra_robe),DUP,NOCASE   !                     
PK_Stavka_broj_narudzbenice_rbr_stavke KEY(STA:Broj_narudzbenice,STA:Rbr_stavke),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_robe                  REAL                           !                     
Broj_narudzbenice           REAL                           !                     
Rbr_stavke                  REAL                           !                     
Kolicina                    CSTRING(20)                    !                     
Iznos_stavke                DECIMAL(7,2)                   !                     
                         END
                     END                       

ROBA                 FILE,DRIVER('TOPSPEED'),PRE(ROB),CREATE,BINDABLE,THREAD !                     
SK_Roba_naziv            KEY(ROB:Naziv_robe),DUP,NOCASE,OPT !                     
SK_Roba_cijena           KEY(ROB:Cijena),DUP,NOCASE,OPT    !                     
VK_Roba_JedinicaMjere_sifra_jedinica_mjere KEY(ROB:Sifra_jedinice_mjere),DUP,NOCASE !                     
PK_Roba_sifra_robe       KEY(ROB:Sifra_robe),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_jedinice_mjere        REAL                           !                     
Sifra_robe                  REAL                           !                     
Naziv_robe                  STRING(30)                     !                     
Cijena                      REAL                           !                     
                         END
                     END                       

JEDINICA_MJERE       FILE,DRIVER('TOPSPEED'),PRE(JED),CREATE,BINDABLE,THREAD !                     
PK_JedinicaMjere_sifra_jedinice_mjere KEY(JED:Sifra_jedinice_mjere),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_jedinice_mjere        REAL                           !                     
Naziv_jedinice_mjere        STRING(20)                     !                     
                         END
                     END                       

ULOGA                FILE,DRIVER('TOPSPEED'),PRE(ULO),CREATE,BINDABLE,THREAD !                     
PK_Uloga_broj_narudzbenice_OIB_stranke KEY(ULO:Broj_narudzbenice,ULO:OIB_stranke),NOCASE,PRIMARY !                     
RK_Uloga_broj_narudzbenice_OIB_stranke KEY(ULO:OIB_stranke,ULO:Broj_narudzbenice),NOCASE !                     
Record                   RECORD,PRE()
OIB_stranke                 REAL                           !                     
Narucitelj_dobavljac        STRING(30)                     !                     
Broj_narudzbenice           REAL                           !                     
                         END
                     END                       

STRANKA              FILE,DRIVER('TOPSPEED'),PRE(STR),CREATE,BINDABLE,THREAD !                     
VK_Stranka_Mjesto_postanski_broj KEY(STR:Postanski_broj),DUP,NOCASE !                     
PK_Stranka_OIB_stranke   KEY(STR:OIB_stranke),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Postanski_broj              CSTRING(40)                    !                     
OIB_stranke                 REAL                           !                     
Naziv_stranke               STRING(30)                     !                     
Adresa_stranke              CSTRING(40)                    !                     
Tel_fax                     CSTRING(30)                    !                     
                         END
                     END                       

MJESTO               FILE,DRIVER('TOPSPEED'),PRE(MJE),CREATE,BINDABLE,THREAD !                     
PK_Mjesto_postanski_broj KEY(MJE:Postanski_broj),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Postanski_broj              CSTRING(40)                    !                     
Naziv_mjesta                STRING(40)                     !                     
                         END
                     END                       

PLACANJA_NACIN       FILE,DRIVER('TOPSPEED'),PRE(PLA),CREATE,BINDABLE,THREAD !                     
PK_NacinPlacanja_sifra_nacina_placanja KEY(PLA:Sifra_nacina_placanja),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_nacina_placanja       REAL                           !                     
Naziv_nacina_placanja       STRING(30)                     !                     
                         END
                     END                       

!endregion

Access:NARUDZBENICA  &FileManager,THREAD                   ! FileManager for NARUDZBENICA
Relate:NARUDZBENICA  &RelationManager,THREAD               ! RelationManager for NARUDZBENICA
Access:OTPREME_NACIN &FileManager,THREAD                   ! FileManager for OTPREME_NACIN
Relate:OTPREME_NACIN &RelationManager,THREAD               ! RelationManager for OTPREME_NACIN
Access:ROK_ISPORUKE  &FileManager,THREAD                   ! FileManager for ROK_ISPORUKE
Relate:ROK_ISPORUKE  &RelationManager,THREAD               ! RelationManager for ROK_ISPORUKE
Access:POTPISUJE     &FileManager,THREAD                   ! FileManager for POTPISUJE
Relate:POTPISUJE     &RelationManager,THREAD               ! RelationManager for POTPISUJE
Access:ULOGA_POTPISA &FileManager,THREAD                   ! FileManager for ULOGA_POTPISA
Relate:ULOGA_POTPISA &RelationManager,THREAD               ! RelationManager for ULOGA_POTPISA
Access:DJELATNIK     &FileManager,THREAD                   ! FileManager for DJELATNIK
Relate:DJELATNIK     &RelationManager,THREAD               ! RelationManager for DJELATNIK
Access:STAVKA        &FileManager,THREAD                   ! FileManager for STAVKA
Relate:STAVKA        &RelationManager,THREAD               ! RelationManager for STAVKA
Access:ROBA          &FileManager,THREAD                   ! FileManager for ROBA
Relate:ROBA          &RelationManager,THREAD               ! RelationManager for ROBA
Access:JEDINICA_MJERE &FileManager,THREAD                  ! FileManager for JEDINICA_MJERE
Relate:JEDINICA_MJERE &RelationManager,THREAD              ! RelationManager for JEDINICA_MJERE
Access:ULOGA         &FileManager,THREAD                   ! FileManager for ULOGA
Relate:ULOGA         &RelationManager,THREAD               ! RelationManager for ULOGA
Access:STRANKA       &FileManager,THREAD                   ! FileManager for STRANKA
Relate:STRANKA       &RelationManager,THREAD               ! RelationManager for STRANKA
Access:MJESTO        &FileManager,THREAD                   ! FileManager for MJESTO
Relate:MJESTO        &RelationManager,THREAD               ! RelationManager for MJESTO
Access:PLACANJA_NACIN &FileManager,THREAD                  ! FileManager for PLACANJA_NACIN
Relate:PLACANJA_NACIN &RelationManager,THREAD              ! RelationManager for PLACANJA_NACIN

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\matija_cerovac_projekt_2021.INI', NVD_INI) ! Configure INIManager to use INI file
  DctInit
  Main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

