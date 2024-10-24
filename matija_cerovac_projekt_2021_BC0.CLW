  MEMBER('matija_cerovac_projekt_2021.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
matija_cerovac_projekt_2021_BC0:DctInit    PROCEDURE()
matija_cerovac_projekt_2021_BC0:DctKill    PROCEDURE()
matija_cerovac_projekt_2021_BC0:FilesInit  PROCEDURE()
  END

Hide:Access:NARUDZBENICA CLASS(FileManager),TYPE           ! FileManager for NARUDZBENICA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:NARUDZBENICA CLASS(RelationManager),TYPE       ! RelationManager for NARUDZBENICA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:OTPREME_NACIN CLASS(FileManager),TYPE          ! FileManager for OTPREME_NACIN
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:OTPREME_NACIN CLASS(RelationManager),TYPE      ! RelationManager for OTPREME_NACIN
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ROK_ISPORUKE CLASS(FileManager),TYPE           ! FileManager for ROK_ISPORUKE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ROK_ISPORUKE CLASS(RelationManager),TYPE       ! RelationManager for ROK_ISPORUKE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:POTPISUJE CLASS(FileManager),TYPE              ! FileManager for POTPISUJE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:POTPISUJE CLASS(RelationManager),TYPE          ! RelationManager for POTPISUJE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ULOGA_POTPISA CLASS(FileManager),TYPE          ! FileManager for ULOGA_POTPISA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ULOGA_POTPISA CLASS(RelationManager),TYPE      ! RelationManager for ULOGA_POTPISA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:DJELATNIK CLASS(FileManager),TYPE              ! FileManager for DJELATNIK
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:DJELATNIK CLASS(RelationManager),TYPE          ! RelationManager for DJELATNIK
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:STAVKA   CLASS(FileManager),TYPE               ! FileManager for STAVKA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:STAVKA   CLASS(RelationManager),TYPE           ! RelationManager for STAVKA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ROBA     CLASS(FileManager),TYPE               ! FileManager for ROBA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ROBA     CLASS(RelationManager),TYPE           ! RelationManager for ROBA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:JEDINICA_MJERE CLASS(FileManager),TYPE         ! FileManager for JEDINICA_MJERE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:JEDINICA_MJERE CLASS(RelationManager),TYPE     ! RelationManager for JEDINICA_MJERE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ULOGA    CLASS(FileManager),TYPE               ! FileManager for ULOGA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ULOGA    CLASS(RelationManager),TYPE           ! RelationManager for ULOGA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:STRANKA  CLASS(FileManager),TYPE               ! FileManager for STRANKA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:STRANKA  CLASS(RelationManager),TYPE           ! RelationManager for STRANKA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:MJESTO   CLASS(FileManager),TYPE               ! FileManager for MJESTO
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:MJESTO   CLASS(RelationManager),TYPE           ! RelationManager for MJESTO
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:PLACANJA_NACIN CLASS(FileManager),TYPE         ! FileManager for PLACANJA_NACIN
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:PLACANJA_NACIN CLASS(RelationManager),TYPE     ! RelationManager for PLACANJA_NACIN
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:NARUDZBENICA &Hide:Access:NARUDZBENICA,AUTO,THREAD
_Hide:Relate:NARUDZBENICA &Hide:Relate:NARUDZBENICA,AUTO,THREAD
_Hide:Access:OTPREME_NACIN &Hide:Access:OTPREME_NACIN,AUTO,THREAD
_Hide:Relate:OTPREME_NACIN &Hide:Relate:OTPREME_NACIN,AUTO,THREAD
_Hide:Access:ROK_ISPORUKE &Hide:Access:ROK_ISPORUKE,AUTO,THREAD
_Hide:Relate:ROK_ISPORUKE &Hide:Relate:ROK_ISPORUKE,AUTO,THREAD
_Hide:Access:POTPISUJE &Hide:Access:POTPISUJE,AUTO,THREAD
_Hide:Relate:POTPISUJE &Hide:Relate:POTPISUJE,AUTO,THREAD
_Hide:Access:ULOGA_POTPISA &Hide:Access:ULOGA_POTPISA,AUTO,THREAD
_Hide:Relate:ULOGA_POTPISA &Hide:Relate:ULOGA_POTPISA,AUTO,THREAD
_Hide:Access:DJELATNIK &Hide:Access:DJELATNIK,AUTO,THREAD
_Hide:Relate:DJELATNIK &Hide:Relate:DJELATNIK,AUTO,THREAD
_Hide:Access:STAVKA  &Hide:Access:STAVKA,AUTO,THREAD
_Hide:Relate:STAVKA  &Hide:Relate:STAVKA,AUTO,THREAD
_Hide:Access:ROBA    &Hide:Access:ROBA,AUTO,THREAD
_Hide:Relate:ROBA    &Hide:Relate:ROBA,AUTO,THREAD
_Hide:Access:JEDINICA_MJERE &Hide:Access:JEDINICA_MJERE,AUTO,THREAD
_Hide:Relate:JEDINICA_MJERE &Hide:Relate:JEDINICA_MJERE,AUTO,THREAD
_Hide:Access:ULOGA   &Hide:Access:ULOGA,AUTO,THREAD
_Hide:Relate:ULOGA   &Hide:Relate:ULOGA,AUTO,THREAD
_Hide:Access:STRANKA &Hide:Access:STRANKA,AUTO,THREAD
_Hide:Relate:STRANKA &Hide:Relate:STRANKA,AUTO,THREAD
_Hide:Access:MJESTO  &Hide:Access:MJESTO,AUTO,THREAD
_Hide:Relate:MJESTO  &Hide:Relate:MJESTO,AUTO,THREAD
_Hide:Access:PLACANJA_NACIN &Hide:Access:PLACANJA_NACIN,AUTO,THREAD
_Hide:Relate:PLACANJA_NACIN &Hide:Relate:PLACANJA_NACIN,AUTO,THREAD


matija_cerovac_projekt_2021_BC0:DctInit PROCEDURE()
  CODE
  _Hide:Access:NARUDZBENICA &= NEW(Hide:Access:NARUDZBENICA)
  _Hide:Relate:NARUDZBENICA &= NEW(Hide:Relate:NARUDZBENICA)
  _Hide:Access:OTPREME_NACIN &= NEW(Hide:Access:OTPREME_NACIN)
  _Hide:Relate:OTPREME_NACIN &= NEW(Hide:Relate:OTPREME_NACIN)
  _Hide:Access:ROK_ISPORUKE &= NEW(Hide:Access:ROK_ISPORUKE)
  _Hide:Relate:ROK_ISPORUKE &= NEW(Hide:Relate:ROK_ISPORUKE)
  _Hide:Access:POTPISUJE &= NEW(Hide:Access:POTPISUJE)
  _Hide:Relate:POTPISUJE &= NEW(Hide:Relate:POTPISUJE)
  _Hide:Access:ULOGA_POTPISA &= NEW(Hide:Access:ULOGA_POTPISA)
  _Hide:Relate:ULOGA_POTPISA &= NEW(Hide:Relate:ULOGA_POTPISA)
  _Hide:Access:DJELATNIK &= NEW(Hide:Access:DJELATNIK)
  _Hide:Relate:DJELATNIK &= NEW(Hide:Relate:DJELATNIK)
  _Hide:Access:STAVKA &= NEW(Hide:Access:STAVKA)
  _Hide:Relate:STAVKA &= NEW(Hide:Relate:STAVKA)
  _Hide:Access:ROBA &= NEW(Hide:Access:ROBA)
  _Hide:Relate:ROBA &= NEW(Hide:Relate:ROBA)
  _Hide:Access:JEDINICA_MJERE &= NEW(Hide:Access:JEDINICA_MJERE)
  _Hide:Relate:JEDINICA_MJERE &= NEW(Hide:Relate:JEDINICA_MJERE)
  _Hide:Access:ULOGA &= NEW(Hide:Access:ULOGA)
  _Hide:Relate:ULOGA &= NEW(Hide:Relate:ULOGA)
  _Hide:Access:STRANKA &= NEW(Hide:Access:STRANKA)
  _Hide:Relate:STRANKA &= NEW(Hide:Relate:STRANKA)
  _Hide:Access:MJESTO &= NEW(Hide:Access:MJESTO)
  _Hide:Relate:MJESTO &= NEW(Hide:Relate:MJESTO)
  _Hide:Access:PLACANJA_NACIN &= NEW(Hide:Access:PLACANJA_NACIN)
  _Hide:Relate:PLACANJA_NACIN &= NEW(Hide:Relate:PLACANJA_NACIN)
  Relate:NARUDZBENICA &= _Hide:Relate:NARUDZBENICA
  Relate:OTPREME_NACIN &= _Hide:Relate:OTPREME_NACIN
  Relate:ROK_ISPORUKE &= _Hide:Relate:ROK_ISPORUKE
  Relate:POTPISUJE &= _Hide:Relate:POTPISUJE
  Relate:ULOGA_POTPISA &= _Hide:Relate:ULOGA_POTPISA
  Relate:DJELATNIK &= _Hide:Relate:DJELATNIK
  Relate:STAVKA &= _Hide:Relate:STAVKA
  Relate:ROBA &= _Hide:Relate:ROBA
  Relate:JEDINICA_MJERE &= _Hide:Relate:JEDINICA_MJERE
  Relate:ULOGA &= _Hide:Relate:ULOGA
  Relate:STRANKA &= _Hide:Relate:STRANKA
  Relate:MJESTO &= _Hide:Relate:MJESTO
  Relate:PLACANJA_NACIN &= _Hide:Relate:PLACANJA_NACIN


matija_cerovac_projekt_2021_BC0:FilesInit PROCEDURE()
  CODE
  _Hide:Relate:NARUDZBENICA.Init
  _Hide:Relate:OTPREME_NACIN.Init
  _Hide:Relate:ROK_ISPORUKE.Init
  _Hide:Relate:POTPISUJE.Init
  _Hide:Relate:ULOGA_POTPISA.Init
  _Hide:Relate:DJELATNIK.Init
  _Hide:Relate:STAVKA.Init
  _Hide:Relate:ROBA.Init
  _Hide:Relate:JEDINICA_MJERE.Init
  _Hide:Relate:ULOGA.Init
  _Hide:Relate:STRANKA.Init
  _Hide:Relate:MJESTO.Init
  _Hide:Relate:PLACANJA_NACIN.Init


matija_cerovac_projekt_2021_BC0:DctKill PROCEDURE()
  CODE
  _Hide:Relate:NARUDZBENICA.Kill
  DISPOSE(_Hide:Relate:NARUDZBENICA)
  _Hide:Relate:OTPREME_NACIN.Kill
  DISPOSE(_Hide:Relate:OTPREME_NACIN)
  _Hide:Relate:ROK_ISPORUKE.Kill
  DISPOSE(_Hide:Relate:ROK_ISPORUKE)
  _Hide:Relate:POTPISUJE.Kill
  DISPOSE(_Hide:Relate:POTPISUJE)
  _Hide:Relate:ULOGA_POTPISA.Kill
  DISPOSE(_Hide:Relate:ULOGA_POTPISA)
  _Hide:Relate:DJELATNIK.Kill
  DISPOSE(_Hide:Relate:DJELATNIK)
  _Hide:Relate:STAVKA.Kill
  DISPOSE(_Hide:Relate:STAVKA)
  _Hide:Relate:ROBA.Kill
  DISPOSE(_Hide:Relate:ROBA)
  _Hide:Relate:JEDINICA_MJERE.Kill
  DISPOSE(_Hide:Relate:JEDINICA_MJERE)
  _Hide:Relate:ULOGA.Kill
  DISPOSE(_Hide:Relate:ULOGA)
  _Hide:Relate:STRANKA.Kill
  DISPOSE(_Hide:Relate:STRANKA)
  _Hide:Relate:MJESTO.Kill
  DISPOSE(_Hide:Relate:MJESTO)
  _Hide:Relate:PLACANJA_NACIN.Kill
  DISPOSE(_Hide:Relate:PLACANJA_NACIN)


Hide:Relate:NARUDZBENICA.Init PROCEDURE()
  CODE
  _Hide:Access:NARUDZBENICA.Init
  SELF.Init(Access:NARUDZBENICA,1)


Hide:Access:NARUDZBENICA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= NAR:Record
  SELF.FileNameValue = 'NARUDZBENICA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= NARUDZBENICA
  PARENT.Init
  Access:NARUDZBENICA &= SELF


Hide:Access:NARUDZBENICA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:NARUDZBENICA &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:NARUDZBENICA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(NARUDZBENICA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(NAR:VK_Narudzbenica_NacinOtpreme_sifra_nacina_otpreme,'NAR:VK_Narudzbenica_NacinOtpreme_sifra_nacina_otpreme',0)
    SELF.AddKey(NAR:VK_Narudzbenica_RokIsporuke_rbr_roka_isporuke,'NAR:VK_Narudzbenica_RokIsporuke_rbr_roka_isporuke',0)
    SELF.AddKey(NAR:VK_Narudzbenica_NacinPlacanja,'NAR:VK_Narudzbenica_NacinPlacanja',0)
    SELF.AddKey(NAR:PK_Narudzbenica_broj_narudzbenice,'NAR:PK_Narudzbenica_broj_narudzbenice',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:NARUDZBENICA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:OTPREME_NACIN,RI:None,RI:None,OTP:PK_NacinOtpreme_sifra_nacina_otpreme)
  SELF.AddRelationLink(NAR:Sifra_nacina_otpreme,OTP:Sifra_nacina_otpreme)

  SELF.AddRelation(Relate:ROK_ISPORUKE,RI:None,RI:None,ROK:PK_RokIsporuke_rbr_roka_isporuke)
  SELF.AddRelationLink(NAR:Rbr_roka_isporuke,ROK:Rbr_roka_isporuke)

  SELF.AddRelation(Relate:PLACANJA_NACIN,RI:None,RI:None,PLA:PK_NacinPlacanja_sifra_nacina_placanja)
  SELF.AddRelationLink(NAR:Sifra_nacina_placanja,PLA:Sifra_nacina_placanja)

  SELF.AddRelation(Relate:POTPISUJE,RI:CASCADE,RI:CASCADE,POT:PK_Potpisuje_broj_narudzbenice_rbr_potpisa)
  SELF.AddRelationLink(NAR:Broj_narudzbenice,POT:Broj_narudzbenice)

  SELF.AddRelation(Relate:ULOGA,RI:CASCADE,RI:CASCADE,ULO:PK_Uloga_broj_narudzbenice_OIB_stranke)
  SELF.AddRelationLink(NAR:Broj_narudzbenice,ULO:Broj_narudzbenice)

  SELF.AddRelation(Relate:STAVKA,RI:CASCADE,RI:CASCADE,STA:PK_Stavka_broj_narudzbenice_rbr_stavke)
  SELF.AddRelationLink(NAR:Broj_narudzbenice,STA:Broj_narudzbenice)


Hide:Relate:NARUDZBENICA.Kill PROCEDURE

  CODE
  _Hide:Access:NARUDZBENICA.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:NARUDZBENICA &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:NARUDZBENICA)                       ! destroy the file manager


Hide:Relate:OTPREME_NACIN.Init PROCEDURE()
  CODE
  _Hide:Access:OTPREME_NACIN.Init
  SELF.Init(Access:OTPREME_NACIN,1)


Hide:Access:OTPREME_NACIN.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= OTP:Record
  SELF.FileNameValue = 'OTPREME_NACIN'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= OTPREME_NACIN
  PARENT.Init
  Access:OTPREME_NACIN &= SELF


Hide:Access:OTPREME_NACIN.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:OTPREME_NACIN &= NULL                             ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:OTPREME_NACIN.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(OTPREME_NACIN,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(OTP:PK_NacinOtpreme_sifra_nacina_otpreme,'OTP:PK_NacinOtpreme_sifra_nacina_otpreme',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:OTPREME_NACIN.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA)


Hide:Relate:OTPREME_NACIN.Kill PROCEDURE

  CODE
  _Hide:Access:OTPREME_NACIN.Kill                          ! Kill the file manager
  PARENT.Kill
  Relate:OTPREME_NACIN &= NULL                             ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:OTPREME_NACIN)                      ! destroy the file manager


Hide:Relate:ROK_ISPORUKE.Init PROCEDURE()
  CODE
  _Hide:Access:ROK_ISPORUKE.Init
  SELF.Init(Access:ROK_ISPORUKE,1)


Hide:Access:ROK_ISPORUKE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ROK:Record
  SELF.FileNameValue = 'ROK_ISPORUKE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ROK_ISPORUKE
  PARENT.Init
  Access:ROK_ISPORUKE &= SELF


Hide:Access:ROK_ISPORUKE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ROK_ISPORUKE &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ROK_ISPORUKE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ROK_ISPORUKE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ROK:PK_RokIsporuke_rbr_roka_isporuke,'ROK:PK_RokIsporuke_rbr_roka_isporuke',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ROK_ISPORUKE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA)


