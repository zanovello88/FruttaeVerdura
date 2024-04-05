package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;

import org.fruttaeverdura.fruttaeverdura.model.dao.PagamentoDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Pagamento;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;

public class PagamentoDAOMySQLJDBCImpl implements PagamentoDAO {
    Connection conn;
    public PagamentoDAOMySQLJDBCImpl(Connection conn){this.conn = conn;}

    @Override
    public Pagamento create(
            //Long id_pagamento
            String numero_carta,
            String scadenza,
            int cvv,
            BigDecimal importo,
            String nome_carta) throws DuplicatedObjectException, DataTruncationException{

        PreparedStatement ps;
        Pagamento pay = new Pagamento();
        pay.setnumero_carta(numero_carta);
        pay.setscadenza(scadenza);
        pay.setcvv(cvv);
        pay.setimporto(importo);
        pay.setnome_carta(nome_carta);

        try {

            String sql
                    = " SELECT * "
                    + " FROM pagamento "
                    + " WHERE "
                    + " numero_carta = ? AND"
                    + " scadenza = ? AND"
                    + " cvv = ? AND"
                    + " importo = ? AND"
                    + " nome_carta = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, pay.getnumero_carta());
            ps.setString(i++, pay.getscadenza());
            ps.setInt(i++, pay.getcvv());
            ps.setBigDecimal(i++, pay.getimporto());
            ps.setString(i++, pay.getnome_carta());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_id_pagamento = null;
            exist = resultSet.next();

            // leggo deleted e id_pagamento solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("deleted").equals("Y");
                retrived_id_pagamento = resultSet.getLong("id_pagamento");
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("PagamentoDAOJDBCImpl.create: Tentativo di inserimento di un prodotto già esistente.");
            }

            if (exist && deleted){
                sql
                        = " UPDATE pagamento "
                        + " SET deleted = 'N' "
                        + " WHERE id_pagamento = ? ";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_id_pagamento);
                ps.executeUpdate();
            }
            else {
                sql
                        = " INSERT INTO pagamento "
                        + "     (numero_carta,"
                        + "     scadenza,"
                        + "     cvv,"
                        + "     importo,"
                        + "     nome_carta"
                        + "   ) "
                        + " VALUES (?,?,?,?,?)";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, pay.getnumero_carta());
                ps.setString(i++, pay.getscadenza());
                ps.setInt(i++, pay.getcvv());
                ps.setBigDecimal(i++, pay.getimporto());
                ps.setString(i++, pay.getnome_carta());

                try {
                    ps.executeUpdate();
                } catch(SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return pay;
    }
    @Override
    public void update(Pagamento pay) throws DuplicatedObjectException{
        PreparedStatement ps;
        String sql;
        try {
            // controllo solo sul numero di carta, il resto non mi interessa
            // controllo se il numero di carta (modificato) è già presente in una tupla
            sql
                    = " SELECT COUNT(*)numero_carta "
                    + " FROM pagamento "
                    + " WHERE "
                    + " id_pagamento != ? AND "
                    + " numero_carta = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, pay.getid_pagamento());
            ps.setString(i++, pay.getnumero_carta());

            ResultSet resultSet = ps.executeQuery();
            int count = 0;

            if(resultSet.next()){
                count = resultSet.getInt(1);
            }

            resultSet.close();
            if(count != 0) {
                throw new DuplicatedObjectException("PagamentoDAOJDBCImpl.create: Tentativo di inserimento di un numero carta già esistente.");
            }
            else {
                //se non esiste prosegui con modifica
                sql
                        = " UPDATE pagamento "
                        + " SET "
                        + " numero_carta = ? ,"
                        + " scadenza = ? ,"
                        + " cvv = ? ,"
                        + " importo = ? , "
                        + " nome_carta = ? ";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, pay.getnumero_carta());
                ps.setString(i++, pay.getscadenza());
                ps.setInt(i++, pay.getcvv());
                ps.setBigDecimal(i++, pay.getimporto());
                ps.setString(i++, pay.getnome_carta());

                ps.executeUpdate();

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Pagamento pay) {
        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE pagamento "
                    + " SET deleted='Y' "
                    + " WHERE "
                    + " id_pagamento=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, pay.getid_pagamento());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    Pagamento read(ResultSet rs) {

        Pagamento pay = new Pagamento();
        try {
            pay.setid_pagamento(rs.getLong("id_pagamento"));
        } catch (SQLException sqle) {
        }
        try {
            pay.setnumero_carta(rs.getString("numero_carta"));
        } catch (SQLException sqle) {
        }
        try {
            pay.setscadenza(rs.getString("scadenza"));
        } catch (SQLException sqle) {
        }
        try {
            pay.setcvv(rs.getInt("cvv"));
        } catch (SQLException sqle) {
        }
        try {
            pay.setimporto(rs.getBigDecimal("importo"));
        } catch (SQLException sqle) {
        }
        try {
            pay.setnome_carta(rs.getString("nome_carta"));
        } catch (SQLException sqle) {
        }

        return pay;
    }
}
