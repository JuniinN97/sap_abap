REPORT zrelatorio_fornecedores.

TABLES: lfa1.

SELECT-OPTIONS: s_lifnr FOR lfa1-lifnr.  "Intervalo de fornecedores

START-OF-SELECTION.

  WRITE: / 'Código', 15 'Nome', 55 'Cidade'.
  WRITE: / sy-uline.

  SELECT lifnr, name1, ort01
    FROM lfa1
    INTO TABLE @DATA(lt_fornecedores)
    WHERE lifnr IN @s_lifnr.

  LOOP AT lt_fornecedores INTO DATA(ls_fornecedor).
    WRITE: / ls_fornecedor-lifnr, 15 ls_fornecedor-name1, 55 ls_fornecedor-ort01.
  ENDLOOP.