Hide:Relate:ROK_ISPORUKE.Kill PROCEDURE

  CODE
  _Hide:Access:ROK_ISPORUKE.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:ROK_ISPORUKE &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ROK_ISPORUKE)                       ! destroy the file manager


Hide:Relate:POTPISUJE.Init PROCEDURE()
  CODE
  _Hide:Access:POTPISUJE.Init
  SELF.Init(Access:POTPISUJE,1)


Hide:Access:POTPISUJE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= POT:Record
  SELF.FileNameValue = 'POTPISUJE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= POTPISUJE
  PARENT.Init
  Access:POTPISUJE &= SELF


Hide:Access:POTPISUJE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:POTPISUJE &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:POTPISUJE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(POTPISUJE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(POT:VK_Potpisuje_UlogaPotpisa_sifra_uloge_potpisa,'POT:VK_Potpisuje_UlogaPotpisa_sifra_uloge_potpisa',0)
    SELF.AddKey(POT:VK_Potpisuje_Djelatnik_mbr_djelatnika,'POT:VK_Potpisuje_Djelatnik_mbr_djelatnika',0)
    SELF.AddKey(POT:PK_Potpisuje_broj_narudzbenice_rbr_potpisa,'POT:PK_Potpisuje_broj_narudzbenice_rbr_potpisa',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:POTPISUJE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA)

  SELF.AddRelation(Relate:ULOGA_POTPISA)

  SELF.AddRelation(Relate:DJELATNIK,RI:None,RI:None,DJE:PK_Djelatnik_mbr_djelatnika)
  SELF.AddRelationLink(POT:Mbr_djelatnika,DJE:Mbr_djelatnika)


Hide:Relate:POTPISUJE.Kill PROCEDURE

  CODE
  _Hide:Access:POTPISUJE.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:POTPISUJE &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:POTPISUJE)                          ! destroy the file manager


