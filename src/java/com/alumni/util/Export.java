/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Hyperlink;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Desvides
 */
public class Export {

    private Workbook workbook;
    private int height;
    private FileOutputStream fileOut;

    public Export(String path) throws FileNotFoundException {
        fileOut = new FileOutputStream(path);
        workbook = new XSSFWorkbook();
    }

    public void finishExcel() throws IOException {
        workbook.write(fileOut);
        fileOut.close();
    }

    public void createFeuille2CI(String titleSheet, String titleA, ArrayList<String> listA, String titleB, ArrayList<Integer> listB) throws IOException {
        this.height = listA.size();
        Sheet sheet = workbook.createSheet(titleSheet);
        Row row = sheet.createRow(0);

        Cell cell = row.createCell(0);
        cell.setCellValue(titleA);

        cell = row.createCell(1);
        cell.setCellValue(titleB);
        for (int i = 1; i < this.height + 1; i++) {
            row = sheet.createRow(i);

            cell = row.createCell(0);
            cell.setCellValue(listA.get(i - 1));

            cell = row.createCell(1);
            cell.setCellValue(listB.get(i - 1));
        }
        sheet.autoSizeColumn((short) 0);
        sheet.autoSizeColumn((short) 1);
    }

    public void createFeuille2CD(String titleSheet, String titleA, ArrayList<String> listA, String titleB, ArrayList<Double> listB) throws IOException {
        this.height = listA.size();
        Sheet sheet = workbook.createSheet(titleSheet);
        Row row = sheet.createRow(0);

        Cell cell = row.createCell(0);
        cell.setCellValue(titleA);

        cell = row.createCell(1);
        cell.setCellValue(titleB);

        for (int i = 1; i < this.height + 1; i++) {
            row = sheet.createRow(i);

            cell = row.createCell(0);
            cell.setCellValue(listA.get(i - 1));

            cell = row.createCell(1);
            cell.setCellValue(listB.get(i - 1));
        }
        sheet.autoSizeColumn((short) 0);
        sheet.autoSizeColumn((short) 1);
    }

    public void createFeuilleSalaireEtudiant(String titleSheet, ArrayList listSalaireActuelEtudiant) {
        this.height = listSalaireActuelEtudiant.size();
        Sheet sheet = workbook.createSheet(titleSheet);
        Row row = sheet.createRow(0);

        Cell cell = row.createCell(0);
        cell.setCellValue("ID ETUDIANT");

        cell = row.createCell(1);
        cell.setCellValue("PRENOM");

        cell = row.createCell(2);
        cell.setCellValue("NOM");

        cell = row.createCell(3);
        cell.setCellValue("POSTE");

        cell = row.createCell(4);
        cell.setCellValue("SALAIRE");

        Double salaire_moyen = 0.0;

        for (int i = 1; i < this.height + 1; i++) {
            row = sheet.createRow(i);

            ArrayList al_tmp = (ArrayList) listSalaireActuelEtudiant.get(i - 1);

            cell = row.createCell(0);
            cell.setCellValue((Integer) al_tmp.get(0));

            cell = row.createCell(1);
            cell.setCellValue((String) al_tmp.get(1));

            cell = row.createCell(2);
            cell.setCellValue((String) al_tmp.get(2));

            cell = row.createCell(3);
            cell.setCellValue((String) al_tmp.get(3));

            cell = row.createCell(4);
            Double salaire = (Double) al_tmp.get(4);
            cell.setCellValue(salaire);
            salaire_moyen += salaire;
        }

        row = sheet.createRow(this.height + 1);
        cell = row.createCell(3);
        cell.setCellValue("SALAIRE MOYEN :");
        cell = row.createCell(4);
        cell.setCellValue(salaire_moyen / this.height);

        sheet.autoSizeColumn((short) 0);
        sheet.autoSizeColumn((short) 1);
        sheet.autoSizeColumn((short) 2);
        sheet.autoSizeColumn((short) 3);
    }
}
