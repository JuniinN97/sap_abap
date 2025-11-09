REPORT zrelatorio_clientes_alv.

*---------------------------------------------------------------------
* Declarações de seleção (entrada do usuário)
*---------------------------------------------------------------------
PARAMETERS: p_land1 TYPE kna1-land1 OBLIGATORY,  "País obrigatório
            p_ort01 TYPE kna1-ort01 OPTIONAL.     "Cidade opcional

*---------------------------------------------------------------------
* Seleção de dados
*---------------------------------------------------------------------
DATA: lt_clientes TYPE TABLE OF kna1,
      lv_msg      TYPE string.

SELECT kunnr, name1, ort01, land1
  FROM kna1
  INTO TABLE @lt_clientes
  WHERE land1 = @p_land1
    AND ( @p_ort01 IS INITIAL OR ort01 = @p_ort01 ).

IF sy-subrc <> 0.
  lv_msg = |Nenhum cliente encontrado para o país { p_land1 }|.
  MESSAGE lv_msg TYPE 'I'.
  LEAVE PROGRAM.
ENDIF.

*---------------------------------------------------------------------
* Exibição em ALV (tabela interativa)
*---------------------------------------------------------------------
DATA: lo_alv TYPE REF TO cl_salv_table.

TRY.
    cl_salv_table=>factory(
      IMPORTING r_salv_table = lo_alv
      CHANGING  t_table      = lt_clientes
    ).

    lo_alv->get_display_settings( )->set_striped_pattern( abap_true ).
    lo_alv->get_functions( )->set_all( abap_true ).
    lo_alv->get_columns( )->set_optimize( abap_true ).

    lo_alv->display( ).

  CATCH cx_salv_msg INTO DATA(lx_msg).
    MESSAGE lx_msg->get_text( ) TYPE 'E'.
ENDTRY.