Hide:Relate:ULOGA_POTPISA.Init PROCEDURE()
  CODE
  _Hide:Access:ULOGA_POTPISA.Init
  SELF.Init(Access:ULOGA_POTPISA,1)


Hide:Access:ULOGA_POTPISA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ULP:Record
  SELF.FileNameValue = 'ULOGA_POTPISA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ULOGA_POTPISA
  PARENT.Init
  Access:ULOGA_POTPISA &= SELF


Hide:Access:ULOGA_POTPISA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ULOGA_POTPISA &= NULL                             ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ULOGA_POTPISA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ULOGA_POTPISA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ULP:PK_UlogaPotpisa_sifra_uloge_potpisa,'ULP:PK_UlogaPotpisa_sifra_uloge_potpisa',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ULOGA_POTPISA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POTPISUJE,RI:None,RI:None,POT:VK_Potpisuje_UlogaPotpisa_sifra_uloge_potpisa)
  SELF.AddRelationLink(ULP:Sifra_uloge_potpisa,POT:Sifra_uloge_potpisa)


Hide:Relate:ULOGA_POTPISA.Kill PROCEDURE

  CODE
  _Hide:Access:ULOGA_POTPISA.Kill                          ! Kill the file manager
  PARENT.Kill
  Relate:ULOGA_POTPISA &= NULL                             ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ULOGA_POTPISA)                      ! destroy the file manager


