/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

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
