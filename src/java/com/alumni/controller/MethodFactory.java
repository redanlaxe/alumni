package com.alumni.controller;

import java.lang.reflect.Method;

public class MethodFactory {

    Class cls = null;
    Object obj = null;

    /**
     *
     * @param nomModel
     * @throws InstantiationException
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     */
    public void instantiate(String nomModel) throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        this.cls = Class.forName(nomModel);
        this.obj = cls.newInstance();
    }

    public Object lancerMethode(Object[] args, String nomMethode) throws Exception {
        Class[] paramTypes = null;
        if (args != null) {
            paramTypes = new Class[args.length];
            for (int i = 0; i < args.length; ++i) {
                paramTypes[i] = args[i].getClass();
            }
        }
        Method m = obj.getClass().getMethod(nomMethode, paramTypes);
        return m.invoke(obj, args);
    }
}