Hide:Relate:DJELATNIK.Init PROCEDURE()
  CODE
  _Hide:Access:DJELATNIK.Init
  SELF.Init(Access:DJELATNIK,1)


Hide:Access:DJELATNIK.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= DJE:Record
  SELF.FileNameValue = 'DJELATNIK'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= DJELATNIK
  PARENT.Init
  Access:DJELATNIK &= SELF


Hide:Access:DJELATNIK.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:DJELATNIK &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:DJELATNIK.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(DJELATNIK,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(DJE:PK_Djelatnik_mbr_djelatnika,'DJE:PK_Djelatnik_mbr_djelatnika',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:DJELATNIK.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POTPISUJE)


Hide:Relate:DJELATNIK.Kill PROCEDURE

  CODE
  _Hide:Access:DJELATNIK.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:DJELATNIK &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:DJELATNIK)                          ! destroy the file manager


Hide:Relate:STAVKA.Init PROCEDURE()
  CODE
  _Hide:Access:STAVKA.Init
  SELF.Init(Access:STAVKA,1)


Hide:Access:STAVKA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= STA:Record
  SELF.FileNameValue = 'STAVKA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= STAVKA
  PARENT.Init
  Access:STAVKA &= SELF


Hide:Access:STAVKA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:STAVKA &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:STAVKA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(STAVKA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(STA:VK_Stavka_Roba_sifra_robe,'STA:VK_Stavka_Roba_sifra_robe',0)
    SELF.AddKey(STA:PK_Stavka_broj_narudzbenice_rbr_stavke,'STA:PK_Stavka_broj_narudzbenice_rbr_stavke',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:STAVKA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA)

  SELF.AddRelation(Relate:ROBA,RI:None,RI:None,ROB:PK_Roba_sifra_robe)
  SELF.AddRelationLink(STA:Sifra_robe,ROB:Sifra_robe)


Hide:Relate:STAVKA.Kill PROCEDURE

  CODE
  _Hide:Access:STAVKA.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:STAVKA &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:STAVKA)                             ! destroy the file manager


