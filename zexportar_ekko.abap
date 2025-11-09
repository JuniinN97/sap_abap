REPORT zexportar_ekko_excel.

DATA: lt_ekko TYPE TABLE OF ekko,
      lv_filename TYPE string VALUE 'C:\temp\export_ekko.xls'.

SELECT ebeln, lifnr, bukrs, aedat
  FROM ekko
  INTO TABLE @lt_ekko
  UP TO 100 ROWS.

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  TABLES
    data_tab = lt_ekko
  EXCEPTIONS
    OTHERS   = 1.

IF sy-subrc = 0.
  MESSAGE 'Exportação concluída com sucesso!' TYPE 'S'.
ELSE.
  MESSAGE 'Erro ao exportar arquivo!' TYPE 'E'.
ENDIF.
