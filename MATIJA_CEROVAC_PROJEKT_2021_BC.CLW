  MEMBER('matija_cerovac_projekt_2021.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('matija_cerovac_projekt_2021_BC0.CLW')
matija_cerovac_projekt_2021_BC0:DctInit             PROCEDURE()
matija_cerovac_projekt_2021_BC0:DctKill             PROCEDURE()
matija_cerovac_projekt_2021_BC0:FilesInit           PROCEDURE()
    END
  END

DctInit PROCEDURE()
  CODE
  matija_cerovac_projekt_2021_BC0:DctInit
  matija_cerovac_projekt_2021_BC0:FilesInit


DctKill PROCEDURE()
  CODE
  matija_cerovac_projekt_2021_BC0:DctKill