Hide:Relate:ROBA.Init PROCEDURE()
  CODE
  _Hide:Access:ROBA.Init
  SELF.Init(Access:ROBA,1)


Hide:Access:ROBA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ROB:Record
  SELF.FileNameValue = 'ROBA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ROBA
  PARENT.Init
  Access:ROBA &= SELF


Hide:Access:ROBA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ROBA &= NULL                                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ROBA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ROBA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ROB:SK_Roba_naziv,'ROB:SK_Roba_naziv',0)
    SELF.AddKey(ROB:SK_Roba_cijena,'ROB:SK_Roba_cijena',0)
    SELF.AddKey(ROB:VK_Roba_JedinicaMjere_sifra_jedinica_mjere,'ROB:VK_Roba_JedinicaMjere_sifra_jedinica_mjere',0)
    SELF.AddKey(ROB:PK_Roba_sifra_robe,'ROB:PK_Roba_sifra_robe',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ROBA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:STAVKA)

  SELF.AddRelation(Relate:JEDINICA_MJERE,RI:None,RI:None,JED:PK_JedinicaMjere_sifra_jedinice_mjere)
  SELF.AddRelationLink(ROB:Sifra_jedinice_mjere,JED:Sifra_jedinice_mjere)


Hide:Relate:ROBA.Kill PROCEDURE

  CODE
  _Hide:Access:ROBA.Kill                                   ! Kill the file manager
  PARENT.Kill
  Relate:ROBA &= NULL                                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ROBA)                               ! destroy the file manager


