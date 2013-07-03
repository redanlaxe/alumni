/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author Desvides
 */
public class Alumni {

    /**
     * Fonction permettant de vérifier un mail
     *
     * @param mail
     * @return boolean true si le mail est valide
     */
    public static boolean verificationMail(String mail) {
        Pattern p = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$");
        Matcher m = p.matcher(mail.toUpperCase());
        return m.matches();
    }

    /**
     * Fonction permettant de vérifier un telephone
     *
     * @param telephone
     * @return boolean true si le telephone est valide
     */
    public static boolean verificationTelephone(String telephone) {
        return true;
    }

    /**
     * Fonction permettant de vérifier un dateNaissance
     *
     * @param dateNaissance
     * @return boolean true si le dateNaissance est valide
     */
    public static boolean verificationDate(String date) {
        if (date.length() != 10) {
            return false;
        }
        for (int i = 0; i < date.length(); i++) {
            if (i == 2 || i == 5) {
                if (date.charAt(i) != '-') {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * Fonction permettant d'upload un fichier dans un dossier donné
     *
     * @param formFile fichier que l'on veut upload
     * @param dossierDest chemin du dossier de destination
     * @param listeExtension liste des extensions acceptées pour l'upload
     * @param tailleMax taille max pour l'upload
     * @param errors ActionMessages dans lequel on va insérer les erreur
     * @param erreurFichier nom de l'erreur pour le fichier
     * @return
     */
    public static ActionMessages uploadFile(FormFile formFile, String dossierDest, List listeExtension, int tailleMax, ActionMessages errors, String erreurFichier) {
        if (formFile.getFileSize() <= tailleMax) {
            // Calcul de l'extension du fichier, vu qu'il manque une méthode pour la connaitre dans FormFile
            String ext = formFile.getFileName().substring(formFile.getFileName().indexOf("."));
            if (listeExtension.contains(ext)) {
                File destination = new File(dossierDest, formFile.getFileName());

                try {
                    FileOutputStream fileOutputStream = new FileOutputStream(destination);

                    byte[] buffer = new byte[formFile.getFileSize()];

                    int bulk;
                    InputStream inputStream = formFile.getInputStream();
                    while (true) {
                        bulk = inputStream.read(buffer);
                        if (bulk < 0) {
                            break;
                        }
                        fileOutputStream.write(buffer, 0, bulk);
                        fileOutputStream.flush();

                        fileOutputStream.close();
                        inputStream.close();
                    }
                } catch (IOException e) {
                    errors.add("errorMessage", new ActionMessage("error.profil." + erreurFichier + ".probleme"));
                    return errors;
                }
            } else {
                errors.add("errorMessage", new ActionMessage("error.profil." + erreurFichier + ".extension"));
            }
        } else {
            errors.add("errorMessage", new ActionMessage("error.profil." + erreurFichier + ".size"));
        }
        return errors;
    }

    public static String sha1(String input) throws NoSuchAlgorithmException {
        MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }

        return sb.toString();
    }

    public static Double moyenne(List<Double> list) {
        double moyenne = 0;
        for (Double val : list) {
            moyenne += val;
        }
        return moyenne / list.size();
    }

    public static <K extends Comparable, V extends Comparable> Map<K, V> sortByValues(Map<K, V> map) {
        List<Map.Entry<K, V>> entries = new LinkedList<Map.Entry<K, V>>(map.entrySet());

        Collections.sort(entries, new Comparator<Map.Entry<K, V>>() {
            @Override
            public int compare(Entry<K, V> o1, Entry<K, V> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });

        //LinkedHashMap will keep the keys in the order they are inserted
        //which is currently sorted on natural ordering
        Map<K, V> sortedMap = new LinkedHashMap<K, V>();

        for (Map.Entry<K, V> entry : entries) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }

        return sortedMap;
    }
}