Hide:Relate:JEDINICA_MJERE.Init PROCEDURE()
  CODE
  _Hide:Access:JEDINICA_MJERE.Init
  SELF.Init(Access:JEDINICA_MJERE,1)


Hide:Access:JEDINICA_MJERE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= JED:Record
  SELF.FileNameValue = 'JEDINICA_MJERE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= JEDINICA_MJERE
  PARENT.Init
  Access:JEDINICA_MJERE &= SELF


Hide:Access:JEDINICA_MJERE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:JEDINICA_MJERE &= NULL                            ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:JEDINICA_MJERE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(JEDINICA_MJERE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(JED:PK_JedinicaMjere_sifra_jedinice_mjere,'JED:PK_JedinicaMjere_sifra_jedinice_mjere',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:JEDINICA_MJERE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:ROBA)


Hide:Relate:JEDINICA_MJERE.Kill PROCEDURE

  CODE
  _Hide:Access:JEDINICA_MJERE.Kill                         ! Kill the file manager
  PARENT.Kill
  Relate:JEDINICA_MJERE &= NULL                            ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:JEDINICA_MJERE)                     ! destroy the file manager


Hide:Relate:ULOGA.Init PROCEDURE()
  CODE
  _Hide:Access:ULOGA.Init
  SELF.Init(Access:ULOGA,1)


Hide:Access:ULOGA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ULO:Record
  SELF.FileNameValue = 'ULOGA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ULOGA
  PARENT.Init
  Access:ULOGA &= SELF


Hide:Access:ULOGA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ULOGA &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ULOGA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ULOGA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ULO:PK_Uloga_broj_narudzbenice_OIB_stranke,'ULO:PK_Uloga_broj_narudzbenice_OIB_stranke',0)
    SELF.AddKey(ULO:RK_Uloga_broj_narudzbenice_OIB_stranke,'ULO:RK_Uloga_broj_narudzbenice_OIB_stranke',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ULOGA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA)

  SELF.AddRelation(Relate:STRANKA)


Hide:Relate:ULOGA.Kill PROCEDURE

  CODE
  _Hide:Access:ULOGA.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:ULOGA &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ULOGA)                              ! destroy the file manager


Hide:Relate:STRANKA.Init PROCEDURE()
  CODE
  _Hide:Access:STRANKA.Init
  SELF.Init(Access:STRANKA,1)


Hide:Access:STRANKA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= STR:Record
  SELF.FileNameValue = 'STRANKA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= STRANKA
  PARENT.Init
  Access:STRANKA &= SELF


Hide:Access:STRANKA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:STRANKA &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:STRANKA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(STRANKA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(STR:VK_Stranka_Mjesto_postanski_broj,'STR:VK_Stranka_Mjesto_postanski_broj',0)
    SELF.AddKey(STR:PK_Stranka_OIB_stranke,'STR:PK_Stranka_OIB_stranke',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:STRANKA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:ULOGA,RI:CASCADE,RI:CASCADE,ULO:RK_Uloga_broj_narudzbenice_OIB_stranke)
  SELF.AddRelationLink(STR:OIB_stranke,ULO:OIB_stranke)

  SELF.AddRelation(Relate:MJESTO,RI:None,RI:None,MJE:PK_Mjesto_postanski_broj)
  SELF.AddRelationLink(STR:Postanski_broj,MJE:Postanski_broj)


Hide:Relate:STRANKA.Kill PROCEDURE

  CODE
  _Hide:Access:STRANKA.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:STRANKA &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:STRANKA)                            ! destroy the file manager


Hide:Relate:MJESTO.Init PROCEDURE()
  CODE
  _Hide:Access:MJESTO.Init
  SELF.Init(Access:MJESTO,1)


Hide:Access:MJESTO.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= MJE:Record
  SELF.FileNameValue = 'MJESTO'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= MJESTO
  PARENT.Init
  Access:MJESTO &= SELF


Hide:Access:MJESTO.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:MJESTO &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:MJESTO.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(MJESTO,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(MJE:PK_Mjesto_postanski_broj,'MJE:PK_Mjesto_postanski_broj',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:MJESTO.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:STRANKA)


Hide:Relate:MJESTO.Kill PROCEDURE

  CODE
  _Hide:Access:MJESTO.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:MJESTO &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:MJESTO)                             ! destroy the file manager


Hide:Relate:PLACANJA_NACIN.Init PROCEDURE()
  CODE
  _Hide:Access:PLACANJA_NACIN.Init
  SELF.Init(Access:PLACANJA_NACIN,1)


Hide:Access:PLACANJA_NACIN.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PLA:Record
  SELF.FileNameValue = 'PLACANJA_NACIN'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PLACANJA_NACIN
  PARENT.Init
  Access:PLACANJA_NACIN &= SELF


Hide:Access:PLACANJA_NACIN.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PLACANJA_NACIN &= NULL                            ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PLACANJA_NACIN.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PLACANJA_NACIN,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PLA:PK_NacinPlacanja_sifra_nacina_placanja,'PLA:PK_NacinPlacanja_sifra_nacina_placanja',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PLACANJA_NACIN.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA)


Hide:Relate:PLACANJA_NACIN.Kill PROCEDURE

  CODE
  _Hide:Access:PLACANJA_NACIN.Kill                         ! Kill the file manager
  PARENT.Kill
  Relate:PLACANJA_NACIN &= NULL                            ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PLACANJA_NACIN)                     ! destroy the file manager

